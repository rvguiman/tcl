#!/bin/sh
# next line starts using tclsh \
exec /bin/tclsh "$0" ${1+"$@"}

#---------------------------------------------------------------------------#
# what: sample ssl client , snit type oo version :see non oo at network folder
# author: ricardo
#---------------------------------------------------------------------------#

# lappend ::auto_path /your_tcllib_package/dir/lib

package require tls 1.5
package require snit

snit::type SecClient {
    # options are lower case
    option -server "localhost"
    option -portn 6600
    
    # ssl client certificate vars
    option -cacert "ca.crt"
    option -clientcert "client.crt"
    option -clientkey "client.key"
    option -pphrase ""
    
    method outPass { } {
        return [$self cget -pphrase]
    }
    
    method sendTo { toStr } {
        if { [$self cget -pphrase] == "" } {
            set soChan [::tl::socket -cafile [$self cget -cacert] -certfile [$self cget -clientcert] -keyfile [$self cget -clientkey] \
                -ssl3 1 -require 1 -request 1 [$self cget -server] [$self cget -portn] ]
        } else {
            set soChan [::tl::socket -cafile [$self cget -cacert] -certfile [$self cget -clientcert] -keyfile [$self cget -clientkey] \
                -password { $self outPass } -ssl3 1 -require 1 -request 1 [$self cget -server] [$self cget -portn] ]
        }
        puts $soChan $toStr
        flush $soChan
        gets $soChan gotLine
        close $soChan
        puts "from server: $gotLine
    }
}

::SecClient clientObj -server "localhost" -portn 9900
::clientObj sendTo "test string"
