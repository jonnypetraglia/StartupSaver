;#notrayIcon
Menu, Tray, nostandard
Menu, tray, DeleteAll

ifnotexist, StartupSaver.ini
  { msgbox,20,File Not Found - StartupSaver.ini,Cannot find INI file. Open Configuration?   
   ifmsgbox, Yes
    ifexist StartupSaverConfig.exe
      Run, StartupSaverconfig.exe
    Else
      msgbox,16,File does not exist,StartupSaverConfig.exe does not exist.  ;20
   ExitApp
  }  
Sysget, resw, 16
Sysget, resh, 17
Coordmode, ToolTip, Screen
  
;Read from INI
Counter=0
IniRead, stall, StartupSaver.ini, Other, stallTime
IniREad, showProgress, StartupSaver.ini, Other, showProgress
IniRead, skipError, StartupSaver.ini, Other, skiperror
errorMsg=The following programs could not be launched:`n
bar :=% Round(100 / stall)
Loop
 {
 IniRead, prog%Counter%, StartupSaver.ini, Programs, program%Counter%
 ifEqual, prog%Counter%, ERROR
  { prog%Counter%=
    break
  }
 IniRead, rawtime%Counter%, StartupSaver.ini, Times, time%Counter%
 time%Counter%:=% rawtime%Counter% * 1000
 Iniread, arguments%Counter%, StartupSaver.ini, Args, arg%Counter%
 iniread, check%Counter%, StartupSaver.ini, active, check%Counter%
 Counter++ 
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
  countdown--
  phrase:="Starting in " . countdown
  GuiControl,, StartingUp, %phrase%
 }
}
Gui, destroy

;Running
Counter=0
Loop, %numofprogs%
{ ifequal, check%counter%, 1
 { ifexist % prog%Counter% 
  { SplitPath, prog%Counter%, name
   tooltip
   tooltip, Launching %name%, %resw%, %resh%
   sleep, % time%Counter%
   splitpath, prog%Counter%,,workingDir
    run, % prog%Counter% arg%Counter%, %workingDir%
  }
   Else
   { ifnotequal, skiperror, 1
      msgbox,20,File Not Found - StartupSaver,The file:`n prog%Counter% `ndoes not seem to exist.
     Else
      errorMsg:=errorMsg . "`n" . prog%Counter%
   }
 }
 Counter++
}
ifequal, skiperror, 1
{ ifnotequal, errorMsg, The following programs could not be launched:`n
   msgbox,16,Files were not able to be opened, %errorMsg% 
}
 
GuiClose:
ButtonCancel:
 ExitApp