#!/bin/sh
#next line restarts using tclsh \
exec /bin/tclsh "$0" ${1+"$@"}

#-------------------------------------------------------#
# what: tcl ssl server using self signed certificate
# author: ricardo
#-------------------------------------------------------#

# lappend ::auto_path /your_dir/tcl/lib/

package require tls 1.5

set server ""
set portN 6600

# client certificate vars
set caCert "ca.crt"
set serverCert "server.crt"
set serverKey "server.key"
set pPhrase ""

proc outPass { } {
    global pPhrase
    return $pPhrase
}

proc serverStart { } {
    global server
    global pPhrase
    global portN
    global caCert
    global serverCert
    global serverKey
    
    if { $pPhrase == "" } {
        ::tsl::init -cafile $caCert -certfile $serverCert -keyfile $serverKey -ssl3 1 -require 1 -request 1
    } else {
        ::tsl::init -cafile $caCert -certfile $serverCert -keyfile $serverKey -password outPass -ssl3 1 -require 1 -request 1
    }
    set server [::tls::socket -server serverAccept $portN] 
}

proc serverAccept { channel clientaddr clientport } {
    puts "connected to $clientaddr"
    gets $channel lineStr
    puts "sent by client: $lineStr"
    puts "client port: $clientport"
    close $channel
}

serverStart
