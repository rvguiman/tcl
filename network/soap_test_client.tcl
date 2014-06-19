#!/bin/sh
# next line restarts using tclsh \
exec /APP1/Tcl/Linux-x86_64/ActiveTcl8.5.9.2/bin/tclsh "$0" ${1+"$@"}

#--------------------------------------------------------------
# what: simple client test for ruby soapclient at ruby repo
# author: ricardo
#--------------------------------------------------------------

# change to package your path
# lappend ::auto_path /your_path/Tcl/lib/

package require SOAP

SOAP::create sum -uri "urn:ruby:mathcalc" -proxy "http://127.0.0.1:9900" -params { a integer b integer }
puts [::sum 10 30]

SOAP::create dif -uri "urn:ruby:mathcalc" -proxy "http://127.0.0.1:9900" -params { a integer b integer }
puts [::dif 50 30]

