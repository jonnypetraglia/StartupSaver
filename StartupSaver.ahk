;#NoTrayIcon
;----------------------StartupSaver RUN-----------------------
;Read from INI

Starting: 
Coordmode, ToolTip, Screen
ifequal, 1, -start
{ ifnotexist, StartupSaver.ini    
  { openConfig:=CMsgBox("","File Not Found - StartupSaver.ini", "Cannot find INI file. Open Configuration?","!","Yes|No","")
   ifequal, openConfig, Yes
    { Goto, Configuration
   } Else
    { ExitApp
    }
  }  
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
Gui 6:-Sysmenu +Owner
Gui 6:Add, Text, vStartingUp x5, % "Starting in " . countdown
Gui 6:Add, Progress, w100 h20 Range1-100 vProgress -Smooth
Gui 6:Add, Button, w60 x30 default, Cancel
Gui 6:Show, Autosize, StartupSaver
}

;Stalling
Loop, %stall%
{ sleep, 1000
  if showProgress, 1
  { GuiControl 6:, Progress, + %bar%
  dotdotdot :=  dotdotdot . "."
  countdown--
  phrase:="Starting in " . countdown
  GuiControl 6:, StartingUp, %phrase%
 }
}
Gui 6: destroy

;Running
Counter=0
Loop, %numofprogs%
{ ifexist % prog%Counter%
  { SplitPath, prog%Counter%, name
   tooltip
   tooltip, Launching %name%, 1024, 560
   sleep, % time%Counter%      
   run, % prog%Counter%
  }
   Else
   { CMsgBox("","File Not Found - StartupSaver", "The file:`n" prog%Counter% "`ndoes not seem to exist.","!","Okay", noise " +Timeout=5")
   }
 Counter++
}
6GuiClose:
6ButtonCancel:
ifequal, pathw, 350
 { ExitApp                                             ;FIX!!!    
 return
 }
else
 ExitApp
}


 ;--------------------------------------END-----------------------------------
