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

;``````````````````````````Locale reading```````````````````````
; It's annoying to include this in the main script.
Locale:
iniread, LANG,StartupSaver.ini,config,Language, English
if(LANG!="English")
	FileInstall, locale.ini, locale.ini
;LANG = Pig Latin
#include ini.ahk
ini_load(INI_VAR, "locale.ini")

@Run := ini_read(INI_VAR, LANG,"Run","Run")
@Exit := ini_read(INI_VAR, LANG,"Exit","Exit")
@File := ini_read(INI_VAR, LANG,"File","File")
@Config := ini_read(INI_VAR, LANG,"Config","Config")
@Import := ini_read(INI_VAR, LANG,"Import","Import")
@Export := ini_read(INI_VAR, LANG,"Export","Export")
@Options := ini_read(INI_VAR, LANG,"Options","Options")
@Readme := ini_read(INI_VAR, LANG,"Readme","Readme")
@About := ini_read(INI_VAR, LANG,"About","About")
@Help := ini_read(INI_VAR, LANG,"Help","Help")

@All := ini_read(INI_VAR, LANG,"All","All")
@None := ini_read(INI_VAR, LANG,"None","None")
@Enabled := ini_read(INI_VAR, LANG,"Enabled","Enabled")
@Disabled := ini_read(INI_VAR, LANG,"Disabled","Disabled")
@Select := ini_read(INI_VAR, LANG,"Select","Select")
@Select_in_tab := ini_read(INI_VAR, LANG,"Select in tab","Select in tab")

@Name := ini_read(INI_VAR, LANG,"Name","Name")
@Delay := ini_read(INI_VAR, LANG,"Delay","Delay")
@Path := ini_read(INI_VAR, LANG,"Path","Path")
@Arguments := ini_read(INI_VAR, LANG,"Arguments","Arguments")
@New := ini_read(INI_VAR, LANG,"New","New")
@Delete := ini_read(INI_VAR, LANG,"Delete","Delete")
@OK := ini_read(INI_VAR, LANG,"OK","OK")
@Cancel := ini_read(INI_VAR, LANG,"Cancel","Cancel")
@Add := ini_read(INI_VAR, LANG,"Add","Add")
@Edit := ini_read(INI_VAR, LANG,"Edit","Edit")

@Initial_Delay := ini_read(INI_VAR, LANG,"Initial Delay","Initial Delay")
@Show_Starting_window := ini_read(INI_VAR, LANG,"Show 'Starting' window","Show 'Starting' window")
@Skip_errors := ini_read(INI_VAR, LANG,"Skip errors","Skip errors")
@Start_on_logon := ini_read(INI_VAR, LANG,"Start on logon","Start on logon")
@User_Registry := ini_read(INI_VAR, LANG,"User Registry","User Registry")
@Global_Registry := ini_read(INI_VAR, LANG,"Global Registry","Global Registry")
@Startup_Folder := ini_read(INI_VAR, LANG,"Startup Folder","Startup Folder")
@Global_Startup := ini_read(INI_VAR, LANG,"Global Startup","Global Startup")
@Browse := ini_read(INI_VAR, LANG,"Browse","Browse")
@Delete_checked_after_Import := ini_read(INI_VAR, LANG,"Delete checked after Import","Delete checked after Import")

@File_Not_Found := ini_read(INI_VAR, LANG,"File Not Found","File Not Found")
@Is_Missing := ini_read(INI_VAR, LANG,"is missing","is missing")

@Not_Be_Launched := ini_read(INI_VAR, LANG,"Not Be Launched","The following programs could not be launched:")
@Errors_Occured := ini_read(INI_VAR, LANG,"Errors Occured","Errors Occured")

iniread, @Translator, locale.ini, %LANG%, Translator
if(@Translator="ERROR" or !@Translator)
	@Translator=Send us an e-mail if you would like to help translate.