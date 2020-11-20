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


;#notrayIcon
Menu, Tray, nostandard
Menu, tray, DeleteAll

ifnotexist, StartupSaver.ini
{
	msgbox,20,%@File_Not_Found%, StartupSaver.ini %@Is_Missing%
	if(argcount)
		return
	exitapp
 }  
Sysget, ScreenResW, 16
Sysget, ScreenResH, 17
  
;Read from INI
IniRead, StallTime, StartupSaver.ini, Other, StallTime
IniRead, ShowProgress, StartupSaver.ini, Other, ShowProgress
IniRead, SkipErrors, StartupSaver.ini, Other, SkipErrors
errorMsg=%@NotBeLaunched%`n
bar :=% Round(100 / StallTime)

;GUI
if ShowProgress
{
	Gui 42: default
	Gui, Add, Text, vStartingUp x5, % "Starting in " . StallTime-A_Index				;!!! Locale !!!
	Gui, Add, Progress,% "w100 h20 vProgress Range1-" . (StallTime)*10, 3
	Gui, Add, Button, w60 x30 default, Cancel
	Gui -Sysmenu +Owner
	Gui, Show, Autosize, StartupSaver
}

;Stalling
Loop, %StallTime%
{
	sleep, 1000
	if showProgress
	{
		GuiControl 42:, Progress, +10
		GuiControl 42:, StartingUp, % "Starting in " . StallTime - A_Index			;!!! Locale !!!
	}
}
Gui 42: destroy

;Running
Loop,
{
	iniRead, Active, StartupSaver.ini, active, check%A_Index%
	if(Active=="ERROR")
		break
	if(Active)
	{
		IniRead, Program, StartupSaver.ini, Programs, Program%A_Index%
		if(FileExist(Program)) 
		{
			IniRead, Name, StartupSaver.ini, Names, Name%A_Index%
			IniRead, DelayTime, StartupSaver.ini, Times, Time%A_Index%
			IniRead, Arguments, StartupSaver.ini, Args, Arg%A_Index%
;			tooltip
			tooltip, Launching %Name%, %ScreenResW%, %ScreenResH%
			sleep, % DelayTime
			splitpath, Program,,workingDir
			run, %Program% %Arguments%, %workingDir%
		}
		Else
		{
			if(!skiperror)
				msgbox,20,File Not Found - StartupSaver,The file:`n %Program% `ndoes not seem to exist.
			Else
				errorMsg.="`n" . Program
	   }
	}
}
if(skiperror)
{
	if(errorMsg!=(@NotBeLaunched . "`n"))
		msgbox,16,%@Errors_Occurred%, %errorMsg% 
}
 
 if(numofargs==0)
	return
42GuiClose:
42ButtonCancel:
ExitApp