;#NoTrayIcon
#include anchor.ahk
Menu, Tray, nostandard
Menu, tray, DeleteAll
;Reading from INI
Configuration:
Counter=0
ifexist, StartupSaver.ini
{
 Loop,
  {
  IniRead, prog%Counter%, StartupSaver.ini, Programs, program%Counter%
  ifEqual, prog%Counter%, ERROR
   { prog%Counter%=
   break
  }
  IniRead, rawtime%Counter%, StartupSaver.ini, Times, time%Counter%
  time%Counter%:=% rawtime%Counter% * 1000
  IniRead, argument%Counter%,StartupSaver.ini, Args, arg%Counter%
  Counter++ 
 }
 IniRead, startupFolder, StartupSaver.ini, Other, startwithpc
 IniRead, stall, StartupSaver.ini, Other, stallTime
 IniRead, showProgress, StartupSaver.ini, Other, showProgress
 IniRead, skipError, StartupSaver.ini, Other, skipError
}

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~GUIs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;MainGui
Gui 1:+resize +minsize
Gui 1:Add, ListView, r8 w450 gMyListView -multi grid nosort checked vmylistview, |Path|Delay|Args
Gui 1:Add, Button, y173 x10 h20 w45 vnewb,New
Gui 1:Add, Button, y173 x60 h20 vdelb,Delete
gui 1:Font, s6
Gui 1:Add, Button, y173 x125 h20 w20 gupandup vupb,/\
Gui 1:Add, Button, y173 x150 h20 w20 gdownanddown vdownb,\/
Gui 1:Font
Gui 1:Add, Button, y173 x275 w60 default vokb, OK
Gui 1:Add, Button,y173 x345 w60 vcancelb, Cancel

Gui 6:Add,groupbox,x5 y1 h110 w365,Add/Edit
Gui 6:Add,text,x13 y20,Path:
Gui 6:Add,Edit,x13 y35 w325 vpPath,
Gui 6:Add,Button,x343 y34 gpathSelect, �
Gui 6:Add,text,x13 y65, Delay:
Gui 6:Add, Edit,w40 x13 y80 w40
Gui 6:Add, UpDown, vtime Range0-60,
Gui 6:Add,text,x70 y65,Arguments:
Gui 6:Add,Edit,x70 y80 w290 varguments,
Gui 6:Add, Button, y120 x230 w60 default, OK
Gui 6:Add, Button,y120 x300 w60, Cancel
pathselectdir:=A_ProgramFiles

Counter=0
loop,
 { if prog%Counter%=
    break
  LV_Add("","",prog%Counter%, rawtime%Counter%, argument%Counter%)  
  Counter++
}
LV_ModifyCol(2,340)
LV_ModifyCol(3,40)
LV_ModifyCol(4,100)

id=0
loop,%Counter%
{
 iniread, checktest, StartupSaver.ini, active, check%id%
 ifequal, checktest, 1
  LV_Modify(id+1,"check")
 id++
}

Menu, FileMenu, Add, &Run, FileRun
Menu, FileMenu, Add, Import, FileImport
Menu, FileMenu, Add, Export, FileExport
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &Readme, Readme
Menu, HelpMenu, Add, &About, AboutMenu
Menu, OptionsMenu, Add, &Config, OConfig
Menu, OptionsMenu, Add, &Install, OInstall
Menu, MenuBar, Add, &File, :FileMenu  
Menu, Menubar, Add, &Options, :OptionsMenu
Menu, MenuBar, Add, &Help, :HelpMenu
Gui 1:menu, Menubar
Gui 1:Add, GroupBox, x0 y-10 h12 w470 vgroupy

