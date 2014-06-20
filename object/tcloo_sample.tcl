#!/bin/sh
# next line starts using tclsh \
exec /ActiveTcl8.6.0.0/bin/tclsh "$0" ${1+"$@"}

#----------------------------------------------
# what: sample tcl class using TclOO
# author: ricardo
#----------------------------------------------

package require TclOO

oo::class create ParClass {
    variable surname
    
    constructor { } {
        set surname "guiman"
    }
    method printSurname { } {
        puts "my surname is $surname"
    }
}

oo::class create ChiClass {
    superclass ParentClass
    variable surname
    variable name
    
    constructor { } {
        set name "ric"
        set surname "guiman"
    }
    method getName { } {
        return $name
    }
    method whoami { } {
        puts "i am $name"
    }
}

#  parent object
set parObj [ParClass new]
$parObj printSurname

# child obj
set chiObj [ChiClass new]
$chiObj whoami
puts [$chiObj getName]

# call parent method from child obj
$chiObj printSurname
