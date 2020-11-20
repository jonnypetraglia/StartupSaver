/*
 AdjustResize is a function to help with resizing windows in Autohotkey
 Copyright 2012 Jon Petraglia

    This script is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This script is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/


AdjustResize(controlname,options="w h")
{
 static
 ;Do what you will if the GUI is not a positive integer.
 ifnotinstring, A_ThisLabel,guisize
  return, 404
 Stringreplace, guinum,A_ThisLabel,guisize
 if(guinum="")
  guinum=1
 if !(guinum>0)
  return, 405
 gui %guinum%: +lastfound
 GUI_ID:=WinExist()

 ;If this control hasn't been initialized yet....
 if !%controlname%_start
 {
  Wingetpos, %controlname%_win_last_X,%controlname%_win_last_Y,%controlname%_win_last_W,%controlname%_win_last_H, ahk_id %GUI_ID%
  guicontrolget, %controlname%_last_, pos,%controlname%
  %controlname%_start=1
  return
 }

 ;Get the current positions and adjust them.
 Wingetpos, %controlname%_win_X,%controlname%_win_Y,%controlname%_win_W,%controlname%_win_H, ahk_id %GUI_ID%
 guicontrolget, %controlname%_, pos,%controlname%
 
 loop, parse, options, %A_Space%
 {
	ifinstring, A_loopfield, w
	{	
		%controlname%_w := %controlname%_win_w - ( %controlname%_win_last_w - %controlname%_last_w )
;		stringreplace, scalar_w, A_LoopField, w
	}
	ifinstring, A_loopfield, h
	{
		%controlname%_h := %controlname%_win_h - ( %controlname%_win_last_h - %controlname%_last_h )
;		stringreplace, scalar_h, A_LoopField, h
	}
	ifinstring, A_loopfield, x
	{
		%controlname%_x := %controlname%_win_w - ( %controlname%_win_last_w - %controlname%_last_x - %controlname%_last_w ) - %controlname%_w
;		stringreplace, scalar_x, A_LoopField, x
	}
	ifinstring, A_loopfield, y
	{
	;~   ifinstring, options, h
	   %controlname%_y := %controlname%_win_h - ( %controlname%_win_last_h - %controlname%_last_y - %controlname%_last_h ) - %controlname%_h
;		stringreplace, scalar_y, A_LoopField, y
	;~   Else
	;~    %controlname%_y := %controlname%_win_h - ( %controlname%_win_last_h - %controlname%_last_y)
	 }
}
if !scalar_w
	scalar_w=1
if !scalar_h
	scalar_h=1
if !scalar_x
	scalar_x=1
if !scalar_y
	scalar_y=1

 ;Aaaaaand move it.
 guicontrol, move,%controlname%,% "w" scalar_w * %controlname%_w . " h" . scalar_h * %controlname%_h . " x" . scalar_x * %controlname%_x . " y" . (1/scalar_y) * %controlname%_y

 ;Sets the new parameters of this time to be the old parameters of next time
 %controlname%_win_last_w := %controlname%_win_w
 %controlname%_last_w := %controlname%_w
 %controlname%_win_last_h := %controlname%_win_h
 %controlname%_last_h := %controlname%_h
 %controlname%_win_last_x := %controlname%_win_x
 %controlname%_last_x := %controlname%_x
 %controlname%_win_last_y := %controlname%_win_y
 %controlname%_last_y := %controlname%_y
}



PairListviews(C1, C2)
{
	static
	;Do what you will if the GUI is not a positive integer.
	ifnotinstring, A_ThisLabel,guisize
		return, 404
	Stringreplace, guinum,A_ThisLabel,guisize
	if(guinum="")
		guinum=1
	if !(guinum>0)
		return, 405
	gui %guinum%: +lastfound
	GUI_ID:=WinExist()

	if !%C1%_%C2%_start
	{
		Wingetpos,,,,i_%C1%_%C2%_H, ahk_id %GUI_ID%
		guicontrolget, i_%C1%_, pos,%C1%
		guicontrolget, i_%C2%_, pos,%C2%
		i_%C1%_%C2%_Sum := i_%C1%_h + i_%C2%_h
		%C1%_%C2%_BigA := i_%C1%_%C2%_H - i_%C1%_h - i_%C2%_h		;"BigA" is everything that does not change
		%C1%_%C2%_b := i_%C2%_y - i_%C1%_y - i_%C1%_h				;"b" is the space between the two controls
		%C1%_%C2%_a := %C1%_%C2%_BigA - i_%C1%_y - i_%C1%_%C2%_b	;"a" the trailing space after the second control
		%C1%_%C2%_start=1
		return
	}
	
	Wingetpos,,,,%C1%_%C2%_H, ahk_id %GUI_ID%
	guicontrolget, %C1%_, pos,%C1%
	guicontrolget, %C2%_, pos,%C2%
	%C1%_%C2%_Sum := %C1%_%C2%_H - %C1%_%C2%_BigA
	%C1%_h := Round(i_%C1%_h * (%C1%_%C2%_Sum  / i_%C1%_%C2%_Sum))
	%C2%_h := %C1%_%C2%_Sum - %C1%_h
	%C2%_y := %C1%_%C2%_b + %C1%_h + i_%C1%_y
	
	guicontrol, move, %C1%, % "h" . %C1%_h ;. " y" . i_%C1%_y . " x" . i_%C1%_x . " w" . i_%C1%_w
	guicontrol, move, %C2%, % "h" . %C2%_h . " y"  .   %C2%_y  ;. " x" . i_%C2%_x . " w" . i_%C2%_w
}

