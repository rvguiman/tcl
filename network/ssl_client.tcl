#!/bin/sh
# next line starts using tclsh \
exec /bin/tclsh "$0" ${1+"$@"}

#-------------------------------------------------
# what: sample ssl client
# author: ricardo
#-------------------------------------------------

# lappend ::auto_path /your_tcllib_package/dir/lib

package require tls 1.5

set server "localhost"
set portN 6600

# ssl client certificate vars
set caCert "ca.crt"
set clientCert "client.crt"
set clientKey "client.key"
set pPhrase ""

proc outPass { } {
    global pPhrase
    return pPhrase
}

proc sendTo { toStr } {
    global portN
    global server
    global caCert
    global clientCert
    global clientKey
    
    if { $pPhrase == "" } {
        set soChan [::tl::socket -cafile $caCert -certfile $clientCert -keyfile $clientKey -ssl3 1 -require 1 -request 1 $server $portN]
    } else {
        set soChan [::tl::socket -cafile $caCert -certfile $clientCert -keyfile $clientKey -password outPass -ssl3 1 -require 1 -request 1 $server $portN]
    }
    puts $soChan $toStr
    flush $soChan
    gets $soChan gotLine
    close $soChan
    puts "from server: $gotLine
}

sendTo "test string"

