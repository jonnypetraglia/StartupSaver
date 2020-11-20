;#notrayIcon

ifnotexist, StartupSaver.ini
  { openConfig:=CMsgBox("","File Not Found - StartupSaver.ini", "Cannot find INI file. Open Configuration?","!","Yes|No","")
   ifequal, openConfig, Yes
    ifexist StartupSaverConfig.exe
      Run, StartupSaverconfig.exe
    Else
      msgbox,,File does not exist,StartupSaverConfig.exe does not exist.
   ExitApp
  }  
Sysget, resw, 16
Sysget, resh, 17
Coordmode, ToolTip, Screen
  
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
 ifEqual, prog%Counter%, ERROR
  { prog%Counter%=
    break
  }
 IniRead, rawtime%Counter%, StartupSaver.ini, Times, time%Counter%
 time%Counter%:=% rawtime%Counter% * 1000
 Iniread, arguments%Counter%, StartupSaver.ini, Args, arg%Counter%
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
{ ifexist % prog%Counter%
  { SplitPath, prog%Counter%, name
   tooltip
   tooltip, Launching %name%, %resw%, %resh%
   sleep, % time%Counter%  
    run, % prog%Counter% arg%Counter%
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