;Gui 2: Config
Gui 2:+owner1 -MaximizeBox -MinimizeBox
Gui 2: Add, GroupBox, h135 w150 Section, Config
Gui 2: Add, Text, x15 y30, Delay:
Gui 2: Add, Edit, w35 y28 x52
Gui 2: Add, UpDown, w30 vstall Range1-99, %stall%
Gui 2: Add, Checkbox, vshowProgress x20 y55 Checked%showProgress%, Show "Starting" window
Gui 2: Add, Checkbox, vskipError x20 y75 Checked%skipError%, Skip errors
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
Gui 3: Add, Button, h20 w50 y80 x220 guninstallFinal, Uninstall

;Gui 4: Import
Counter=0
WinAppend=C:\WINDOWS\
loop, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Run, 0, 
  { RegRead, regProg%counter%
  ifnotinstring, regProg%Counter%, \
    regprog%Counter%:=WinAppend . regProg%Counter%
    StringReplace, regProg%Counter%, regProg%Counter%, `",  , All
  Counter++
}
runReg:=Counter
counter=0
loop, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Run, 0, 
  { RegRead, gloreg%counter%
  ifnotinstring, gloreg%Counter%, \
   gloreg%Counter%:=WinAppend . gloReg%Counter%
  StringReplace, gloreg%Counter%, gloreg%Counter%, `",  , All
  Counter++
}
gloRegTot:=Counter
Counter=0
regCheckY:=30
regCheckX:=20
regCheckW:=60
Gui 4:-MaximizeBox +MinimizeBox +owner1
gui 4: tab,1

Loop, %runReg%
{ Gui 4: Add, Checkbox, y%regCheckY% x%regCheckX% vcheckRegProg%Counter%, % regProg%Counter%
 regCheckY+=20
 Counter++
}

gui 4: tab, 2
Counter=0
gloregCheckY:=30
Loop, %gloregtot%
{ Gui 4: Add, Checkbox, y%gloregCheckY% x%regCheckX% vcheckgloreg%Counter%, % gloreg%Counter%
 gloregCheckY+=20
 Counter++
}

gui 4: tab,3 
Counter=0
 Loop, %A_Startmenu%\Programs\Startup\*.lnk
 { FileGetShortcut, %A_LoopFileFullPath%, lnk%Counter%,, lnkArgs%counter%
  Counter++
}
lnkTotal:=Counter
Counter=0
stCheckY:=30
Loop, %lnkTotal%
{  Gui 4: Add, Checkbox, +wrap w380 y%stCheckY% x%regCheckX% vcheckLnkProg%Counter%, % lnk%Counter% ;w380
  stCheckY+=20
 Counter++
}
gui 4:tab, 4
Counter=0
 Loop, %A_StartMenuCommon%\Programs\Startup\*.lnk
 { FileGetShortcut, %A_LoopFileFullPath%, glolnk%counter%,, gloArgs%Counter%
  Counter++
}
gloLnkTotal:=Counter
Counter=0
globalCheckY:=30
Loop, %gloLnkTotal%
{  Gui 4: Add, Checkbox, +wrap w380 y%globalCheckY% x%regCheckX% vglobalLnkProg%Counter%, % gloLnk%Counter% ;w380
  globalCheckY+=20
 Counter++
}
if (regCheckY >= stCheckY and regchecky >= globalcheckY and regchecky >= gloregcheckY)
 { tabh:=regCheckY
 stOCY:=regCheckY + 7    
 }
else
 { if (stCheckY >= regCheckY and stCheckY >= globalcheckY and stCheckY >= gloregcheckY)
    { tabh:=stCheckY
      stOCY:=stCheckY + 7 
    }
   else
    { if (globalcheckY >= gloregcheckY and globalchecky >= regcheckY and globalchecky >= stcheckY)
       { tabh:=globalcheckY
         stOCY:=globalCheckY + 7 
       }
      else
       { tabh:=gloregCheckY
         stOCY:=gloregCheckY + 7
       }
    }
}
gui 4: Add, Tab2,x2 y2 h%tabh% w400 -wrap,User Registry|Glogal Registry|Startup Folder|Global Startup
gui 4: Tab
Gui 4: Add, Button, w%regCheckW% x140 y%stOCY% ,Import
Gui 4: Add, Button, w%regCheckW% x210 y%stOCY% ,Cancel



