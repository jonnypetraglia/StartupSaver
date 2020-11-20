#NoTrayIcon
;Reading input
Counter = 0
Loop, 10
 {
 IniRead, prog%Counter%, StartupSaver.ini, Programs, program%Counter%
 IniRead, rawtime%Counter%, StartupSaver.ini, Times, time%Counter%
 time%Counter%:=% rawtime%Counter% * 1000
 Counter++ 
}
numofprogs:=Counter

;GUI
Counter=0

Gui, Add, Text,,Please enter the path to the programs and desired delay:
;0
Gui, Add, Edit, w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button, y24 w18 gBtnSet%Counter%, …
GUI, Add, Edit,y24 x400 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60, % rawtime%Counter%
Counter++
;1
Gui, Add, Edit,y60 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y59 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y59 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60,% rawtime%Counter%
Counter++
;2
Gui, Add, Edit,y95 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y94 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y94 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60,% rawtime%Counter%
Counter++
;3
Gui, Add, Edit,y130 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y129 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y129 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60
Counter++
;4
Gui, Add, Edit,y165 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y164 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y164 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60
Counter++
;5
Gui, Add, Edit,y200 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y199 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y199 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60
Counter++
;6
Gui, Add, Edit,y235 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y234 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y234 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60
Counter++
;7
Gui, Add, Edit,y270 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y269 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y270 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60
Counter++
;8
Gui, Add, Edit,y305 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y304 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y305 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60
Counter++
;9
Gui, Add, Edit,y340 x10 w350 vnewprog%Counter% ,% prog%Counter%
Gui, Add, Button,x370 y339 w18 gBtnSet%Counter%, …
GUI, Add, Edit,x400 y340 w40
Gui, Add, UpDown, vnewtime%Counter% Range0-60


Gui, Add, Button, w60 x305 y370 Default, OK
Gui, Add, Button, w60 x380 y370 Default, Cancel
Gui, Add, Text, y367 x15, Made by Jon Petraglia ©2009. Use and enjoy. (^_^)`nwww.freewarewire.blogspot.com
Gui, Add, GroupBox,y-6 x-20 w500 h7,,
Gui, Add, GroupBox, y358 x10 w257 h40


Menu, FileMenu, Add, &Run, FileRun
Menu, FileMenu, Add, &Import, FileImport
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &Readme, Readme
Menu, HelpMenu, Add, &About, AboutMenu
Menu, OptionsMenu, Add, &Config, OConfig
Menu, OptionsMenu, Add, &Install, OInstall
Menu, MenuBar, Add, &File, :FileMenu  
Menu, Menubar, Add, &Options, :OptionsMenu
Menu, MenuBar, Add, &Help, :HelpMenu
Gui, Menu, MenuBar
;gosub, GUI
Gui, Show, w450 h400, StartupSaver v0.9 beta
return

FileRun:
Run, StartupSaver.exe
Return
FileExit:
ExitApp
AboutMenu:
gui 5:+owner1 -MaxmizeBox -MinimizeBox +close
gui 5:font, s10 w700, Verdana
gui 5:Add, text,x70,StartupSaver v0.9 beta
gui 5:font, s7 w400, MS sans serif
gui 5:add, text,w220 x92,% "     StartupSaver was made for fun and for use. It was written in the powerful Autohotkey, and freely available to all who can use it.`n`n`nwww.FreewareWire.blogspot.com`n©2009 Jon Petraglia"
gui 5:add, picture, w70 h70 icon1 x15 y25, startupsaver.exe
gui 5:show, w320 h130, About StartupSaver
Return
Readme:
Run, Readme.txt
return

FileImport:
Counter=0
WinAppend=C:\WINDOWS\
loop, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Run, 0, 
  { regread, regProg%counter%
  ifnotinstring, regProg%Counter%, \
    regprog%Counter%:=WinAppend regProg%Counter%
    StringReplace, regProg%Counter%, regProg%Counter%, `",  , All
  Counter++
}
runReg:=Counter

Counter=0
y4:=25
x4:=20
w4:=60
Gui 4:+owner1 -MaxmizeBox +MinimizeBox
Loop, %runReg%
{ Gui 4: Add, Checkbox, y%y4% x%x4% vcheckRegProg%Counter%, % regProg%Counter%
 y4+=20
 Counter++
}
h4:=y4 + 5
y4:=h4 + 7
Gui 4: Add, GroupBox, x0 y0 w400 h%h4%,Registry Startup
Gui 4: Add, Button, w%w4% x140 y%y4% Default vbaboon,(Not Yet)        ;delete baboon, w%w4%
Gui 4: Add, Button, w%w4% x210 y%y4%, Cancel
Gui 4: show,, Registry Import (beta)
GuiControl,4:disable,baboon
Return
4ButtonOk:
/*MsgBox,4, Confirm Import, Are you sure? This will overwrite any settings you currently have.
ifMsgBox, Yes
{ Counter=0
Gui 4:submit    
Loop, %runReg%  
  { ifequal, checkRegProg%Counter%, 1
    {
     GuiControl,, newprog%Counter%, % regProg%Counter%
     MsgBox, % newprog%Counter%
    }
    Counter++
 }
Loop
 { FileGetShortcut
}
;Run, StartupSaverConfig.ahk
;ExitApp
*/
4ButtonCancel:
4GuiClose:
Gui, Destroy
return

OConfig:
IniRead, startupFolder, StartupSaver.ini, Other, startwithpc
IniRead, stall, StartupSaver.ini, Other, stallTime
IniRead, showProgress, StartupSaver.ini, Other, showProgress
IniRead, soundOnError, StartupSaver.ini, Other, sound
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
Gui 2: Show, Autosize, Preferences
return
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
2GuiClose:
Gui 2: destroy
return

OInstall:
Gui 3:+owner1 -MaximizeBox -MinimizeBox
Gui 3: Add, GroupBox, h100 w400 Section, Config
Gui 3: Add, Text, x15 y30, Install Directory:
Gui 3: Add, Edit, x100 y28 w250 vinstallDir readonly, % "C:\Program Files\StartupSaver"
Gui 3: Add, Button, x358 y27 w18 gInstallDirSet, …
Gui 3: Add, Checkbox, vstartMenuEntry x20 y55 Checked0, Start Menu entry
Gui 3: Add, Checkbox, vstartupFolder x150 y55 Checked0, Add to startup
Gui 3: Add, Button, h20 w50 y80 x90 ginstallFinal default, Install
Gui 3: Add, Button, h20 w50 y80 x155, Cancel
Gui 3: Add, Button, h20 w50 y80 x220 vbaboon2 guninstallFinal, Uninstall   ;delete baboon
Gui 3: Show, Autosize, Install/Uninstall
GuiControl,3:disable,baboon2
Return

3ButtonCancel:
3GuiClose:
Gui 3: destroy
return
installFinal:
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
Gui 3: destroy
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

;GUI:
;Gui, Show, w450 h400, StartupSaver v0.9 beta
;return
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
InstallDirSet:
{ FileSelectFolder,izzafile,C:\Program Files,3, Select Installation Folder
    GuiControl, 3:, installdir, %izzafile%\StartupSaver
    return
    }

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

SetFile(ID)
  { FileSelectFile,izzafile,3,C:\Program Files,, Launchables (*.exe;*.jar;*.ahk)
    GuiControl,, newprog%ID%, %izzafile%
  }  
  
#include CMsgBox.ahk