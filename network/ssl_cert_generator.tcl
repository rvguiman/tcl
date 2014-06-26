#!/bin/sh
# next line starts using tclsh \
exec /usr/local/bin/wish "$0" ${1+"$@"}

#-----------------------------------------------------------------------------------------------#
# what: sample to generate self signed SSL certificate using openssl
# author: ricardo
# Note: - change disN on openssl.cnf values ( config file )
#       - server and client DN should not be completely identical. eg. change email on client
#-----------------------------------------------------------------------------------------------#

proc generateCA { { days 365 } } {
    set cer [catch { exec openssl req -days $days -nodes -new -x509 -config openssl.cnf \
            -keyout keys/ca.key -out keys/ca.crt } res ]
    if { $::errorCode == "NONE" } {
        puts "CA generated"
        return 1
    } else {
        puts "Failed genrating CA"
        return 0
    }
    
}

proc generateServerCrt { { days 365 } } {
    set cer [catch { exec openssl req -days $days -nodes -new -config openssl.cnf \
            -keyout keys/server.key -out keys/server.csr } res ]
    if { $::errorCode == "NONE" } {
        puts "Server CSR generated"
        set cer [catch { exec openssl ca -days $days -config openssl.cnf -extensions server -in keys/server.csr \
            -out keys/server.crt -batch } res ]
        if { $::errorCode == "NONE" } {
            puts "Server Certificate generated"
            return 1
        } else {
            puts "Failed generating server certificate"
            return 0
        }
    } else {
        puts "Failed generating Server CSR"
        return 0
    }
}

proc generateClientCrt { { days 365 } } {
    set cer [catch { exec openssl req -days $days -nodes -new -config openssl.cnf \
            -keyout keys/client.key -out keys/client.csr } res ]
    if { $::errorCode == "NONE" } {
        puts "Client CSR generated"
        set cer [catch { exec openssl ca -days $days -config openssl.cnf -in keys/client.csr \
            -out keys/client.crt -batch } res ]
        if { $::errorCode == "NONE" } {
            puts "Server Certificate generated"
            return 1
        } else {
            puts "Failed generating server certificate"
            return 0
        }
    } else {
        puts "Failed generating Server CSR"
        return 0
    }
}

if { [generateCA] } {
    if { [generateServerCrt] } {
        if { [generateClientCrt] } {
        
        }
    }
}