;Gui 5: About
gui 5:+owner1 -MaximizeBox -MinimizeBox
gui 5:font, s10 w700, Verdana
gui 5:Add, text,x70,StartupSaver v0.97 beta
gui 5:font, s7 w400, MS sans serif
gui 5:add, text,w220 x92,% "     StartupSaver was made for fun and for use. It was written in the powerful Autohotkey, and freely available to all who can use it."
Gui 5:font,CBlue Underline
gui 5:add, text, w220 x92 gFreewareWire,% "`nwww.FreewareWire.blogspot.com"
GUI 5:font
gui 5:add, text, w220 x92,% "�2009 Jon Petraglia"
gui 5:add, picture, w70 h70 icon1 x15 y25, startupsaver.exe


;Gui 7: Export
gui 7:+owner1 -MaximizeBox -MinimizeBox
Gui 7: Add, groupbox,h125 w150 y5 x5,Options
Gui 7: Add, checkbox, vexpReg x20 y25 ggrey,Export Registry
Gui 7: Add, checkbox, vexpGloreg x20 y45 ggrey,Export Global Registry
Gui 7: Add, checkbox, vexpSt x20 y65 ggrey,Export Startup Folder
Gui 7: Add, checkbox, vexpGlost x20 y85 ggrey,Export Global Startup
Gui 7: Add, checkbox, vexpSS x20 y105 ggrey,Export StartupSaver
Gui 7: Add, groupbox, y5 x160 h80 w75,Export type
Gui 7: Add, Radio, vradioTxt x170 y25,.TXT
Guicontrol 7:,radiotxt,1
Gui 7: Add, Radio, vradioReg x170 y45,.REG
Gui 7: Add, Radio, vradioLnk x170 y65,.LNK
Gui 7: Add, Button, x160 y88 w70 h20 default vexportB, Export
GUI 7: Add, Button, x160 y110 w70 h20, Cancel

gosub, grey

;Show Main GUI
gui 1:show, w470, StartupSaver v0.97 beta
return

Guisize:
anchor("groupy","w")
anchor("mylistview","wh")
anchor("newb","y")
anchor("delb","y")
anchor("upb","y")
anchor("downb","y")
anchor("Okb","xy")
anchor("cancelb","xy")
Guicontrol 1:+redraw, cancelb
LV_ModifyCol(4,"autohdr")
return

;Menus defined
FileRun:
ifexist, StartupSaver.exe
 Run, StartupSaver.exe
Else
 msgbox,,File not Found, StartupSaver.exe does not exist.
Return
FileImport:
Gui 4: show,autosize, Import
Return
FileExport:
Gui 7: show, autosize, Export (beta)
return
FileExit:
ExitApp
OConfig:
Gui 2: Show, Autosize, Preferences
return
OInstall:
Gui 3: Show, Autosize, Install/Uninstall
Return
  InstallFinal:
  Msgbox, 4, Confirm Install, This will install StartupSaver to the folder selected. Are you sure you want to do this?
  Gui 3:Submit
  ifmsgbox Yes
  { Ifnotexist %installdir%
    { FileCreateDir, %installdir%
    }
    FileCopy, StartupSaver.exe, %installdir%
    FileCopy, StartupSaver.ini, %installdir%
    FileCopy, StartupSaverConfig.exe, %installdir%
    FileCopy, Readme.txt, %installdir%
    ifequal startMenuEntry, 1
    { FileCreateDir, %A_StartMenu%\Programs\StartupSaver
     FileCreateShortcut, %installdir%\StartupSaver.exe, %A_startMenu%\Programs\StartupSaver\StartupSaver.lnk, %installdir%,,StartupSaver, %installdir%\StartupSaver.exe
     FileCreateShortcut, %installdir%\StartupSaverConfig.exe, %A_startMenu%\Programs\StartupSaver\StartupSaverConfig.lnk, %installdir%,,StartupSaverConfig, %installdir%\StartupSaverConfig.exe
    }
    ifequal startupFolder, 1
    { ifnotexist, StartupSaver.lnk|%A_StartMenu%\Programs\Startup
    FileCreateShortcut, %installdir%\StartupSaver.exe, %A_startMenu%\Programs\Startup\StartupSaver.lnk, %installdir%,,StartupSaver, %installdir%\StartupSaver.exe
    }
    msgbox, 4, Change to installed version?,Installation was successful. Do you want to switch to the installion of StartupSaver? If you don't`, any change made to the configuration will be made to the currently running version`, not the one in %installdir%`n`n Press Yes to change versions`, or No to continue in this version.
    ifmsgbox, Yes
     { ifexist, %installdir%\StartupSaverConfig.exe  
        { run, %installdir%\StartupSaverConfig.exe    
          ExitApp
        }
       else
         msgbox,,Cannot find file, The file:`n`n %installdir%\StartupSaverConfig.exe`n`n Cannot be found. Installation may have failed.
     }
  }
