;#notrayIcon

;Read from INI
Counter=0
IniRead, stall, StartupSaver.ini, Other, stallTime
IniREad, showProgress, StartupSaver.ini, Other, showProgress
IniRead, noise, StartupSaver.ini, Other, sound
IfEqual noise, 0
 noise=-Sound
IfEqual noise, 1
 noise=+Sound
bar :=% Round(100 / stall)
Loop
 {
 IniRead, prog%Counter%, StartupSaver.ini, Programs, program%Counter%
 if prog%Counter%
 { IniRead, rawtime%Counter%, StartupSaver.ini, Times, time%Counter%
 time%Counter%:=% rawtime%Counter% * 1000
 Counter++ 
 }
 Else
  break
}
numofprogs:=Counter

;GUI
if showprogress, 1
{ countdown:=stall
Gui, Add, Text, vStartingUp x5, % "Starting in " . countdown
Gui, Add, Progress, w100 h20 Range1-100 vProgress -Smooth
Gui, Add, Button, w60 x30 default, Cancel
Gui -Sysmenu +Owner
Gui, Show, Autosize, StartupSaver
}

;Stalling
Loop, %stall%
{ sleep, 1000
  if showProgress, 1
  { GuiControl,, Progress, + %bar%
  dotdotdot :=  dotdotdot . "."
  countdown--
  phrase:="Starting in " . countdown
  GuiControl,, StartingUp, %phrase%
 }
}
Gui, destroy

;Running
Counter=0
Loop, %numofprogs%
{ ifexist % prog%Counter%
  { sleep, % time%Counter%  
    run, % prog%Counter%
  }
   Else
   { CMsgBox("","File Not Found - StartupSaver", "The file:`n" prog%Counter% "`ndoes not seem to exist.","!","Okay", noise " +Timeout=5")
   }
 Counter++
}
GuiClose:
ButtonCancel:
 ExitApp
 
 #include CMsgBox.ahk