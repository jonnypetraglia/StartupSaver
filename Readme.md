# StartupSaver v1.0

**NOTE**: I wrote StartupSaver over 10 years ago and have not touched it since. I hope you enjoy it but it should go without saying that it's not being maintained.

StartupSaver is a program designed to improve your computer's startup time and quality by executing programs at intervals.

Contents:

1. Config
2. Import
3. Export
4. Run
5. Future Plans
6. Known Bugs
7. Changelog
  7.1 Small note
8. About me!
  8.1 Special thanks
9. Legal Mumbo Jumbo


## 1. Config

Delay: the amount of time (in seconds) before StartupSaver launches the first program.

Show "Starting" window: shows window when StartupSaver.exe is run.

Beep on error: currently only works on startup, if program cannot find file to run.

Start on startup: if checked, will create a shorcut in the Startup folder. If unchecked, will delete that shorcut.


## 2. Import

(Hopefully) shows all of the Registry, Global Registry, Startup Folder, and Global Startup Folder entries, in their separate tabs. Check what you want, then click "Import," and it should add to the list. Please note, however, that the list will NOT include all of the options available under MSConfig, only the checked ones. This is because MSConfig stores its entries in a completely different part of the registry, and I have not seen the need to import all of the registry options that the user does already have active.


## 3. Export

Check one or more of the following:

  - Registry
  - Global Registry
  - Startup
  - Global startup
  - StartupSaver

Then you can select from REG, LNK, or TXT. 
REG exports to a registry hive file, which you can then merge with your registry, if you want to have all your startup programs in one place. 
LNK creates a folder filled with links to the startup programs, designed so you can copy them into your startup folder, if you want. 
TXT just exports them to a text file, available for viewing.


## 4. Running

You don't *have* to have StartupSaverConfig. My main reason for keeping the programs separate is that if you wanted, you could manually edit the INI and just have StartupSaver.exe. In terms of editing the INI, if something isn't a variable number (such as delay time), then 1 = enabled and 0 = disabled (like for "showProgress", 1 shows the "Starting in..." window, 0 disables it.)

With v0.96, checked items run, unchecked items are skipped.


## 5. Future plans

