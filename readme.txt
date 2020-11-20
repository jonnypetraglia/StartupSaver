~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~StartupSaver v0.95~~~~~~~~~
~~~~~~~(C) Jon Petraglia 2009~~~~~~~
~~~~~FreewareWire.blogspot.com~~~~~~
~~~~~~amadmadhatter@gmail.com~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

StartupSaver is a program designed to improve your computer's startup time and quality by executing programs at intervals.

Contents:
1. Config
2. Install
3. Uninstall
4. Import
5. Export
6. Run
7. Future Plans
8. Known Bugs
9. Changelog
10. About me!
10.1 Special thanks


1.----------Config---------------

Delay: the amount of time before StartupSaver launches the first program.

Show "Starting" window: shows window when StartupSaver.exe is run.

Beep on error: currently only works on startup, if program cannot find file to run.

Start on startup: if checked, will create a shorcut in the Startup folder. If unchecked, will delete that shorcut.


2.----------Install---------------

Copies StartupSaverConfig.exe, StartupSaver.exe, and StartupSaver.ini to the folder of your choice, with the option of a start menu entry and adding to the Startup Folder.

3.----------Uninstall---------------
  
Uninstalls from working directory. Also in beta, so....just delete the files and shortcuts, if need be.

4.----------Import---------------

(Hopefully) shows all of the Registry, Global Registry, Startup Folder, and Global Startup Folder entries, in their separate tabs. Check what you want, then click "Import," and it should add to the list. Please note, however, that the list will NOT include all of the options available under MSConfig, only the checked ones. This is because MSConfig stores its entries in a completely different part of the registry, and I have not seen the need to import all of the registry options that the user does already have active.

5.----------Export---------------

Check one or more of the following:
-Registry
-Global Registry
-Startup
-Global startup
-StartuPSaver
Then you can select from REG, LNK, or TXT. 
REG exports to a registry hive file, which you can then merge with your registry, if you want to have all your startup programs in one place. 
LNK creates a folder filled with links to the startup programs, designed so you can copy them into your startup folder, if you want. 
TXT just exports them to a text file, available for viewing.

6.----------Running---------------

You don't *have* to have StartupSaverConfig. My main reason for keeping the programs separate is that if you wanted, you could manually edit the INI and just have StartupSaver.exe. In terms of editing the INI, if something isn't a variable number (such as delay time), then 1 = enabled and 0 = disabled (like for "showProgress", 1 shows the "Starting in..." window, 0 disables it.)

7.----------Future plans---------------

-In Coding:
  +Rename all variables, possibly.
  +Add better comments to program.
-Add option to disable startup items after import.
-"Select all" and "select none" in import
-Need to add some indication that Export worked. (I'm lazy.)


8.----------Known bugs---------------

-Uninstall is untested. May not delete everything.
-Export is unreliable/mostly untested.

9.----------Changelog---------------

v0.95
-Added message to switch to installed version.
-Added Exporting to REG, LNK, and TXT. But beta.
-Import is FINALLY stable!
-Added import from HKCU registry.
-Fixed GUI on import to automatically resize.
-Fixed infinite loop for deleteing unnecessary INI entries.
-Fixed tooltip for (hopefully) all resolutions
-Added export from HKCU.
-Made it where long filenames are split between lines on Import screen.
v0.94
-Finally made a readme. :P
-Went back to separate EXEs :P
-Completely rebuilt main GUI, added Listview. Allows for more than 10 programs!
-Added global shortcuts to import
-Added tabs to import
-Added URL to my website in About :P
-Added ability to move up and down in list.
-Added arguments as a separate field.
-Added importing of arguments in registry entries.
-Added Deletion of unneeded INI entries
v0.93
-Changed to Uni-code (StartupSaver.exe was a part of StartupSaverConfig.exe)
-Added ability to import Registry and Startup Folder(up to 10)
v0.92
-Added "Starting in..."
-Changed "destroying" GUIs to "closing" :P
-Added loop to create main GUI, GREATLY cleaning code.
-Completely reorganized code to make it easier to manuever.
-Added check if INI exists
v0.9
-Made stable-ish
below v0.9
-Alpha. All I'm gonna say.

10.----------About me!---------------

My name is Jon Petraglia. I'm currently a college student, enrolled in Computer Science 1, where I am learning Java. One day I stumbled across AutoHotkey, and I was amazed at how easy it was to write a program. So easy, in fact, that I began writing little scripts. The very first "program" I wrote called "lolcats ez capshun" was designed to make it easier to name pictures when saving. It copied selected text to the keyboard, made everything lowercase, deleted things in the text like commas and periods, showed a window with the selected text, and then pasted it in. It took several hours for me to write, spanning days in my freetime. The next program I wrote was called "Breaktime," designed to help me take a break when playing Battle for Wesnoth. The user set the minutes, and a tooltip popped up in the corner telling when the break would be, and then at the break, it minimized all windows, muted the sound, moved to a different virtual desktop, and displayed the message "BREAK TIME."

Then I decided to put my coding skills to the test and REALLY create a program. I'd seen a program called Startup Delayer that was supposed to help with startup, but the UI was sooooo clunky, and it just didn't run how I'd like (at least in the old version I tried). I'd actually been wanting to do it for a long time, then as soon as I found out that AutoHotkey had "IniRead," I started coding. It took me a long time to write the very first version of StartupSaver (whose name, by the way, I came up with on a whim), since I had never before designed GUI before, and everything to the AHK language was foreign to me. It took ALOT of googling, and even more trial and error, but eventually, I got the first "stable alpha" release of StartupSaver. Ever since then, I've been just trying to make it better, thinking up ideas that people would like.

WHAT YOU CAN DO FOR ME:
No, don't donate. Ok, but only if you really want. Ha. But seriously, there are three things that would make my day: (1) visit my freeware blog, freewarewire.blogpost.com, check it out, drop a comment, and see if it's something you'd consider bookmarking, (2) e-mail me at amadmadhatter@gmail.com with your thanks, bugs, or suggestions, and/or (3) send me something funny, especially a funny LOLCAT. Just let me know you tried the program in some way!

Thanks so much for trying StartupSaver. I hope you like it, and it serves you well.
~Jon

PS - If you want to see whatever programs/projects I'm working on, visit the "My Freeware" tag on my blog, or if it's not there, e-mail me.

10.1----Special Thanks----
Special thanks to:
-The autohotkey forums, for having topics I can lurk about. :P
-The autohotkey documentation, for having 90% of what I needed to know.
-Google, for being my bestest friend.
-jballi, for creating CMsgBox     http://www.autohotkey.com/forum/viewtopic.php?t=35428
-SciTE, for saving me with AutoHotkey syntax...and F5.    http://www.scintilla.org/SciTE.html
-Tuncay and the Guest from the AutoHotkey forum, for answering the only question I was dumb enough not to get myself.  http://www.autohotkey.com/forum/viewtopic.php?p=251335
-The GIMP (http://www.gimp.org), for being there to help me design a simple icon.
-My netbook, Lewis, for handling coding at all hours of the morning.
-Autohotkey, for being so easy, an idiot like me could do it.

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