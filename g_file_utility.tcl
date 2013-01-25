#---------------- g_file_utility.tcl ------------------------------------------------#
# what: collection of file utility procedures for tcl and tk
# author: Ricardo Victor Guiman II
#------------------------------------------------------------------------------------#


#------- gGetFileDate ---------------------------------------------------------------#
# what:   get the date of the file creation or latest modification
# args:   file 
# return: a list, index 0 is time in seconds, index 1 is time in human readable form
#------------------------------------------------------------------------------------#

proc gGetFileDate { filePass } {
    set secTime [file mtime $filePass]
    set humanTime [clock format $secTime -format "%d_%b_%y_%H:%M:%S"]
    return [list $secTime $humanTime]
    }
    
#---------------- gFileExistCheck ---------------------------------------------------------------------------------#
# what:     procedure to check if file exists 
# args:		a list of files or list consisting of the file and the error string if missing 
# sample args:	[list "/doc/file.txt" "/doc/table.csv"] OR [list [list /doc/file.txt "file.txt is required"] [list  /doc/table.csv "csv file missing"]] 
# return:	1 if all file exists OR a list of all the list pair of files and the error string that are missing
#------------------------------------------------------------------------------------------------------------------#

proc gFileExistCheck { listFileAndErr } {
	set retList [list]
	set defErrStr "is missing"
	foreach curPair $listFileAndErr {
		if { [llength $curPair] == 2 } { 
			set theFile [lindex $curPair 0]
			set theErr [lindex $curPair 1]
			} else {
			set theFile $curPair
			set theErr $defErrStr
			}
		if { [file exists $theFile] != 1 } {
			puts "$theFile $theErr"
			lappend retList [list $theFile $theErr]
			}
		}
	return $retList
	}    
