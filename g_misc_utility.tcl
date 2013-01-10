#----------- gQuickMail --------------------------------------------------------------------#
# what:    simple procedure to send email in linux or unix like system
# args:    subject sendTo bodyMsg ccTo bccTo ( message and email adress )
# return:  none
#-------------------------------------------------------------------------------------------#

proc gQuickMail { subject sendTo bodyMsg ccTo bccTo } {
        set qmsgHan [open "tempMsg.qmsg" w]
        puts $qmsgHan $bodyMsg
        close $qmsgHan
        puts "sending mail...."
        if { $ccTo != "" && $bccTo != "" } {
                catch { exec mail -s $subject -c $ccTo -b $bccTo $sendTo < tempMsg.qmsg } msg
                } elseif { $ccTo != "" && $bccTo == "" } {
                catch { exec mail -s $subject -c $ccTo $sendTo < tempMsg.qmsg } msg
                } elseif { $ccTo == "" && $bccTo != "" } {
                catch { exec mail -s $subject -b $bccTo $sendTo < tempMsg.qmsg } msg
                } else {
                catch { exec mail -s $subject $sendTo < tempMsg.qmsg } msg
                }
        puts $msg
        catch { exec rm -rf tempMsg.qmsg } msg
        puts $msg
        puts "closing gQMail"
        }