;Reading from INI
Configuration:
Counter=0
ifexist, StartupSaver.ini
{
 Loop, 10
  {
  IniRead, prog%Counter%, StartupSaver.ini, Programs, program%Counter%
  IniRead, rawtime%Counter%, StartupSaver.ini, Times, time%Counter%
  time%Counter%:=% rawtime%Counter% * 1000
  Counter++ 
 }
 IniRead, startupFolder, StartupSaver.ini, Other, startwithpc
 IniRead, stall, StartupSaver.ini, Other, stallTime
 IniRead, showProgress, StartupSaver.ini, Other, showProgress
 IniRead, soundOnError, StartupSaver.ini, Other, sound
}

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~GUIs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;MainGui
Counter=0
pathW=350
pathX=10
pathY=25
buttW=18
buttX=370
buttY=24
updownW=40
updownX=400
updownY=24
;Gui, Add, Text,,Please enter the path to the programs and desired delay:
Gui 1:Add, Text,y5 x10,Please enter the path to the programs and desired delay:    ;default is around y5 x10
Loop, 10
{ Gui 1:Add, Edit, w%pathW% x%pathX% y%pathY% vnewprog%Counter% ,% prog%Counter%
Gui 1:Add, Button, w%buttW% x%buttX% y%buttY% gBtnSet%Counter%, �
Gui 1:Add, Edit,w%updownW% x%updownX% y%updownY% w40
Gui 1:Add, UpDown, vnewtime%Counter% Range0-60, % rawtime%Counter%
pathY+=35
buttY+=35
updownY+=35
Counter++
}
okcancelY:=pathY -5
madebyY:=okcancelY - 3
gboxY:=madebyY - 9
Gui 1:Add, Button, w60 x305 y%okcancelY% Default, OK
Gui 1:Add, Button, w60 x380 y%okcancelY% Default, Cancel
Gui 1:Add, Text, y%madebyY% x15, Made by Jon Petraglia �2009. Use and enjoy. (^_^)`nwww.freewarewire.blogspot.com
Gui 1:Add, GroupBox,y-6 x-20 w500 h7,,
Gui 1:Add, GroupBox, y%gboxY% x%pathX% w257 h40
  ;Menu
Menu, FileMenu, Add, &Run, FileRun
Menu, FileMenu, Add, Import/Export, FileIE
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &Readme, Readme
Menu, HelpMenu, Add, &About, AboutMenu
Menu, OptionsMenu, Add, &Config, OConfig
Menu, OptionsMenu, Add, &Install, OInstall
Menu, MenuBar, Add, &File, :FileMenu  
Menu, Menubar, Add, &Options, :OptionsMenu
Menu, MenuBar, Add, &Help, :HelpMenu
Gui 1:menu, Menubar

;Gui 2: Config
Gui 2:+owner1 -MaximizeBox -MinimizeBox
Gui 2: Add, GroupBox, h135 w150 Section, Config
Gui 2: Add, Text, x15 y30, Delay:
Gui 2: Add, Edit, w35 y28 x52
Gui 2: Add, UpDown, w30 vstall Range1-99, %stall%
Gui 2: Add, Checkbox, vshowProgress x20 y55 Checked%showProgress%, Show "Starting" window
Gui 2: Add, Checkbox, vsoundOnError x20 y75 Checked%soundOnError%, Beep on error
Gui 2: Add, Checkbox, vstartupFolder x20 y95 Checked%StartupFolder%, Start on start up
Gui 2: Font, s7
Gui 2: Add, Button, h20 w43 y114 x40 default, Okay
Gui 2: Add, Button, h20 w43 y114 x90, Cancel
Gui 2: Font, s6

;Gui 3: Install
Gui 3:+owner1 -MaximizeBox -MinimizeBox
Gui 3: Add, GroupBox, h100 w400 Section, Config
Gui 3: Add, Text, x15 y30, Install Directory:
Gui 3: Add, Edit, x100 y28 w250 vinstallDir readonly, % "C:\Program Files\StartupSaver"
Gui 3: Add, Button, x358 y27 w18 gInstallDirSet, �
Gui 3: Add, Checkbox, vstartMenuEntry x20 y55 Checked0, Start Menu entry
Gui 3: Add, Checkbox, vstartupFolder x150 y55 Checked0, Add to startup
Gui 3: Add, Button, h20 w50 y80 x90 ginstallFinal default, Install
Gui 3: Add, Button, h20 w50 y80 x155, Cancel
Gui 3: Add, Button, h20 w50 y80 x220 vbaboon2 guninstallFinal, Uninstall   ;delete baboon

;Gui 4: Import/Export
Counter=0
WinAppend=C:\WINDOWS\
loop, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Run, 0, 
  { RegRead, regProg%counter%
  ifnotinstring, regProg%Counter%, \
    regprog%Counter%:=WinAppend regProg%Counter%
    StringReplace, regProg%Counter%, regProg%Counter%, `",  , All
  Counter++
}
runReg:=Counter
Counter=0
regCheckY:=20
regCheckX:=20
regCheckW:=60
Gui 4:+owner1 -MaximizeBox +MinimizeBox
Loop, %runReg%
{ Gui 4: Add, Checkbox, y%regCheckY% x%regCheckX% vcheckRegProg%Counter%, % regProg%Counter%
 regCheckY+=20
 Counter++
}
regBoxH:=regCheckY + 5
Gui 4: Add, GroupBox, x0 y0 w400 h%regBoxH%,Registry Startup

  ;Startup folder
