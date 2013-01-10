#------- gGetFileDate ---------------------------------------------------------------#
# what:   get the date of the file creation or latest modification
# args:   filePass
# return: a list, index 0 is time in seconds, index 1 is time in human readable form
#------------------------------------------------------------------------------------#

proc gGetFileDate { filePass } {
    set secTime [file mtime $filePass]
    set humanTime [clock format $secTime -format "%d_%b_%y_%H:%M:%S"]
    return [list $secTime $humanTime]
    }