winclose
return
uninstallFinal: 
 MsgBox,4,Confirm uninstall, Are you sure you want to uninstall? This will delete this program, and all of its settings from the folder `n%A_WorkingDir%
 IfMsgbox Yes
   { Gui 3:Submit
   FileAppend,
   (  dir c:\windows\System32 /b /s 
del "%A_WorkingDir%\StartupSaver.exe"
del "%A_WorkingDir%\StartupSaverConfig.exe"
del "%A_WorkingDir%\StartupSaver.ini"
del "%A_WorkingDir%\readme.txt"
rd /s /q "%A_StartMenu%\Programs\StartupSaver\"
del "%A_WorkingDir%\Uninstall.bat"
   ), Uninstall.bat   
   sleep, 1000
   Run, %COMSPEC% /c Uninstall.bat,,hide
   ExitApp
   } 
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
pathSelect:
gui 6: +owndialogs
FileSelectFile,izzafile,3,%pathselectdir%,Select a program to add, Launchables (*.exe;*.jar;*.ahk)
if izzafile=
  return
splitpath, izzafile,,pathselectdir
GuiControl 6:, pPath, %izzafile%
return

grey:
gui 7:submit, nohide
if(expreg=1 or expgloreg=1 or expst=1 or expglost=1 or expSS=1)
 Guicontrol 7: enabled,exportB,
Else
 Guicontrol 7:disabled,exportB,
return

InstallDirSet:
{ FileSelectFolder,izzafile,%A_ProgramFiles%,3, Select Installation Folder
    if izzafile=
     return
    GuiControl, 3:, installdir, %izzafile%\StartupSaver
    return
    }

MyListView:
if A_GuiEvent= DoubleClick
{ LV_GetText(rowPath, A_EventInfo,2)
 LV_GetText(RowTime, A_EventInfo,3)
 LV_GetText(rowArgs, A_EventInfo, 4)
 numero:=A_EventInfo
 Gui 6: show, ,Edit entry
 GuiControl 6:, pPath, %rowPath%
 GuiControl 6:, time, %rowTime%
 GuiControl 6:, arguments, %rowArgs%
 return
}
return

FreewareWire:
run, http://www.freewarewire.blogspot.com
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


ButtonNew:
Gui 6: show, ,Add Entry
GuiControl 6:, pPath,
GuiControl 6:, time,
GuiControl 6:, arguments,
numero=0
return
ButtonDelete:
deleteIt:=LV_GetNext()
LV_Delete(deleteIt)
ifequal, deleteIt, % LV_GetCount() + 1
 LV_Modify(deleteIT - 1, "Select")
Else
 LV_Modify(deleteIt, "Select")
return
UpandUp:
simplemove("up")
Return
DownandDown:
simplemove("down")
return
ButtonOk:
Gui, Submit
;Writing
Counter=0
ID=1
Loop,
{
  LV_GetText(newprog%Counter%, ID,2)
  if newprog%Counter%=
   { numOfProgs:=Counter
   break
   }
  LV_GetText(time%Counter%, ID,3)
  LV_GetText(arguments%Counter%, ID,4)
  ID++
  Counter++
}
rownumber=1
Loop,% LV_GetCount()
{
  checkrow := LV_GetNext(rownumber-1,"Checked")
  ifequal, checkrow, %rownumber%
  {   rownumber--
   iniwrite, 1, StartupSaver.ini, active, check%rownumber% 
   rownumber++
   }
  else
  { rownumber--
   iniwrite, 0, StartupSaver.ini, active, check%rownumber%
   rownumber++
   }
  rownumber++
}
Counter=0
Loop, %numofprogs%
{ IniWrite, % newprog%Counter%, StartupSaver.ini, Programs, program%Counter%
IniWrite, % time%Counter%, StartupSaver.ini, Times, time%Counter%   
IniWrite, % arguments%Counter%, StartupSaver.ini, Args, arg%Counter%
Counter++
}
Loop,
{ IniRead, Dee, StartupSaver.ini, programs, program%Counter%, 1
 ifequal, Dee, 1
  break
 IniDelete, StartupSaver.ini, programs, program%Counter%
 IniDelete, StartupSaver.ini, Times, time%Counter%   
 IniDelete, StartupSaver.ini, Args, arg%Counter%
 Inidelete, StartupSaver.ini, active, check%Counter%
 Counter++
}
ButtonCancel:
GuiClose:
ExitApp

6ButtonOK:
Gui 6: submit
Gui 1:default
if numero=0
 LV_Add("","",pPath,time,arguments)
else
 LV_Modify(numero,"","", pPath, time,arguments)
6ButtonCancel:
winclose
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
IniWrite, %skipError%, StartupSaver.ini, Other, skipError
IniWrite, %startupFolder%, StartupSaver.ini, Other, startwithpc
2ButtonCancel:
WinClose
return

3ButtonCancel:
WinClose
return

4ButtonImport:
Gui 4: submit, Nohide
gui 1: default
Counter=0
regCount=0
runIt:= runReg + lnkTotal + gloLnkTotal
;Find amount of checks are marked
Loop, %runIt%
 { ifnotequal, checkRegProg%Counter%,
    regCount:= regCount + CheckregProg%Counter%       
   ifnotequal, checkLnkProg%Counter%,
    regCount:= regCount + checkLnkProg%Counter%
   ifnotequal, globalLnkProg%Counter%,
    regCount:= regCount + globalLnkProg%Counter%
   ifnotequal, gloreg%Counter%,
    regCount:= regCounter + gloreg%Counter%
   Counter++
}
;Tests to see if user selected none
 Ifequal, regCount, 0
  { Msgbox,,Nothing selected, Please select at least one.
   Return
  }

Counter=0
 
  loop, %runIt%
  { ifequal, checkRegProg%Counter%, 1
    { stringreplace, regprog%Counter%, regprog%Counter%, .exe, .exe ``   
      stringsplit regsplit, regprog%Counter%,``  
      regprog%Counter%:=regsplit1
      regargs%Counter%:=regsplit2
      LV_Add("","",regProg%Counter%,"0",regargs%Counter%)     ;regprog, lnk, and glolnk   & gloreg   
    }
    ifequal, checkgloreg%Counter%, 1
    { stringreplace, gloreg%Counter%, gloreg%Counter%, .exe, .exe ``   
      stringsplit regsplit, gloreg%Counter%,``  
      gloreg%Counter%:=regsplit1
      gloregargs%Counter%:=regsplit2
      LV_Add("","",gloreg%Counter%,"0",gloregargs%Counter%)     ;regprog, lnk, and glolnk      
    }
    ifequal, checkLnkProg%Counter%, 1
    { LV_Add("","",lnk%Counter%,"0",lnkargs)  
    }
    ifequal, globalLnkProg%Counter%, 1
    { LV_Add("","",gloLnk%Counter%,"0",gloargs)  
    }
   Counter++
 }
winclose
return
4ButtonCancel:
winclose
return  

7ButtonExport:
gui 7: submit, nohide
ifequal, radiolnk, 1
{
 fileselectFolder, exportfolder,,3, Select a target folder
 ifequal, exportfolder,
  return
}
else
{
ifequal, radioreg, 1
 { filetype=Registry (*.reg)
 ftypeappend=.Reg
 }
else ifequal, radiotxt, 1
 { filetype=Text document (*.txt)
 ftypeappend=.txt
 }
fileselectfile, exportfile,24 S, %A_WorkingDir%,Choose File location and name, %filetype%
ifequal, exportfile,
 return
 exportfile=%exportfile%%ftypeappend%
}
Export:
gui 7: hide
runIt:= runReg + lnkTotal + gloLnkTotal
Counter=0
apos=`"
ifequal, radioReg, 1
 { FileAppend, Windows Registry Editor Version 5.00`n`n, %exportFile%
   FileAppend, [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run]`n,%exportFile%
   ifequal, expReg,1   
    {Counter=0
     Loop, %runReg%
      { splitpath, regprog%Counter%,,,,nam
      FileAppend, % apos nam apos "=" apos regProg%Counter% apos "`n", %exportFile%
      Counter++
      }
   }
   ifequal, expgloReg,1   
    {Counter=0
     Loop, %gloregtot%
      { splitpath, gloreg%Counter%,,,,nam
      FileAppend, % apos nam apos "=" apos gloReg%Counter% apos "`n", %exportFile%
      Counter++
      }
    } 
   ifequal, expSt,1
    { Counter=0
     Loop, %lnkTotal%
      { splitpath, lnk%Counter%,,,,nam
      FileAppend, % apos nam apos "=" apos lnk%Counter% apos "`n", %exportFile%
      Counter++
      }
     }
   ifequal, expGlost,1
     { Counter=0
      Loop, %gloLnkTotal% 
      { splitpath, glolnk%Counter%,,,,nam
      FileAppend, % apos nam apos "=" apos glolnk%Counter% apos "`n", %exportFile% 
      Counter++
      }
    }
    ifequal, expSS,1
     { Gui 1:default
       Counter=0   
       ID=1
       Loop,
       { LV_GetText(newprog%Counter%, ID,2)
         if newprog%Counter%=
         { numOfProgs:=Counter
           break
         }
        LV_GetText(arguments%Counter%, ID,4)
        ID++
        Counter++
       }
       Counter=0
       Loop, %numofprogs%
       { splitpath, newprog%Counter%,,,,nam
         FileAppend, % apos nam apos "=" apos newprog%Counter%, %exportFile% 
         ifnotequal, arguments%Counter%,
          FileAppend, % " " arguments%Counter% apos "`n", %exportFile%
         Else
          FileAppend, %apos% `n, %exportFile%
         Counter++
       }
    }
  return
}
ifequal, radiolnk,1
 { ifnotexist, %exportFolder%
    filecreatedir, %exportFolder%
   ifequal, expReg,1       
    { Counter=0
     Loop, %runReg%
      { splitpath, regprog%Counter%,,dir,,nam
      Filecreateshortcut, % apos regProg%Counter% apos,%exportFolder%\%nam%.lnk, % apos dir apos ; % regargs%Counter%  
      Counter++
      }
    }
   ifequal, expgloReg,1       
    { Counter=0
     Loop, %gloregtot%
      { splitpath, gloreg%Counter%,,dir,,nam
      Filecreateshortcut, % apos gloreg%Counter% apos,%exportFolder%\%nam%.lnk, % apos dir apos 
      Counter++
      }
    }
   ifequal, expSt,1
    { Counter=0
     Loop, %lnkTotal%
      { splitpath, lnk%Counter%,,dir,,nam
      Filecreateshortcut, % apos lnk%Counter% apos,%exportFolder%\%nam%.lnk, % apos dir apos, % lnkargs%Counter% 
      Counter++
      }
     }
   ifequal, expGlost,1
    { Counter=0
      Loop, %gloLnkTotal% 
      { splitpath, glolnk%Counter%,,dir,,nam
      Filecreateshortcut, % apos glolnk%Counter% apos, %exportfolder%\%nam%.lnk,% apos dir apos, % gloargs%Counter%   
      Counter++
      }
    }
    ifequal, expSS,1
     { Gui 1:default
       Counter=0   
       ID=1
       Loop,
       { LV_GetText(newprog%Counter%, ID,2)
         if newprog%Counter%=
         { numOfProgs:=Counter
           break
         }
        LV_GetText(arguments%Counter%, ID,4)
        ID++
        Counter++
       }
       Counter=0
       ifequal, numofprogs,0
        { msgbox,,No programs to export,There is nothing to export.
          return
          }
       Loop, %numofprogs%
       { splitpath, newprog%Counter%,,dir,,nam
         Filecreateshortcut, % apos newprog%Counter% apos, %exportFolder%\%nam%.lnk, % dir , % arguments%Counter%   
         Counter++
       }
     }
 return
 }

ifequal, radioTxt,1
 { ifequal, expReg,1   
    {Counter=0
     Loop, %runReg%
      { FileAppend, % regProg%Counter% "`n", %exportFile%
      Counter++
      }
    }
  ifequal, expgloReg,1   
    {Counter=0
     Loop, %gloregtot%
      { FileAppend, % gloreg%Counter% "`n", %exportFile%
      Counter++
      }
    }
    ifequal, expSt,1
    { Counter=0
     Loop, %lnkTotal%
      { FileAppend, % lnk%Counter% "`n", %exportFile%
      Counter++
      }
     }
   ifequal, expGlost,1
     { Counter=0
      Loop, %gloLnkTotal% 
      { FileAppend, % glolnk%Counter% "`n", %exportFile%
      Counter++
      }
    }
    ifequal, expSS,1
     { Gui 1:default
       Counter=0   
       ID=1
       Loop,
       { LV_GetText(newprog%Counter%, ID,2)
         if newprog%Counter%=
         { numOfProgs:=Counter
           break
         }
        LV_GetText(arguments%Counter%, ID,4)
        ID++
        Counter++
       }
       Counter=0
       Loop, %numofprogs%
       { FileAppend, % newprog%Counter%, %exportFile%
         ifnotequal, arguments%Counter%,
          FileAppend, % " " arguments%Counter% "`n", %exportFile%
         Else
          FileAppend, `n, %exportFile%
         Counter++
       }
    }
 return
 }
                                   ;RadioReg, radiolnk, radiotxt
7ButtonCancel:
WinClose
return

simplemove(direction){
   if direction=down
    linus=-1
   else
    if direction=up
     linus=1
    else
     return
   selectedCount := LV_GetCount("Selected")
   totalCount := LV_GetCount()
   if not selectedCount
     Return
   RowNumber := LV_GetNext(RowNumber)
   if (rownumber=1 and direction=="up")
     return
   if (rownumber=LV_GetCount() and direction="down")
     return
   ifequal, selectedcount,% LV_GetNext(selectedcount-1,"Checked")
    checkit:= rownumber - linus
   Else
    checkit=0
   LV_GetText(izzapath, rownumber,2)
   LV_GetText(izzatime, rownumber,3)
   LV_GetText(izzaarg, rownumber,4)
   LV_Delete(rownumber)
   LV_Insert(rownumber - linus,"select","",izzapath,izzatime,izzaarg)
   if(checkit>0)
    LV_modify(checkit,"Check")
  }


;^+r:: reload