stCheckYb:=stCheckYa:=regCheckY
Counter=0
 Loop, C:\Documents and Settings\Bry\Start Menu\Programs\Startup\*.lnk
 { FileGetShortcut, %A_LoopFileFullPath%, place,, args  
 lnk%Counter% = %place% %args% 
  Counter++
}
lnkTotal:=Counter
Counter=0
stCheckYb+=20
Loop, %lnkTotal%
{  Gui 4: Add, Checkbox, y%stCheckYb% x%regCheckX% vcheckLnkProg%Counter%, % lnk%Counter%
  stCheckYb+=20
 Counter++
}
stBoxH:= stCheckYb - stCheckYa
stOCY:=stBoxH + regBoxH + 7
Gui 4: Add, GroupBox, x0 y%regCheckY% w400 h%stBoxH%,Startup Folder
Gui 4: Add, Button, w%regCheckW% x70 y%stOCY% ,Import
Gui 4: Add, Button, w%regCheckW% x140 y%stOCY% ,Export
Gui 4: Add, Button, w%regCheckW% x210 y%stOCY% ,Cancel



;Gui 5: About
gui 5:+owner1 -MaximizeBox -MinimizeBox
gui 5:font, s10 w700, Verdana
gui 5:Add, text,x70,StartupSaver v0.9 beta
gui 5:font, s7 w400, MS sans serif
gui 5:add, text,w220 x92,% "     StartupSaver was made for fun and for use. It was written in the powerful Autohotkey, and freely available to all who can use it.`n`n`nwww.FreewareWire.blogspot.com`n�2009 Jon Petraglia"
gui 5:add, picture, w70 h70 icon1 x15 y25, startupsaver.exe

;!!!!  Gui 6 reserved for Run !!!!

;Show Main GUI
gui 1:show, w450 h400, StartupSaver v0.9 beta
return

;Menus defined
FileRun:
1=-start
Gosub, Starting
Return
FileIE:
Gui 4: show,, Import/Export (beta)
Return
FileExit:
ExitApp
OConfig:
Gui 2: Show, Autosize, Preferences
return
OInstall:
Gui 3: Show, Autosize, Install/Uninstall
GuiControl,3:disable,baboon2
Return
  InstallFinal:
  Msgbox, 4, Confirm Install, Are you sure?
  Gui 3:Submit
  ifmsgbox Yes
  { Ifnotexist %installdir%
    { FileCreateDir, %installdir%
    }
    FileCopy, StartupSaver.exe, %installdir%
    FileCopy, StartupSaver.ini, %installdir%
    FileCopy, StartupSaverConfig.exe, %installdir%
    ifequal startMenuEntry, 1
    { FileCreateDir, %A_StartMenu%\Programs\StartupSaver
     FileCreateShortcut, %installdir%\StartupSaver.exe, %A_startMenu%\Programs\StartupSaver\StartupSaver.lnk, %installdir%,,StartupSaver, %installdir%\StartupSaver.exe
     FileCreateShortcut, %installdir%\StartupSaverConfig.exe, %A_startMenu%\Programs\StartupSaver\StartupSaverConfig.lnk, %installdir%,,StartupSaverConfig, %installdir%\StartupSaverConfig.exe
    }
    ifequal startupFolder, 1
    { ifnotexist, StartupSaver.lnk|%A_StartMenu%\Programs\Startup
    FileCreateShortcut, %installdir%\StartupSaver.exe, %A_startMenu%\Programs\Startup\StartupSaver.lnk, %installdir%,,StartupSaver, %installdir%\StartupSaver.exe
    }
  }
winclose
return
   uninstallFinal:     ;Not yet implemented
   MsgBox, 4, MWAHAHAHAHA!, You can't get rid of me that easily! >:P
   /*Msgbox, 4, Confirm Uninstall, Are you sure you want to uninstall?
   Gui 3:Submit
   IfMsgbox Yes
     { FileRemovedir, %A_WorkingDir%
       FileRemovedir, %A_StartMenu%\Programs\StartupSaver
       FileDelete, %A_StartMenu%\Programs\Startup\StartupSaver.lnk
     } 
   */
return
Readme:
ifexist Readme.txt
 Run, Readme.txt
Else
 Msgbox,,File Missing, Readme not found.
return
AboutMenu:
gui 5:show, w320 h130, About StartupSaver
return

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~References~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

