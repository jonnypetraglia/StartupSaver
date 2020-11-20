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

UpdateURL=http://software.qweex.com/update.php
@Check_for_update := ini_read(INI_VAR, LANG,"Check for update","Check for update")
@Could_not_contact_update_server := ini_read(INI_VAR, LANG,"Could not contact update server","Could not contact update server")
@You_are_running_the_latest_version_of := ini_read(INI_VAR, LANG,"You are running the latest version of", "You are running the latest version of")
@Up_To_Date := ini_read(INI_VAR, LANG,"Up to date","Up to date")
@Error := ini_read(INI_VAR, LANG,"Error","Error")
@An_update_is_available := ini_read(INI_VAR, LANG,"An update is available","An update is available")
@There_is_a_new_version_of := ini_read(INI_VAR, LANG,"There is a new version of","There is a new version of")
@Your_version := ini_read(INI_VAR, LANG,"Your version:","Your version:")
@New_version := ini_read(INI_VAR, LANG,"New version:","New version:")
@Download_it_now := ini_read(INI_VAR, LANG,"Download it now?","Download it now?")

Update:
	if(A_ThisLabel=="Update")
	{
		URLDownloadToFile, %UpdateURL%?id=%About_Name%&v=%About_Version%, %A_Temp%\%About_Name%_Update.tmp
		if(ErrorLevel)
		{
			msgbox, 16, %@Error%, %@Could_not_contact_update_server%
			return
		}
		FileRead, TempVar, %A_Temp%\%About_Name%_Update.tmp
		if(TempVar=0)
		{
			msgbox,,%@Up_to_date%,%@You_are_running_the_latest_version_of% %About_Name%!
			return
		}
		msgbox,4,%@An_update_is_available%, %@There_is_a_new_version_of% %About_Name%!`n`n%@Your_version%`t%About_Version%`n%@New_version%`t%TempVar%`n`n%@Download_it_now%
		ifmsgbox, yes
			run, %ProjectURL%
		return
	}