-Add option to disable startup items after import.
-Need to add some indication that Export worked. (I'm lazy.)
-Possibly add "Working Directory" for each entry


## 6. Known bugs

-The massive "Browse..." button isn't responsive at first
-When trying to open the folder after exporting LNKs, it gives "Access Denied" sometimes in 7/Vista


## 7. Changelog

-  v1.0 Stable!
  - Scrapped "Install" 'feature'
  - Redid "Import" window (Yay for Listviews!)
  - Renamed almost every variable
  - Added a ton of comments
  - Switched to the GPL v3!
  - Added ability to import disabled entries
  - Added support for importing on 64-bit systems (or rather, 32-bit entries on them)
  - Added ability to delete imported items after done
  - Made child windows show up relative to their parents
  - Scrapped "Export" ability to export anything other than StartupSaver
  - Added Locale
- v0.97
  - Added ability to resize main window
- v0.965
  - Removed CMsgBox from program (with "Beep on error")
  - Added Working Directories
- v0.96
  - Added checkmarks (thanks, lanux128!)
  - Greys "Export" when nothing is selected on export screen
  - Made selecting path remember last place.
  - Made export a browse prompt
- v0.95
  - Added message to switch to installed version.
  - Added Exporting to REG, LNK, and TXT. But beta.
  - Import is FINALLY stable!
  - Added import from HKCU registry.
  - Fixed GUI on import to automatically resize.
  - Fixed infinite loop for deleteing unnecessary INI entries.
  - Fixed tooltip for (hopefully) all resolutions
  - Added export from HKCU.
  - Made it where long filenames are split between lines on Import screen.
- v0.94
  - Finally made a readme. :P
  - Went back to separate EXEs :P
  - Completely rebuilt main GUI, added Listview. Allows for more than 10 programs!
  - Added global shortcuts to import
  - Added tabs to import
  - Added URL to my website in About :P
  - Added ability to move up and down in list.
  - Added arguments as a separate field.
  - Added importing of arguments in registry entries.
  - Added Deletion of unneeded INI entries
- v0.93
  - Changed to Uni-code (StartupSaver.exe was a part of StartupSaverConfig.exe)
  - Added ability to import Registry and Startup Folder(up to 10)
- v0.92
  - Added "Starting in..."
  - Changed "destroying" GUIs to "closing" :P
  - Added loop to create main GUI, GREATLY cleaning code.
  - Completely reorganized code to make it easier to manuever.
  - Added check if INI exists
- v0.9
  - Made stable-ish
- below v0.9
  - Alpha. All I'm gonna say.

## 7.1 Small note

Wow. It's really amazing to see how far I've come. I have in no way "arrived" when it comes to programming, but when I came back to this program after a year or so and saw all of the things I'd learned since then, I'm kind of amazed.
   -I initialized and manually incremented "Counter" instead of using "A_Index"
   -I MANUALLY PLACED ALL GUI ELEMENTS instead of basing them off the previous.
   -I read all programs/arguments into variables (which is unnecessary), and ended up running two loops
   -I did not comment NEARLY enough, even when it comes to separating sections.
   -I used terrible variable & control names, even for me.
   -I used "ifequal"......why?


## 8. About me!

My name is Jon Petraglia. I'm currently a college student, enrolled in Computer Science 1, where I am learning Java. One day I stumbled across AutoHotkey, and I was amazed at how easy it was to write a program. So easy, in fact, that I began writing little scripts. The very first "program" I wrote called "lolcats ez capshun" was designed to make it easier to name pictures when saving. It copied selected text to the keyboard, made everything lowercase, deleted things in the text like commas and periods, showed a window with the selected text, and then pasted it in. It took several hours for me to write, spanning days in my freetime. The next program I wrote was called "Breaktime," designed to help me take a break when playing Battle for Wesnoth. The user set the minutes, and a tooltip popped up in the corner telling when the break would be, and then at the break, it minimized all windows, muted the sound, moved to a different virtual desktop, and displayed the message "BREAK TIME."

Then I decided to put my coding skills to the test and REALLY create a program. I'd seen a program called Startup Delayer that was supposed to help with startup, but the UI was sooooo clunky, and it just didn't run how I'd like (at least in the old version I tried). I'd actually been wanting to do it for a long time, then as soon as I found out that AutoHotkey had "IniRead," I started coding. It took me a long time to write the very first version of StartupSaver (whose name, by the way, I came up with on a whim), since I had never before designed GUI before, and everything to the AHK language was foreign to me. It took ALOT of googling, and even more trial and error, but eventually, I got the first "stable alpha" release of StartupSaver. Ever since then, I've been just trying to make it better, thinking up ideas that people would like.

WHAT YOU CAN DO FOR ME:
No, don't donate. Ok, but only if you really want. Ha. But seriously, there are three things that would make my day: (1) visit my freeware blog, freewarewire.blogpost.com, check it out, drop a comment, and see if it's something you'd consider bookmarking, (2) e-mail me at freewarewire@gmail.com with your thanks, bugs, or suggestions, and/or (3) send me something funny, especially a funny LOLCAT. Just let me know you tried the program in some way!

Thanks so much for trying StartupSaver. I hope you like it, and it serves you well.
~Jon

PS - If you want to see whatever programs/projects I'm working on, visit the website at the top of this Readme!

## 8.1 Special Thanks

Special thanks to:

  - The autohotkey forums, for having topics I can lurk about. :P
  - The autohotkey documentation, for having 90% of what I needed to know.
  - Google, for being my bestest friend.
  - jballi, for creating CMsgBox     http://www.autohotkey.com/forum/viewtopic.php?t=35428
  - SciTE, for saving me with AutoHotkey syntax...and F5.    http://www.scintilla.org/SciTE.html
  - Tuncay and the Guest from the AutoHotkey forum, for answering the only question I was dumb enough not to get myself.  http://www.autohotkey.com/forum/viewtopic.php?p=251335
  - The GIMP (http://www.gimp.org), for being there to help me design a simple icon.
  - My netbook, Lewis, for handling coding at all hours of the morning.
  - Autohotkey, for being so easy, an idiot like me could do it.

## 9. Legal Mumbo Jumbo

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

                                    SSSSSSSS
                                   SS      SS
                                  SS         ssssssss
                                  SS        ss      ss
                                   SSS     ss
                                     SSSSSSss
                                            ss
                                             ssssssss
                                           SS       ss
                                  SS      SS         ss
                                   SSSSSSSS          ss
                                             ss     ss
                                              sssssss