BtnSet0:
setfile("0")
return
BtnSet1:
setfile("1")
return
BtnSet2:
setfile("2")
return
BtnSet3:
setfile("3")
return
BtnSet4:
setfile("4")
return
BtnSet5:
setfile("5")
return
BtnSet6:
setfile("6")
return
BtnSet7:
setfile("7")
return
BtnSet8:
setfile("8")
return
BtnSet9:
setfile("9")
return

SetFile(ID)
  { FileSelectFile,izzafile,3,C:\Program Files,, Launchables (*.exe;*.jar;*.ahk)
    if izzafile=
     return
    GuiControl,, newprog%ID%, %izzafile%
  }  

InstallDirSet:
{ FileSelectFolder,izzafile,C:\Program Files,3, Select Installation Folder
    if izzafile=
     return
    GuiControl, 3:, installdir, %izzafile%\StartupSaver
    return
    }
  
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ButtonOk:
Gui, Submit
;Writing
Counter=0
Loop, 10
{ IniWrite, % newprog%Counter%, StartupSaver.ini, Programs, program%Counter%
IniWrite, % newtime%Counter%, StartupSaver.ini, Times, time%Counter%   
Counter++
}
ButtonCancel:
GuiClose:
ExitApp


2ButtonOkay:
Gui 2:submit
IniWrite, %stall%, StartupSaver.ini, Other, stallTime
if startupFolder, 1
 { ifnotexist, StartupSaver.lnk|%A_StartMenu%\Programs\Startup
  FileCreateShortcut, %A_WorkingDir%\StartupSaver.exe, %A_startMenu%\Programs\Startup\StartupSaver.lnk, %A_WorkingDir%,,StartupSaver, %A_WorkingDir%\StartupSaver.exe
 }
Else
{
if startupFolder, 0
 ifexist, StartupSaver.lnk|%A_StartMenu%\Programs\Startup
   Send, #{left}  ;It won't work without this....
  FileDelete, %A_StartMenu%\Programs\Startup\StartupSaver.lnk 
}
IniWrite, %showProgress%, StartupSaver.ini, Other, showProgress
IniWrite, %soundOnError%, StartupSaver.ini, Other, sound
IniWrite, %startupFolder%, StartupSaver.ini, Other, startwithpc
2ButtonCancel:
WinClose
return

3ButtonCancel:
WinClose
return

4ButtonImport:
Gui 4: submit, Nohide
regID=0
regCount=0
runIt:= runReg + lnkTotal
Loop, %runIt%
 { ifnotequal, checkRegProg%regID%,
    regCount:= regCount + CheckregProg%regID%       
   ifnotequal, checkLnkProg%regID%,
    regCount:= regCount + checkLnkProg%regID%
   regID++
}
 IfGreater, regCount, 10
  { Msgbox,,Too many selected, Please select only up to ten choices.
  return
  }
 Ifequal, regCount, 0
  { Msgbox,,Nothing selected, Please select at least one.
   Return
  }
MsgBox,4, Confirm Import, Are you sure? This will overwrite any settings you currently have.
ifmsgbox, Yes
{ Counter=0
  regID=0
  loop, %runIt%
  { ifequal, checkRegProg%regID%, 1
    { GuiControl 1:, newprog%Counter%, % regProg%regID%
      guiControl 1:, newtime%Counter%, 0
      Counter++
    }
    ifequal, checkLnkProg%regID%, 1
    { GuiControl 1:, newprog%Counter%, % lnk%regID%
      guiControl 1:, newtime%Counter%, 0
      Counter++
    }
   regID++
  }
  loop
  { if %Counter% = 9
     break
   GuiControl 1:, newprog%Counter%,    
   guiControl 1:, newtime%Counter%, 0
   Counter++
 }
winclose
}
return
4ButtonExport:

return
4ButtonCancel:
winclose
return  

#include CMsgBox.ahk
  
^+r:: reload