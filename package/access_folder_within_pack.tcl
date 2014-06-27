#------------------------------------------------------------------------------
# what: sample way to access or use a folder within the package relative path
#------------------------------------------------------------------------------

package provide hellopack 1.0
package require Tcl 8.5

namespace eval ::hellopack:: {
	variable outString "hello"
	variable iconFile ""

	proc ::hellopack::setdir { setdir } {
		variable iconFile
		set iconFile $setdir
	}

	proc ::hellopack::say { } {
		variable outString
		puts $outString
	}

	proc ::hellopack::packdir { } {
		variable iconFile
		puts $iconFile
	}
}

::apply { {selfdir2} { ::hellopack::setdir $selfdir2/icons } } [file dirname [file normalize [info script]]]
