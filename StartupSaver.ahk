/*
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~StartupSaver v1.0~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~Copyright Qweex 2009-2012~~~~~~~~~~~~~~~
	~~~Distributed under the GNU General Public License~~~
	~~~~~~~~~~~~~~~~~http://www.qweex.com~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~MrQweex@qweex.com~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    This file is part of StartupSaver.

    StartupSaver is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    StartupSaver is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with StartupSaver.  If not, see <http://www.gnu.org/licenses/>.
*/


#NoTrayIcon
#SingleInstance, Ignore
#include AdjustResize.ahk
#include Locale.ahk
#include Update.ahk

About_Name=StartupSaver
About_Version=1.0
About_DateLaunch=2009
About_Date=2012
About_CompiledDate=06/11/2012

ProjectURL=http://www.qweex.com

LOCALES=English|Pig Latin|
pathselectdir:=A_ProgramFiles

numofargs=%0%
if(numofargs>0)
	goto RunStartupSaver

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Reading from INI~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Counter=0
ifexist, StartupSaver.ini
{
	IniRead, StartOnLogon, StartupSaver.ini, Other, StartOnLogon
	IniRead, StallTime, StartupSaver.ini, Other, StallTime
	IniRead, ShowProgress, StartupSaver.ini, Other, ShowProgress
	IniRead, SkipErrors, StartupSaver.ini, Other, SkipErrors
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~GUIs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;````````````````` MainMenu `````````````````
	Menu, FileMenu, Add, %@Run%, FileRun
	Menu, FileMenu, Add, %@Exit%, FileExit
Menu, MainMenu, Add, %@File%, :FileMenu  
	Menu, OptionsMenu, Add, %@Config%, OptionsConfig
	Menu, OptionsMenu, Add, %@Import%, OptionsImport
	Menu, OptionsMenu, Add, %@Export%, OptionsExport
Menu, MainMenu, Add, %@Options%, :OptionsMenu
	Menu, HelpMenu, Add, %@Readme%, HelpReadme
	Menu, HelpMenu, Add, %@Check_For_Update%, Update
	Menu, HelpMenu, Add, %@About%, ShowAbout
Menu, MainMenu, Add, %@Help%, :HelpMenu

;````````````````` ImportMenu `````````````````
;	Menu, Viewmenu, Add, Disabled, guisize
;Menu, ImportMenu, Add, View, :ViewMenu
	Menu, SelectMenu, Add, %@All%, ImportAll
	Menu, SelectMenu, Add, %@None%, ImportNone
	Menu, SelectMenu, Add, %@Enabled%, ImportEnabled
	Menu, SelectMenu, Add, %@Disabled%, ImportDisabled
Menu, ImportMenu, Add, %@Select%, :SelectMenu
	Menu, SelectInTabMenu, Add, %@All%, ImportAllInTab
	Menu, SelectInTabMenu, Add, %@None%, ImportNoneInTab
	Menu, SelectInTabMenu, Add, %@Enabled%, ImportEnabledInTab
	Menu, SelectInTabMenu, Add, %@Disabled%, ImportDisabledInTab
Menu, ImportMenu, Add, %@Select_in_tab%, :SelectInTabMenu


;````````````````` 1: MainGui `````````````````
Gui 1: default
Gui, +lastfound
Main_ID:=WinExist()
Gui, +resize +minsize
Gui, Add, ListView, r8 w450 gMainListView 	vMainListView -multi grid nosort checked, %@Name%|%@Delay%|%@Path%|%@Arguments%
Gui, Add, Button, y173 	x10 		 	w60 vButtonNew	gButtonNew			, %@New%
Gui, Add, Button, yp	xp+65 	 		wp	vButtonDelete	gButtonDelete	, %@Delete%
Gui, Add, Button, yp	xp+75 		 	w20 vButtonUp gButtonUp				,% A_IsUnicode ? "↑" : "^"
Gui, Add, Button, yp	xp+25 		 	wp 	vButtonDown gButtonDown			,% A_IsUnicode ? "↓" : "v"
Gui, Add, Button, yp	xp+150 			w60 vButtonOK default	gButtonOk	, %@OK%
Gui, Add, Button, yp	xp+70			wp 	vButtonCancel		gButtonCancel, %@Cancel%
Gui, Add, GroupBox,y-10 x0		h12		w470 vLine		;I guess to make a line
Gui, Menu, MainMenu

LV_ModifyCol(1,125)
LV_ModifyCol(2,40)
LV_ModifyCol(3,340)
LV_ModifyCol(4,100)

;````````````````` 2: Add/Edit `````````````````
Gui 2: default
Gui, Add, groupbox,	x5 		y1 		h150 	w365					, %@Add%/%@Edit%
Gui, Add, text,		xp+8 	yp+19									, %@Name%:
Gui, Add, Edit,		xp	 	yp+15 		 	w200 vProgramName		,
Gui, Add, text,		xp+205 	yp-15									, %@Delay%:
Gui, Add, Edit,		xp		yp+15			w40
Gui, Add, UpDown, 								 vDelayTime Range0-60,
Gui, Add, text,		xp-205 	yp+31									, %@Path%:
Gui, Add, Edit,		xp	 	yp+15 		 	w325 vProgramPath		,
Gui, Add, Button,	xp+330 	yp-1 						gPathSelect	, ...
Gui, Add, Text,		xp-330	yp+31									, %@Arguments%:
Gui, Add, Edit,		xp		yp+15			w325 vArguments			,
Gui, Add, Button, 	xp+150 	yp+40			w60  g2ButtonOK	default	, %@OK%
Gui, Add, Button,	xp+70	yp				wp	 g2ButtonCancel		, %@Cancel%

;````````````````` 3: Config `````````````````
Gui 3: default
Gui, +owner1 -MaximizeBox -MinimizeBox
Gui, Add, Text, 	x15 	y15														, %@Initial_Delay%:
Gui, Add, Edit, 	xp+67	yp-2		w35											,
Gui, Add, UpDown, 						 	vStallTime Range1-99					, %StallTime%
Gui, Add, Checkbox, xp-62	yp+27			vshowProgress Checked%showProgress%		, %@Show_Starting_window%
Gui, Add, Checkbox, xp 		yp+20			vskipError Checked%SkipErrors%			, %@Skip_errors%
Gui, Add, Checkbox, xp		yp+20 			vStartOnLogon Checked%StartOnLogon%		, %@Start_on_logon%
StringReplace, LOCALES, LOCALES, %LANG%, %LANG%|
Gui, add, Dropdownlist, xp 	yp+20	w130	vLanguage								,%LOCALES%
Gui, Add, Button, 	xp		yp+25	w60 	g3ButtonOk						default	, %@OK%
Gui, Add, Button, 	xp+70	yp		wp 		g3ButtonCancel							, %@Cancel%

;````````````````` 4: Import `````````````````
Gui 4: default
Gui 4: +lastfound
Import_ID:=WinExist()
Gui, -MaximizeBox +MinimizeBox +owner1 +resize +minsize
Gui, Add, Tab2,x2 y2 h320 w400 -wrap v4Tabs AltSubmit, %@User_Registry%|%@Global_Registry%|%@Startup_Folder%|%@Global_Startup%|StartupSaver
Gui, tab
	Gui, font, italic underline
	Gui, Add, text, xp+10 yp+23 w100, Enabled
	Gui, font
Gui, tab, 1																	; Name | Path | Args | Location
Gui, Add, ListView, xp	yp+15	r7 w380 vImportLV1 	-multi grid nosort -hdr checked Sort, |2|3|4
LV_ModifyCol(4,0)
Gui, tab
	Gui, font, italic underline
	Gui, Add, text, xp yp+135 w100 vdisabledtext, Disabled
	Gui, font
Gui, tab, 1
Gui, Add, ListView, xp	yp+15 	r7 w380	vImportLV1D 	-multi grid nosort -hdr checked Sort, |2|3|4
LV_ModifyCol(4,0)
loop, 5
{	if(A_Index<2)
		continue
	Gui, tab, %A_Index%
	Gui, Add, ListView, xp	yp-150	r7 wp vImportLV%A_Index% 	-multi grid nosort -hdr checked Sort, |2|3|4
	LV_ModifyCol(4,0)
	Gui, Add, ListView, xp	yp+150	r7 wp vImportLV%A_Index%D	-multi grid nosort -hdr checked Sort, |2|3|4
	LV_ModifyCol(4,0)
}
	Guicontrolget,pos, pos, ImportLV5D
	Gui, Add, Button,% "xp yp-165 h" . posH+150+15 . " w" . posW . " gImportButton v4ButtonBrowse", %@Browse%. . .
	Guicontrol, Hide,ImportLV5
	Guicontrol, Hide,ImportLV5D
Gui, Tab
Gui, Add, Checkbox, x40 y330 vDeleteAfter, %@Delete_checked_after_Import%
Gui, Add, Button, x240  yp-5 w60 v4ButtonImport g4ButtonImport,%@Import%
Gui, Add, Button, xp+70 yp    wp v4ButtonCancel g4ButtonCancel,%@Cancel%
Gui, Menu, ImportMenu
loop, 4

;````````````````` 5: Export `````````````````
Gui 5: default
Gui, +owner1 -MaximizeBox -MinimizeBox ;+close		DEBUG?
Gui, Add, Radio, 	xp+10 	yp+20 				vRadioTxt Checked				,.TXT
Gui, Add, Radio, 	xp+70	yp	 				vRadioRegU						,.REG (%@User_Registry%)
Gui, Add, Radio, 	xp-70	yp+20 				vRadioLnk						,.LNK
Gui, Add, Radio, 	xp+70	yp	 				vRadioRegG						,.REG (%@Global_Registry%)
Gui, Add, Button,	xp-20	yp+30	w70			vButtonExport g5ButtonExport default, %@Export%
GUI, Add, Button,	xp+80	yp		wp			g5ButtonCancel	g5ButtonCancel	, %@Cancel%



gui 1: default
loop,
{
	IniRead, Name, StartupSaver.ini, Names, Name%A_Index%
	if(Name="ERROR")
		break
	IniRead, Program, StartupSaver.ini, Programs, program%A_Index%
	IniRead, DelayTime, StartupSaver.ini, Times, time%A_Index%
	IniRead, Argument, StartupSaver.ini, Args, arg%A_Index%
	iniread, CheckTest, StartupSaver.ini, active, check%A_Index%
	LV_Add("Check" . CheckTest,Name,DelayTime,Program, Argument)
}

gui 1:show, w470, StartupSaver v%About_Version%
return

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! END OF AUTOEXECUTION !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Menus~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;````````````````` File `````````````````
FileRun:
	goto RunStartupSaver
	Return
FileExit:
	ExitApp
;````````````````` Options `````````````````
OptionsConfig:
	Gui 3: default
	GetXY(WinX,WinY,Main_ID)
	Gui 3: Show, x%WinX% y%WinY%, %@Config%
	return
OptionsImport:
	if (A_OSVersion!="WIN_7" and A_OSVersion!="WIN_VISTA" and A_OsVersion!="WIN_XP")
		msgbox,,You have been warned!, If you're running anything but Windows XP`, Vista`, or 7`, the import features of StartupSaver might not work correctly. This is mostly because I don't readily have any other Windows versions available. If you'd like to help get support for an earlier version`, e-mail me. (My address is in the 'About' window.)
	Gui 4: default
	loop, 5
	{
		Gui, Listview, ImportLV%A_Index%
		LV_Delete()
		Gui, Listview, ImportLV%A_Index%D
		LV_Delete()
	}
Guicontrol, Show,4ButtonBrowse
;Guicontrol, Hide,ImportLV5
;Guicontrol, Hide,ImportLV5D
;#################### REGISTRY ####################
Loop, 2		; The first loop takes care of the 32-bit, second takes care of the 64-bit (if applicable)
{
;**********USER REGISTRY**********
	Gui, Listview, ImportLV1													;Enabled Local- XP & 7
	loop, HKEY_CURRENT_USER, Software\%Arch%Microsoft\Windows\CurrentVersion\Run, 0, 
	{
		RegRead, Entry
		ifnotinstring, Entry, \
			Entry:=A_Windir . "\" . Entry
		StringReplace, Entry, Entry, `",  , All
		GetPathAndArgs(Entry, Args)
		LV_Add("", A_LoopRegName, Entry, Args,A_LoopRegKey . "|" . A_LoopRegSubKey . "|" . A_LoopRegName)
	}
	Gui, Listview, ImportLV1D													;Disabled Local- 7
	if(A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")
	{
		loop, HKEY_CURRENT_USER, Software\%Arch%Microsoft\Windows\CurrentVersion\Run\AutorunsDisabled, 0, 
		{
			RegRead, Entry
			ifnotinstring, Entry, \
				Entry:=A_Windir . "\" . Entry
			GetPathAndArgs(Entry, Args)
			LV_Add("",A_LoopRegName,Entry,Args,A_LoopRegKey . "|" . A_LoopRegSubKey . "|" . A_LoopRegName)
		}
	}
			
;**********GLOBAL REGISTRY**********
	Gui, Listview, ImportLV2													;Enabled Global- XP & 7
	loop, HKEY_LOCAL_MACHINE, Software\%Arch%Microsoft\Windows\CurrentVersion\Run, 0, 
	{
		RegRead, Entry
		ifnotinstring, Entry, \
			Entry:=A_Windir . "\" . Entry
		StringReplace, Entry, Entry, `",  , All
		GetPathAndArgs(Entry, Args)
		LV_Add("",A_LoopRegName,Entry, Args,A_LoopRegKey . "|" . A_LoopRegSubKey . "|" . A_LoopRegName)
	}
	Gui, Listview, ImportLV2D													;Disabled Global - 7
	if(A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")
	{
		loop, HKEY_LOCAL_MACHINE, Software\%Arch%Microsoft\Windows\CurrentVersion\Run\AutorunsDisabled, 0, 
		{
			RegRead, Entry
			ifnotinstring, Entry, \
				Entry:=A_Windir . "\" . Entry
			GetPathAndArgs(Entry, Args)
			LV_Add("",A_LoopRegName,Entry, Args,A_LoopRegKey . "|" . A_LoopRegSubKey . "|" . A_LoopRegName)
		}
	}
	else {																		;Disabled Local & Global - XP
		loop, HKEY_LOCAL_MACHINE, SOFTWARE\%Arch%Microsoft\Shared Tools\MSConfig\startupreg, 2, 
		{
			RegRead, Name, HKEY_LOCAL_MACHINE, %A_LoopRegSubKey%\%A_LoopRegName%, item
			RegRead, Entry, HKEY_LOCAL_MACHINE, %A_LoopRegSubKey%\%A_LoopRegName%, command
			RegRead, S_Type, HKEY_LOCAL_MACHINE, %A_LoopRegSubKey%\%A_LoopRegName%, hkey
			ifnotinstring, Entry, \
				Entry:=A_Windir . "\" . Entry
			GetPathAndArgs(Entry, Args)
			if(S_Type="HKLM")
				Gui, Listview, ImportLV4D
			 else
				Gui, Listview, ImportLV3D
			LV_Add("",Name,Entry, Args,A_LoopRegKey . "|" . A_LoopRegSubKey . "\" . A_LoopRegName . "|")
		}
	}
	if !Is64Bit()
		break
	Arch=Wow6432Node\
}
	Arch=

;#################### Startup ####################
;**********USER STARTUP**********
	Gui, Listview, ImportLV3													;Enabled Local- XP & 7
	Loop, %A_Startup%\*.lnk
	{
		FileGetShortcut, %A_LoopFileFullPath%, Entry,, Args
		LV_Add("",SubStr(A_LoopFileName,1,StrLen(A_LoopFileName)-StrLen(".lnk")),Entry,Args,A_LoopFileName)
	}
	Gui, Listview, ImportLV3D													;Disabled Local- 7
	if(A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")
	{
		Loop, %A_Startup%\AutorunsDisabled\*.lnk
		{
			FileGetShortcut, %A_LoopFileFullPath%, Entry,, Args
			LV_Add("",SubStr(A_LoopFileName,1,StrLen(A_LoopFileName)-StrLen(".lnk")),Entry,Args,A_LoopFileName)
		}
	}

;**********GLOBAL STARTUP**********
	Gui, Listview, ImportLV4													;Enabled Global- XP & 7
	Loop, %A_StartUpCommon%\*.lnk
	{
		FileGetShortcut, %A_LoopFileFullPath%, Entry,, Args
		LV_Add("",SubStr(A_LoopFileName,1,StrLen(A_LoopFileName)-StrLen(".lnk")),Entry,Args,A_LoopFileName)
	}
	Gui, Listview, ImportLV4D													;Disabled Global - 7
	if(A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")
	{
		Loop, %A_StartUpCommon%\AutorunsDisabled\*.lnk
		{
			FileGetShortcut, %A_LoopFileFullPath%, Entry,, Args
			lnkTotal:=A_Index
			LV_Add("",Entry,Args)
		}
	}
	else {																		;Disabled Local & Global - XP
		loop, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Shared Tools\MSConfig\startupfolder, 2, 
		{
			RegRead, Name, HKEY_LOCAL_MACHINE, %A_LoopRegSubKey%\%A_LoopRegName%, item
			RegRead, Entry, HKEY_LOCAL_MACHINE, %A_LoopRegSubKey%\%A_LoopRegName%, command
			RegRead, S_Type, HKEY_LOCAL_MACHINE, %A_LoopRegSubKey%\%A_LoopRegName%, location
			ifnotinstring, Entry, \
				Entry:=A_Windir . "\" . Entry
			GetPathAndArgs(Entry, Args)
			ifinstring, S_Type, Common
				Gui, Listview, ImportLV4D
			else
				Gui, Listview, ImportLV3D
			LV_Add("",A_LoopRegName,Entry, Args)
		}
	}
	

Loop, 5		;Sets width of columns for contents, or to 0 if there are none
{
	Gui, Listview, ImportLV%A_Index%
	if(LV_GetCount()=0)
		loop, 3
			LV_ModifyCol(A_Index,0)
	else
		Loop, 3
			LV_ModifyCol(A_Index,"Auto")
	Gui, Listview, ImportLV%A_Index%D
	if(LV_GetCount()=0)
		loop, 3
			LV_ModifyCol(A_Index,0)
	else
		Loop, 3
			LV_ModifyCol(A_Index,"Auto")
}

	GetXY(WinX,WinY,Main_ID)
	Gui 4: show,x%WinX% y%WinY%, %@Import%
	Return
	
OptionsExport:
	Gui 5: default
	GetXY(WinX,WinY,Main_ID)
	Gui 5: show, x%WinX% y%WinY%, %@Export%
	return
;````````````````` Help `````````````````
HelpReadme:
	ifexist Readme.txt
		Run, Readme.txt
	Else
		Msgbox,,%@File_Not_Found%, %_Readme_Missing%
	return



;`````````````````Function to help center a child GUI`````````````````
GetXY(ByRef WinX,ByRef WinY, GUIID)
{
	WinGetPos, WinX, WinY, WinW, WinH, ahk_id %GUIID%
	Sysget, TempVar1, 78
	Sysget, TempVar2, 78
	gui, show,% "x" . 2*TempVar1 . " y" . 2*TempVar2
	gui, +lastfound
	Second_ID:=WinExist()
	WinGetPos,,,Win2W, Win2H,ahk_id %Second_ID%
	WinX+=Round((WinW-Win2W)/2)
	WinY+=Round(WinH/2-Win2H/2)
}
return


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~GUI labels~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;````````````````` 1. Main `````````````````
MainListView:
Gui 1: default
if(LV_GetCount("Selected")=0)
	return
if(A_GuiEvent="DoubleClick")
{
	SelectedRow:=A_EventInfo
	LV_GetText(Name, A_EventInfo,1)
	LV_GetText(DelayTime, A_EventInfo,2)
	LV_GetText(Program, A_EventInfo,3)
	LV_GetText(Args, A_EventInfo,4)
	Gui 2: show, ,Edit entry
	GuiControl 2:, ProgramName, %Name%
	GuiControl 2:, ProgramPath, %Program%
	GuiControl 2:, DelayTime, %DelayTime%
	GuiControl 2:, Arguments, %Args%
	return
}
return

ButtonNew:
Gui 2: show, ,Add Entry
GuiControl 2:, ProgramName,
GuiControl 2:, ProgramPath,
GuiControl 2:, DelayTime,
GuiControl 2:, Arguments,
SelectedRow=0
return

ButtonDelete:
gui 1: default
deleteIt:=LV_GetNext()
LV_Delete(deleteIt)
ifequal, deleteIt, % LV_GetCount() + 1
	LV_Modify(deleteIT - 1, "Select")
Else
	LV_Modify(deleteIt, "Select")
return

ButtonUp:
simplemove(1)
Return

ButtonDown:
simplemove(-1)
return

ButtonOk:
	Gui 1: default
	Gui, Submit
	gosub SaveSettings
ButtonCancel:
GuiClose:
ExitApp

SaveSettings:
	Loop,% LV_GetCount()
	{
		LV_GetText(Name, A_Index,1)
		if !Name
			break
		LV_GetText(DelayTime, A_Index,2)
		LV_GetText(Program, A_Index,3)
		LV_GetText(Arguments, A_Index,4)

		IniWrite, %Name%, StartupSaver.ini, Names, Name%A_Index%
		IniWrite, %Program%, StartupSaver.ini, Programs, Program%A_Index%
		IniWrite, %DelayTime%, StartupSaver.ini, Times, Time%A_Index%
		IniWrite, %Arguments%, StartupSaver.ini, Args, Arg%A_Index%
		
		if(LV_GetNext(A_Index-1,"Checked")=A_Index)
			iniwrite, 1, StartupSaver.ini, active, check%A_Index%
		else
			iniwrite, 0, StartupSaver.ini, active, check%A_Index%
		TotalNumber:=A_Index
	}
	Loop,
	{
		TotalNumber++
		IniRead, deleteIt, StartupSaver.ini, Names, Name%TotalNumber%, 1
		if(deleteIt==1)
			break
		IniDelete, StartupSaver.ini, programs, program%TotalNumber%
		IniDelete, StartupSaver.ini, Times, time%TotalNumber%   
		IniDelete, StartupSaver.ini, Args, arg%TotalNumber%
		Inidelete, StartupSaver.ini, active, check%TotalNumber%
	}
return

;````````````````` 2. Add/Edit `````````````````
PathSelect:
gui 2: +owndialogs
FileSelectFile,OutputFile,3,%pathselectdir%,Select a program to add, Launchables (*.exe;*.jar;*.bat)
if !OutputFile
  return
splitpath, OutputFile,,pathselectdir
GuiControl 2:, ProgramPath, %OutputFile%
return

2ButtonOK:
Gui 2: submit
Gui 1: default
if(SelectedRow=0)
	LV_Add("",ProgramName,DelayTime,ProgramPath,Arguments)
else
	LV_Modify(SelectedRow,"",ProgramName,DelayTime,ProgramPath,Arguments)
2ButtonCancel:
gui 2: hide
return

;````````````````` 3. Config `````````````````
3ButtonOK:
Gui 3: submit
IniWrite, %StallTime%, StartupSaver.ini, Other, StallTime
if(StartOnLogon=1)
{	ifnotexist, %A_Startup%\StartupSaver.lnk
		FileCreateShortcut, %A_Scriptfullpath%, %A_Startup%\StartupSaver.lnk, %A_WorkingDir%,,StartupSaver, %A_Scriptfullpath%
} Else {
	if (StartOnLogon=0 and fileexist(A_Startup . "\StartupSaver.lnk"))
		FileDelete, % A_Startup . "\StartupSaver.lnk"
}
IniWrite, %ShowProgress%, StartupSaver.ini, Other, ShowProgress
IniWrite, %SkipErrors%, StartupSaver.ini, Other, SkipErrors
IniWrite, %StartOnLogon%, StartupSaver.ini, Other, StartOnLogon
if(LANG!=Language)
{	iniwrite, %Language%,StartupSaver.ini,config,Language
	reload
}
3ButtonCancel:
gui 3: hide
return

;````````````````` 4. Import `````````````````
ImportAll:
ImportNone:
ImportEnabled:
ImportDisabled:
loop, 5
{	4Tabs:=A_Index
	gosub %A_ThisLabel%InTab
}
return

ImportAllInTab:
gosub ImportEnabled
gosub ImportDisabled
return

ImportNoneInTab:
if(A_ThisLabel="ImportAllInTab")
	GuiControlGet, 4Tabs,,4Tabs
Gui 4: Listview, ImportLV%4Tabs%
LV_Modify(0,"-Check")
Gui 4: Listview, ImportLV%4Tabs%d
LV_Modify(0,"-Check")
return

ImportEnabledInTab:
if(A_ThisMenu="SelectInTabMenu")
	GuiControlGet, 4Tabs,,4Tabs
Gui 4: Listview, ImportLV%4Tabs%
LV_Modify(0,"+Check")
return

ImportDisabledInTab:
if(A_ThisMenu="SelectInTabMenu")
	GuiControlGet, 4Tabs,,4Tabs
Gui 4: Listview, ImportLV%4Tabs%d
LV_Modify(0,"+Check")
return

ImportButton:
FileSelectFile, ConfigImport, 3, %A_WorkingDir%, Select a StartupSaver INI file to import, *.ini
if !ConfigImport
	return
Gui, Listview, ImportLV5
LV_ModifyCol(1,"",ConfigImport)
loop,
{
	IniRead, Name, %ConfigImport%, Names, Name%A_Index%
	if(Name="ERROR")
		break
	IniRead, Program, %ConfigImport%, Programs, program%A_Index%
	IniRead, DelayTime, %ConfigImport%, Times, time%A_Index%
	IniRead, Argument, %ConfigImport%, Args, arg%A_Index%
	iniread, CheckTest, %ConfigImport%, active, check%A_Index%
	if(CheckTest=1)
		Gui, Listview, ImportLV5
	else
		Gui, Listview, ImportLV5D
	LV_Add("Check" . CheckTest,Name,DelayTime,Program, Argument)
}
Gui, Listview, ImportLV5
Loop, 3
	LV_ModifyCol(A_Index,"Auto")
Gui, Listview, ImportLV5D
Loop, 3
	LV_ModifyCol(A_Index,"Auto")
Guicontrol, Hide,4ButtonBrowse
Guicontrol, Show,ImportLV5
Guicontrol, Show,ImportLV5D
return


4ButtonImport:
Gui 4: default
Guicontrolget, DeleteAfter,,DeleteAfter
If DeleteAfter
{
	Msgbox,4,WARNING!, Are you sure you want to delete the registry values and shortcuts? This is permanent!`n`n(This will also delete the ENTIRE INI file you are importing!)
	ifmsgbox, No
		return
}
Gui 4: default
Gui, submit, Nohide
loop, 5
{
	Type:=A_Index
	Loop 2
	{
		Gui, Listview, ImportLV%Type%%d%
		RowNumber=0
		Loop, % LV_GetCount()
		{
			Gui 4: default
			RowNumber:=LV_GetNext(RowNumber,"Checked")
			if(RowNumber=0)
				break
			LV_GetText(Name,RowNumber,1)
			LV_GetText(Program,RowNumber,2)
			LV_GetText(Args,RowNumber,3)
			if(Type=5)
			{
				LV_GetText(DelayTime,RowNumber,4)
				Gui 1: Listview, MainListView
				LV_Add("Checked",Name,Program,Args,DelayTime)		;Columns are a bit mixed around
			} else {
				Gui 1: default
				Gui, Listview, MainListView
				LV_Add("Checked",Name,0,Program,Args)
			}
		}
	d=d
	}
	d=
}
if(DeleteAfter=1)
{
	Gui 4: default
	Loop, 4
	{
		Num:=A_Index
		Loop 2
		{
			Gui, Listview, ImportLV%NUM%%D%
			Rownumber=0
			Loop, % LV_GetCount()
			{
				RowNumber:=LV_GetNext(RowNumber,"Checked")
				if(RowNumber=0)
					break
				LV_GetText(DeleteIt,RowNumber,4)
				if(A_Index<3)    ; Registry
				{	
					StringSplit, DeleteIt, Deleteit, |
					;msgbox, Delete reg:    %DeleteIt1%  %DeleteIt2%  %DeleteIt3%
					RegDelete, %DeleteIt1%, %DeleteIt2%, %DeleteIt3%
				} else {
					;msgbox, Delete file:   %DeleteIt%
					Filerecycle, %DeleteIt%
				}
			}
			d=d
		}
		d=
	}
	Gui, Listview, ImportLV5D
		Tempy:=LV_GetCount()
	Gui, Listview, ImportLV5
	LV_GetText(DeleteIt,0)
	if (DeleteIt and (Tempy+LV_GetCount())>0)
		;msgbox, Delete: %DeleteIt%
		FileRecycle, %DeleteIt%
}

4GuiClose:
4ButtonCancel:
gui 4: hide
Gui, Listview, ImportLV1
LV_Delete()
Gui, Listview, ImportLV1D
LV_Delete()
Gui, Listview, ImportLV2
LV_Delete()
Gui, Listview, ImportLV2D
LV_Delete()
Gui, Listview, ImportLV3
LV_Delete()
Gui, Listview, ImportLV3D
LV_Delete()
Gui, Listview, ImportLV4
LV_Delete()
Gui, Listview, ImportLV4D
LV_Delete()
Gui, Listview, ImportLV5
LV_Delete()
Gui, Listview, ImportLV5D
LV_Delete()
Guicontrol, Show,4ButtonBrowse
guicontrol, Hide, ImportLV5
guicontrol, Hide, ImportLV5D
return  


;````````````````` 5. Export `````````````````
5ButtonExport:
gui 5: submit, nohide
gui 5: +owndialogs
FormatTime, CurrTime,,M/d/yyyy h:mm tt
if(RadioLNK=1)
{	FileSelectFolder, OutputFile, *%A_ScriptDir%,3,Select your output folder ;\StartupSaver %CurrTime%
	OutputFile := RegExReplace(OutputFile, "\\$")
} else
{	FileSelectFile,OutputFile,S16,*%A_ScriptDir%\OutputFile,Select your output file, % RadioTxt = 1 ? "Text Documents (*.txt)"  : "Registry Hives (*.reg)"
	;TEST FOR FILETYPE!
	ifexist, %OutputFile%
		FileRecycle, %OutputFile%
	FileAppend, `;`; StartupSaver v%About_Version% - %CurrTime% `;`;`n, %OutputFile%
}
if !OutputFile
	return
gui 5: hide
gui 1: default
If(RadioRegU!=RadioRegG) ;Meaning one of them is 1. Yay, Logic!
{	FileAppend, Windows Registry Editor Version 5.00`n`n[HKEY_,%OutputFile%
	if(RadioRegU=1)
		FileAppend, CURRENT_USER, %OutputFile%
	else
		FileAppend, LOCAL_MACHINE, %OutputFile%
	FileAppend, \Software\Microsoft\Windows\CurrentVersion\Run]`n, %OutputFile%
}

If RadioTXT
{
	loop, % LV_GetCount()
	{
		LV_GetText(Name, A_Index,1)
		LV_GetText(Program, A_Index,3)
		LV_GetText(Arguments, A_Index,4)
		IsEnabled:= LV_GetNext(A_Index-1,"Checked") = A_Index
		
		Tabs=
		loop,% 7 - Round(StrLen(Name)/5)	;This aligns with names up to 35 characters
			Tabs.="`t"
		if IsEnabled
			FileAppend, +, %OutputFile%
		else
			FileAppend, -, %OutputFile%
		FileAppend, %Name%%tabs%%Program%%A_Space% %Arguments%`n, %OutputFile%
	}
}

If RadioLNK
{
	if !(A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")
		msgbox, Unforunately`, I haven't gotten the LNK export complete for disabled entries for anything but Windows 7. Sorry! :(
	loop, % LV_GetCount()
	{
		LV_GetText(Name, A_Index,1)
		LV_GetText(Program, A_Index,3)
		LV_GetText(Arguments, A_Index,4)
		IsEnabled:= LV_GetNext(A_Index-1,"Checked") = A_Index
		if(IsEnabled)
			Filecreateshortcut, "%Program%",%OutputFile%\%Name%.lnk,,%Arguments%
		else
		{	ifnotexist, %OutputFile%\AutoRunsDisabled
				FileCreateDir, %OutputFile%\AutoRunsDisabled
			Filecreateshortcut, "%Program%",%OutputFile%\AutoRunsDisabled\%Name%.lnk,,%Arguments%
		}
	}
}

If (RadioRegU!=RadioRegG)
{	
	DisabledStr=
	loop, % LV_GetCount()
	{
		LV_GetText(Name, A_Index,1)
		LV_GetText(Program, A_Index,3)
		LV_GetText(Arguments, A_Index,4)
		IsEnabled:= LV_GetNext(A_Index-1,"Checked") = A_Index
		
		if IsEnabled											;Enabled Local & Global = XP & 7
		{
			FileAppend, "%Name%" = "%Program%, %OutputFile%
			if Arguments
				FileAppend, %A_Space%%Arguments%, %OutputFile%
			FileAppend, "`n, %OutputFile%
		}
		else 
		{
			if (A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")			;Disabled Local & Global = 7
			{
				DisabledStr = %DisabledStr%`n"%Name%" = "%Program%
				if Arguments
					DisabledStr = %DisabledStr%%A_Space%%Arguments%
				DisabledStr = %DisabledStr%"`n
			}
			else 														;Disabled Local & Global = XP
			{
				if(RadioRegU=1)			;Local
				{
					StringReplace, LnkPath, A_Startup, \, ^, All
					DisabledStr = %DisabledStr%`n[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\%LnkPath%^%Name%.lnk]`n"command" = "%Program%"`n"item" = "%Name%"`n"location" = "Startup"`n"path" = "%A_Startup%\%Name%.lnk"
				}
				else					;Global
				{
					StringReplace, LnkPath, A_StartupCommon, \, ^, All
					DisabledStr = %DisabledStr%`n[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\%LnkPath%^%Name%.lnk]`n"command" = "%Program%"`n"item" = "%Name%"`n"location" = "Common Startup"`n"path" = "%A_StartupCommon%\%Name%.lnk"
				}
			}
		}
	}
	
	if DisabledStr													;Appending Disabled to file
	{	
		if (A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")			;Appending the header for 7.
		{
			if(RadioRegU=1)
				FileAppend, `n[HKEY_CURRENT_USER, %OutputFile%
			else
				FileAppend, `n[HKEY_LOCAL_MACHINE, %OutputFile%
			FileAppend, \Software\Microsoft\Windows\CurrentVersion\Run\AutorunsDisabled], %OutputFile%
		}
		FileAppend, %DisabledStr%, %OutputFile%
	}
}
msgbox,3, SUCCESS!, Export completed! View finished product?
Ifmsgbox, yes
{
	if(RadioLNK)
	{
		if(A_IsADmin and (A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA"))
			msgbox, Oh snap! For some reason`, this doesn't work yet. Sorry!
		else
			Run, %OutputFile%
	}
	else
		Run, Notepad %Outputfile%
}
5ButtonCancel:
gui 5: hide
return

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Etc.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Guisize:
AdjustResize("Line","w")
AdjustResize("MainListview","w h")
AdjustResize("ButtonNew","y")
AdjustResize("ButtonDelete","y")
AdjustResize("ButtonUp","y")
AdjustResize("ButtonDown","y")
AdjustResize("ButtonOK","x y")
AdjustResize("ButtonCancel","x y")
Guicontrol 1: +redraw, ButtonCancel
LV_ModifyCol(4,"autohdr")
return

4Guisize:
AdjustResize("4Tabs","w h")
AdjustResize("ImportLV1", "w")
AdjustResize("ImportLV1D", "w")
PairListviews("ImportLV1","ImportLV1D")
AdjustResize("ImportLV2", "w")
AdjustResize("ImportLV2D", "w")
PairListviews("ImportLV2","ImportLV2D")
AdjustResize("ImportLV3", "w")
AdjustResize("ImportLV3D", "w")
PairListviews("ImportLV3","ImportLV3D")
AdjustResize("ImportLV4", "w")
AdjustResize("ImportLV4D", "w")
PairListviews("ImportLV4","ImportLV4D")
AdjustResize("ImportLV5", "w")
AdjustResize("ImportLV5D", "w")
PairListviews("ImportLV5","ImportLV5D")
AdjustResize("DeleteAfter","x y")
AdjustResize("4ButtonImport","x y")
AdjustResize("4ButtonCancel","x y")
guicontrolget, Disabled, pos, ImportLV1D
guicontrol 4: move, DisabledText,% "y" . DisabledY-15
Guicontrol 4: +redraw, DisabledText
Guicontrol 4: +redraw, 4ButtonCancel
return

;Function to move a row in a Listview
;  Specify 1 or +1 for up, -1 for down
simplemove(direction)
{
	if(direction!=-1 and direction!=1)
		return
	RowNumber := LV_GetNext(0,"Focused")
	if(RowNumber=0)
		Return
	if (rownumber=1 and direction=1)	;If it's trying to move the top row up
		return
	if (rownumber=LV_GetCount() and direction=-1)	;If it's trying to move the bottom row down
		return
	if(rownumber=LV_GetNext(rownumber-1,"Checked"))
		checkit:= rownumber
	Else
		checkit=0
	LV_GetText(Name, rownumber,1)
	LV_GetText(Program, rownumber,2)
	LV_GetText(DelayTime, rownumber,3)
	LV_GetText(Arguments, rownumber,4)
	LV_Delete(rownumber)
	LV_Insert(rownumber - direction,"Focus Select",Name,Program,DelayTime,Arguments)
	if(checkit>0)
		LV_modify(rownumber - direction,"Check")
}

GetPathAndArgs(ByRef ProgramPath, ByRef ProgramArgs)
{
	Stringsplit, ByDash, ProgramPath, \
	AfterDash := ByDash%ByDash0%
	StringSplit, ByDot, AfterDash, .
	AfterDot := ByDot%ByDot0%
	StringSplit, BySpace, AfterDot, %A_Space%
	ProgramArgs=
	Loop, % BySpace0
	{
		if(A_Index=1)
			continue
		ProgramArgs .= BySpace%A_Index%
	}
	StringReplace, ProgramPath, ProgramPath, %ProgramArgs%
	StringReplace, ProgramPath, ProgramPath, ",,All
}

Qweex:
run, http://www.qweex.com
return

RunStartupSaver:
	gosub SaveSettings
#Include StartupSaverRun.ahk

Is64Bit()
{
	;  There isn't a built in way to tell this, so here are several ways I'm trying out
; METHOD 1 - PtrSize; pointers vary in size, 8 bits on 64-bit systems and 4 bits on 32-bit systems (and 2 on a 16)
	If(A_PtrSize=8)
		return 1
; METHOD 2 - EnvVar; an Environment Variable containts what type of processor is running, though it might not work
;	EnvGet,pa,PROCESSOR_ARCHITECTURE
;	Return InStr(pa,"64")
}

#include AboutWindow.ahk