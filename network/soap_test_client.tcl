#!/bin/sh
# next line restarts using tclsh \
exec /usr/local/bin/tclsh "$0" ${1+"$@"}

#--------------------------------------------------------------
# what: simple client test for ruby soapclient at ruby repo
# author: ricardo
#--------------------------------------------------------------


package require SOAP

SOAP::create sum -uri "urn:ruby:mathcalc" -proxy "http://127.0.0.1:9900" -params { a integer b integer }
puts [::sum 10 30]

SOAP::create dif -uri "urn:ruby:mathcalc" -proxy "http://127.0.0.1:9900" -params { a integer b integer }
puts [::dif 50 30]

