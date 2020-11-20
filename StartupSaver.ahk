; <COMPILER: v1.0.47.6>

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


if showprogress, 1
{ countdown:=stall
Gui, Add, Text, vStartingUp x5, % "Starting in " . countdown
Gui, Add, Progress, w100 h20 Range1-100 vProgress -Smooth
Gui, Add, Button, w60 x30 default, Cancel
Gui -Sysmenu +Owner
Gui, Show, Autosize, StartupSaver
}

Running:
Loop, %stall%
{ sleep, 1000
  if showProgress, 1
  { GuiControl,, Progress, + %bar%
  dotdotdot :=  dotdotdot . "."
  countdown--
  phrase:="Starting in " . countdown
  GuiControl,, StartingUp, %phrase%
 }
}
Gui, destroy

Counter=0
Loop, %numofprogs%
{ ifexist % prog%Counter%
  { sleep, % time%Counter%
    run, % prog%Counter%
  }
   Else
   {
   CMsgBox("","File Not Found - StartupSaver", "The file:`n" prog%Counter% "`ndoes not seem to exist.","!","Okay", noise " +Timeout=5")
   }
 Counter++
}
GuiClose:
ButtonCancel:
 ExitApp








































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































CMsgBox(p_Owner=""
       ,p_Title=""
       ,p_Text=""
       ,p_Icon=""
       ,p_Buttons=""
       ,p_Options=""
       ,p_GUIOptions=""
       ,p_IconOptions=""
       ,p_TextOptions=""
       ,p_TextFont=""
       ,p_TextFontOptions=""
       ,p_ButtonOptions=""
       ,p_ButtonFont=""
       ,p_ButtonFontOptions=""
       ,p_BGColor="")
    {



    Global CMsgBox_Command





    Static Dumm926

          ,s_StartGUI:=62




          ,s_ActiveGUI







          ,s_ActiveError:=false




          ,s_MarginX:=13
          ,s_MarginY:=13



          ,s_DefaultText:="Press OK to continue."



          ,s_DefaultButtons:="*OK"




          ,s_DefaultErrorButtons   :="*OK"
          ,s_DefaultQuestionButtons:="*&Yes|&No"
          ,s_DefaultAlertButtons   :="*OK"
          ,s_DefaultWarningButtons :="*OK|Cancel"
          ,s_DefaultInfoButtons    :="*OK"




          ,s_DefaultErrorSound     :="*16"
          ,s_DefaultQuestionSound  :="*32"
          ,s_DefaultAlertSound     :="*48"
          ,s_DefaultWarningSound   :="*48"
          ,s_DefaultInfoSound      :="*64"




          ,s_DefaultIcon:=""



          ,s_DefaultIconFile:="Shell32.dll"





          ,s_Options:="+Copy +EnableCloseIfButton=Cancel +EnableCloseIfOneButton +EscapeToClose +Sound"





          ,s_IconOptions:=""







          ,s_TextOptions:=""









          ,s_DefaultTextFont:=""




          ,s_DefaultTextFontOptions:=""




          ,s_MaxWindowPct:=60












          ,s_ButtonOptions:="w75"







          ,s_DefaultButtonFont:=""




          ,s_DefaultButtonFontOptions:=""




           ,s_ButtonSpacer:=6




          ,s_GUIOptions:="+AlwaysOnTop -SysMenu"




          ,s_DefaultBGColor:=""







          ,SM_CYCAPTION



          ,SM_CYSMCAPTION


          ,SM_CXBORDER


          ,SM_CYBORDER


          ,SM_CYMENU


          ,SM_CXFIXEDFRAME



          ,SM_CYFIXEDFRAME



          ,SM_CXSIZEFRAME



          ,SM_CYSIZEFRAME



          ,SM_CXVSCROLL










    IfWinExist ahk_group CMsgBox_Group
        {
        if not s_ActiveError
            {

            s_ActiveError:=true



            gui %s_ActiveGUI%:+Disabled



            MsgBox
                ,262160
                ,%A_ThisFunc% Error,
                   (ltrim join`s
                    A %A_ThisFunc% window already exists.  Only one %A_ThisFunc%
                    window can be used at a time.  %A_Space%
                   )


            gui %s_ActiveGUI%:-Disabled
            gui %s_ActiveGUI%:Show



            s_ActiveError:=false
            }



        Errorlevel=FAIL
        return ""
        }








    SplitPath A_ScriptName,,,,l_ScriptName
    CMsgBox_Command:=""
    l_ErrorLevel:=0
    l_Result:=""
    l_Showing:=false



    SysGet l_MonitorWorkArea,MonitorWorkArea

    if SM_CYCAPTION is Space
        {
        SysGet SM_CYCAPTION,4
        SysGet SM_CYSMCAPTION,51
        SysGet SM_CXBORDER,5
        SysGet SM_CYBORDER,6
        SysGet SM_CYMENU,15
        SysGet SM_CXFIXEDFRAME,7
        SysGet SM_CYFIXEDFRAME,8
        SysGet SM_CXSIZEFRAME,32
        SysGet SM_CYSIZEFRAME,33
        SysGet SM_CXVSCROLL,2
        }












    p_Owner=%p_Owner%
    if p_Owner is not Integer
        p_Owner=0
     else
        if p_Owner not between 1 and 99
            p_Owner=0
         else
            {

            gui %p_Owner%:+LastFoundExist
            IfWinNotExist
                p_Owner=0
            }





    p_Title=%p_Title%
    if p_Title is Space
        p_Title:=l_ScriptName
     else
        {

        if SubStr(p_Title,1,2)="++"
            {
            StringTrimLeft p_Title,p_Title,2
            p_Title:=l_ScriptName . A_Space . p_Title
            }
        }





    if p_Text is Space
        if p_Buttons is Space
            p_Text:=s_DefaultText






    p_Icon=%p_Icon%
    if p_Icon is Space
        p_Icon:=s_DefaultIcon





    p_Buttons=%p_Buttons%
    if p_Buttons is Space
        {

        if p_Icon in !,A,Alert
            p_Buttons:=s_DefaultAlertButtons
         else

            if p_Icon in W,Warn,Warning
                p_Buttons:=s_DefaultWarningButtons
             else

                if p_Icon in ?,Q,Question
                    p_Buttons:=s_DefaultQuestionButtons
                 else

                    if p_Icon in E,Error,X
                        p_Buttons:=s_DefaultErrorButtons
                     else

                        if p_Icon in I,Info
                            p_Buttons:=s_DefaultInfoButtons
                         else

                            p_Buttons:=s_DefaultButtons
        }



    if InStr(p_Buttons,"*")=0
        p_Buttons:="*" . p_Buttons





    p_Options:=s_Options . A_Space . p_Options
    p_Options=%p_Options%





    p_GUIOptions:=s_GUIOptions . A_Space . p_GUIOptions
    p_GUIOptions=%p_GUIOptions%
    if p_Owner
        {
        StringReplace,p_GUIOptions,p_GUIOptions,+AlwaysOnTop,,All
        StringReplace,p_GUIOptions,p_GUIOptions,AlwaysOnTop,,All
        }





    p_IconOptions:=s_IconOptions . A_Space . p_IconOptions
    p_IconOptions=%p_IconOptions%





    p_TextOptions:=s_TextOptions . A_Space . p_TextOptions
    p_TextOptions=%p_TextOptions%





    p_TextFont=%p_TextFont%
    if p_TextFont is Space
        p_TextFont:=s_DefaultTextFont





    p_TextFontOptions=%p_TextFontOptions%
    if p_TextFontOptions is Space
        p_TextFontOptions:=s_DefaultTextFontOptions





    p_ButtonOptions:=s_ButtonOptions . A_Space . p_ButtonOptions
    p_ButtonOptions=%p_ButtonOptions%





    p_ButtonFont=%p_ButtonFont%
    if p_ButtonFont is Space
        p_ButtonFont:=s_DefaultButtonFont





    p_ButtonFontOptions=%p_ButtonFontOptions%
    if p_ButtonFontOptions is Space
        p_ButtonFontOptions:=s_DefaultButtonFontOptions





    p_BGColor=%p_BGColor%
    if p_BGColor is Space
        p_BGColor:=s_DefaultBGColor









    l_DQLoop:=false



    l_AssignmentOptions=
       (ltrim join`s
        Checkbox
        EnableCloseIfButton
        GroupBox
        IconFile
        MinTextW
        MinTextH
        Radio
        SoundFile
        Timeout
       )






    loop parse,p_Options,%A_Space%
        {



        if l_DQLoop
            {

            %l_DQLoopVar%:=%l_DQLoopVar% . A_Space . A_LoopField



            if SubStr(%l_DQLoopVar%,StrLen(%l_DQLoopVar%))=""""
                {

                StringTrimRight %l_DQLoopVar%,%l_DQLoopVar%,1



                if not l_OptionEnabled
                    %l_DQLoopVar%:=""



                l_DQLoop:=false
                }


            continue
            }



        if StrLen(A_LoopField)<2
            continue





        l_OptionEnabled:=true
        if SubStr(A_LoopField,1,1)="-"
            l_OptionEnabled:=false



        l_Option:=A_LoopField
        if SubStr(A_LoopField,1,1)="+"
        or SubStr(A_LoopField,1,1)="-"
            StringTrimLeft l_Option,l_Option,1





        l_DQLoop:=false
        l_AssignmentOption:=false
        loop parse,l_AssignmentOptions,%A_Space%
            {
            if SubStr(l_Option,1,StrLen(A_LoopField))=A_LoopField
                {
                l_AssignmentOption:=true
                o_%A_LoopField%:=SubStr(l_Option,StrLen(A_LoopField)+1)



                if SubStr(o_%A_LoopField%,1,1)="="
                    StringTrimLeft o_%A_LoopField%,o_%A_LoopField%,1



                if SubStr(o_%A_LoopField%,1,1)=""""
                    {

                    StringTrimLeft o_%A_LoopField%,o_%A_LoopField%,1



                    if SubStr(o_%A_LoopField%,StrLen(o_%A_LoopField%))=""""
                        StringTrimRight o_%A_LoopField%,o_%A_LoopField%,1
                     else
                        {
                        l_DQLoop:=true
                        l_DQLoopVar:="o_" . A_LoopField
                        }
                    }



                if not l_OptionEnabled
                    o_%A_LoopField%:=""


                break
                }
            }



            if l_AssignmentOption
                continue





        l_ValidOptionName:=true
        loop parse,l_Option
            {
            if A_LoopField is AlNum
                continue

            if A_LoopField in #,_,@,$,?,[,]
                continue

            l_ValidOptionName:=false
            break
            }

        if not l_ValidOptionName
            continue





        if l_OptionEnabled
            o_%l_Option%:=true
         else
            o_%l_Option%:=false
        }













    if o_NoButtons
        p_Buttons=



    if o_MinTextW is not Number
        o_MinTextW:=""



    if o_MinTextH is not Number
        o_MinTextH:=""



    if o_Timeout is Number
        o_Timeout:=o_Timeout*1000
     else
        o_Timeout:=""






    if o_EnableCloseIfButton is not Space
        if Instr("|" . RegExReplace(p_Buttons,"[*&\n]","") . "|"
                ,"|" . RegExReplace(o_EnableCloseIfButton,"[*&\n]") . "|")
            o_Close:=true
         else
            o_EnableCloseIfButton:=""






    if o_EnableCloseIfOneButton
        if InStr(p_Buttons,"|")=0
            o_Close:=true
         else
            o_EnableCloseIfOneButton:=false









    l_GUI:=s_StartGUI
    loop
        {

        gui %l_GUI%:+LastFoundExist
        IfWinNotExist
            {
            s_ActiveGUI:=l_GUI
            break
            }


        if l_GUI=99
            {
            MsgBox
                ,262160
                ,CMsgBox Error,
                   (ltrim  join`s
                    Unable to create CMsgBox window.  GUI windows %s_StartGUI%
                    to 99 are already in use.  %A_Space%
                   )

            outputdebug
                ,End Func: %A_ThisFunc% (Unable to create CMsgBox window)
            Errorlevel=FAIL
            return ""
            }


        l_GUI++
        }










    if p_Text contains ?
        l_SoundFile:="*32"
     else
        l_SoundFile:="*-1"





    if p_Icon is Space
        {
        l_Icon:=""
        l_IconFile:=""
        }
     else



        if p_Icon=*
            {
            l_Icon=1
            if A_IsCompiled
                l_IconFile:=A_ScriptName
             else
                l_IconFile:=A_AhkPath



            if o_NoIcon
                l_Icon:=""
            }
         else



            if p_Icon is Number
                {
                l_Icon:=p_Icon
                l_IconFile:=s_DefaultIconFile
                if o_IconFile is not Space
                    l_IconFile:=o_IconFile



                if o_NoIcon
                    l_Icon:=""
                }
             else
                {



                l_IconFile:="User32.dll"



                if p_Icon in !,A,Alert
                    {
                    l_Icon=2
                    l_SoundFile:=s_DefaultAlertSound
                    }
                 else

                    if p_Icon in W,Warn,Warning
                        {
                        l_Icon=2
                        l_SoundFile:=s_DefaultWarningSound
                        }
                     else

                        if p_Icon in ?,Q,Question
                            {
                            l_Icon=3
                            l_SoundFile:=s_DefaultQuestionSound
                            }
                         else

                            if p_Icon in E,Error,X
                                {
                                l_Icon=4
                                l_SoundFile:=s_DefaultErrorSound
                                }
                             else

                                {
                                l_Icon=5
                                l_SoundFile:=s_DefaultInfoSound
                                }


                if o_NoIcon
                    l_Icon:=""
                }









    l_TextControlH=0






    if InStr(A_Space . p_TextOptions," w")=0
        {

        if (p_TextFont or p_TextFontOptions)
            gui %l_GUI%:Font,%p_TextFontOptions%,%p_TextFont%
        gui %l_GUI%:Add,Text,%p_TextOptions%,%p_Text%
        GUIControlGet l_TextControl,%l_GUI%:Pos,Static1

        l_PictureControlW=0
        if l_icon
            {
            gui %l_GUI%:Add,Picture,%p_IconOptions%,%l_IconFile%
            GUIControlGet l_PictureControl,%l_GUI%:Pos,Static2
            }

        gui %l_GUI%:Destroy





        l_CMsgBoxW:=l_PictureControlW+l_TextControlW+(s_MarginX*3)
        if o_GroupBox is not Space
            l_CMsgBoxW:=l_CMsgBoxW+(s_MarginX*2)



        if InStr(p_GUIOptions,"-Caption")
            {
            if InStr(p_GUIOptions,"+Border")

                l_CMsgBoxW:=l_CMsgBoxW+(SM_CXBORDER*2)
            }
         else

            l_CMsgBoxW:=l_CMsgBoxW+(SM_CXFIXEDFRAME*2)




        l_MaxCMsgBoxW:=Round(l_MonitorWorkAreaRight*(s_MaxWindowPct/100))





        if (l_CMsgBoxW>l_MaxCMsgBoxW)
            {

            l_MaxTextControlW:=l_TextControlW-(l_CMsgBoxW-l_MaxCMsgBoxW)


            p_TextOptions:=p_TextOptions . " w" . l_MaxTextControlW
            }
         else
            {




            if o_MinTextW
                {

                if (l_TextControlW<o_MinTextW)
                    {

                    l_MaxTextControlW:=l_TextControlW+(l_MaxCMsgBoxW-l_CMsgBoxW)



                    if (o_MinTextW<l_MaxTextControlW)
                        p_TextOptions:=p_TextOptions . " w" . o_MinTextW
                     else
                        p_TextOptions:=p_TextOptions . " w" . l_MaxTextControlW
                    }
                }
            }
        }






    if o_MinTextH
        {

        if InStr(A_Space . p_TextOptions," h")=0
       and InStr(A_Space . p_TextOptions," r")=0
            {




            if (l_TextControlH=0 or InStr(A_Space . p_TextOptions," w"))
                {


                if (l_TextControlH<o_MinTextH)
                    {


                    if (p_TextFont or p_TextFontOptions)
                        gui %l_GUI%:Font,%p_TextFontOptions%,%p_TextFont%
                    gui %l_GUI%:Add,Text,%p_TextOptions%,%p_Text%
                    GUIControlGet l_TextControl,%l_GUI%:Pos,Static1
                    gui %l_GUI%:Destroy
                    }
                }





            if (l_TextControlH<o_MinTextH)
                p_TextOptions:=p_TextOptions . " h" . o_MinTextH
            }
        }








    if p_Owner
        {
        gui %p_Owner%:+Disabled
        gui %l_GUI%:+Owner%p_Owner%

        }




    gui %l_GUI%:Margin,%s_MarginX%,%s_MarginY%
    gui %l_GUI%:+LabelCMsgBox_
            || %p_GUIOptions%
            || -MinimizeBox





    if p_BGColor is not Space
        gui %l_GUI%:Color,%p_BGColor%





    Static CMsgBox_GroupBox
    if o_GroupBox is not Space
        gui %l_GUI%:Add
           ,GroupBox
           ,+Wrap
                || vCMsgBox_GroupBox
           ,% (o_GroupBox=1 ? "" : o_GroupBox)





    Static CMsgBox_Icon
    if l_Icon
        {

        l_IconOptions:=p_IconOptions . A_Space . "Section"
        if o_GroupBox is not Space
            l_IconOptions:=l_IconOptions
                . " xp+" . s_MarginX
                . " yp+" . s_MarginY*2

        if l_Icon>1
            l_IconOptions:=l_IconOptions . A_Space . "Icon" . l_Icon



        gui %l_GUI%:Add
           ,Picture
           ,%l_IconOptions%
                || vCMsgBox_Icon
           ,%l_IconFile%
        }





    Static CMsgBox_Text


    if (p_TextFont or p_TextFontOptions)
        gui %l_GUI%:Font,%p_TextFontOptions%,%p_TextFont%



    if l_Icon
        p_TextOptions:="x+" . s_MarginX . " yp " . p_TextOptions
     else
        if o_GroupBox is not Space
            p_TextOptions:="Section "
                . " xp+" . s_MarginX
                . " yp+" . s_MarginY*2
                . A_Space
                . p_TextOptions
        else
            p_TextOptions:="Section " . p_TextOptions



    gui %l_GUI%:Add
       ,Text
       ,%p_TextOptions%
            || vCMsgBox_Text
            || gCMsgBox_DragAction
       ,%p_Text%



    gui %l_GUI%:font





    l_YOption=
    if o_GroupBox is not Space
        {

        l_IconControlW=0
        l_IconControlH=0
        if l_Icon
            GUIControlGet l_IconControl,%l_GUI%:Pos,CMsgBox_Icon

        GUIControlGet l_TextControl,%l_GUI%:Pos,CMsgBox_Text



        l_GBControlW:=l_IconControlW+l_TextControlW+(s_MarginX*3)
        if (l_IconControlH>l_TextControlH)
            l_GBControlH:=l_IconControlH+(s_MarginY*4)
         else
            l_GBControlH:=l_TextControlH+(s_MarginY*4)



        GUIControl
            ,%l_GUI%:Move
            ,CMsgBox_GroupBox
            ,w%l_GBControlW% h%l_GBControlH%



        GUIControlGet l_GBControl,Pos,GBControl

        l_YOption:="y" . l_GBControlH+(s_MarginY*2) . A_Space
        }





    Static CMsgBox_Checkbox1
          ,CMsgBox_Checkbox2
          ,CMsgBox_Checkbox3
          ,CMsgBox_Checkbox4
          ,CMsgBox_Checkbox5
          ,CMsgBox_Checkbox6
          ,CMsgBox_Checkbox7
          ,CMsgBox_Checkbox8
          ,CMsgBox_Checkbox9






    if o_CheckBox is not Space
        {
        loop parse,o_Checkbox,|,
            gui %l_GUI%:Add
                ,Checkbox
                ,% (A_Index=1 ? "xm " . l_YOption : "y+5 ")
                 . (InStr(A_LoopField,"*") ? " Checked " : "")
                 . " vCMsgBox_Checkbox" . A_Index
                ,% RegExReplace(A_LoopField, "\*")


        l_YOption=
        }
     else
        {



        Static CMsgBox_Radio
        if o_Radio is not Space
            {
            loop parse,o_Radio,|,
                gui %l_GUI%:Add
                    ,Radio
                    ,% (A_Index=1 ? "xm " . l_YOption : "y+5 ")
                    .  (InStr(A_LoopField,"*") ? " Checked " : "")
                    .  (A_Index=1 ? " vCMsgBox_Radio" : "")
                    ,% RegExReplace(A_LoopField, "\*")



            l_YOption=
            }
        }








    if (p_ButtonFont or p_ButtonFontOptions)
        gui %l_GUI%:Font,%p_ButtonFontOptions%,%p_ButtonFont%


    Static CMsgBox_Button1
          ,CMsgBox_Button2
          ,CMsgBox_Button3
          ,CMsgBox_Button4
          ,CMsgBox_Button5
          ,CMsgBox_Button6
          ,CMsgBox_Button7
          ,CMsgBox_Button8
          ,CMsgBox_Button9











    l_NbrOfButtons=0
    loop parse,p_Buttons,|
        {
        l_NbrOfButtons++


        gui %l_GUI%:Add
            ,Button
            ,% (A_Index=1 ? "xm " . l_YOption : "x+" . s_ButtonSpacer . A_Space)
                . (InStr(A_LoopField,"*") ? "Default " : A_Space)
                . p_ButtonOptions
                . " vCMsgBox_Button" . A_Index
                . " gCMsgBox_Button"
            ,% RegExReplace(A_LoopField, "\*")



        if A_LoopField contains *
            GUIControl
                ,%l_GUI%:Focus
                ,CMsgBox_Button%A_Index%
        }



    gui %l_GUI%:font



    gui %l_GUI%:Show,AutoSize Hide,%p_Title%





    if p_Buttons is not Space
        {

        gui %l_GUI%:+LastFound
        WinGetPos,,,l_CMsgBoxW



        if InStr(p_GUIOptions,"-Caption")
            {
            if InStr(p_GUIOptions,"+Border")

                l_CMsgBoxW:=l_CMsgBoxW-(SM_CXBORDER*2)
            }
         else

            l_CMsgBoxW:=l_CMsgBoxW-(SM_CXFIXEDFRAME*2)



        l_TotalButtonWidth=0
        loop %l_NbrOfButtons%
            {
            GUIControlGet
                ,l_Button%A_Index%Control
                ,%l_GUI%:Pos
                ,CMsgBox_Button%A_Index%


            l_TotalButtonWidth:=l_TotalButtonWidth+l_Button%A_Index%ControlW

            if A_Index>1
                l_TotalButtonWidth:=l_TotalButtonWidth+s_ButtonSpacer
            }



        if o_GroupBox is not Space
            if (l_TotalButtonWidth>l_GBControlW)
                {
                l_GBControlW:=l_TotalButtonWidth
                GUIControl
                    ,%l_GUI%:Move
                    ,CMsgBox_GroupBox
                    ,w%l_GBControlW%
                }



        if o_ButtonsLeft
            l_StartButtonPos:=s_MarginX
         else
            if o_ButtonsRight
                l_StartButtonPos:=l_CMsgBoxW-l_TotalButtonWidth-s_MarginX
             else
                l_StartButtonPos:=l_CMsgBoxW/2-(l_TotalButtonWidth/2)



        l_ButtonPos=0
        loop %l_NbrOfButtons%
            {
            GUIControl
                ,%l_GUI%:MoveDraw
                ,CMsgBox_Button%A_Index%
                ,% "x" l_StartButtonPos+l_ButtonPos

            l_ButtonPos:=l_ButtonPos+l_Button%A_Index%ControlW+s_ButtonSpacer
            }
        }





    gui %l_GUI%:+LastFound
    WinGet l_CMsgBox_hWnd,ID
    GroupAdd CMsgBox_Group,ahk_id %l_CMsgBox_hWnd%





    if not o_Close
        CMsgBox_DisableCloseButton(l_CMsgBox_hWnd)








    if p_OWner
        {

        CMsgBox_PopupXY(p_OWner,l_GUI,l_PosX,l_PosY)
        gui %l_GUI%:Show,x%l_PosX% y%l_PosY%
        }
     else
        gui %l_GUI%:Show

    l_Showing:=true









    if o_Sound
        {

        if o_SoundFile is not Space
            l_SoundFile:=o_SoundFile


        if l_SoundFile is not Space
            SoundPlay %l_SoundFile%
        }








    if o_Timeout is not Space
        SetTimer CMsgBox_Timeout,%o_Timeout%








    loop
        {
        sleep 50
        if StrLen(l_Result)
            {



            if o_CheckBox is not Space
                {
                l_ErrorLevel=

                gui %l_GUI%:Submit,NoHide
                loop parse,o_CheckBox,|
                    l_ErrorLevel:=l_ErrorLevel . CMsgBox_Checkbox%A_Index%
                }
             else
                {



                if o_Radio is not Space
                    {
                    gui %l_GUI%:Submit,NoHide
                    l_ErrorLevel:=CMsgBox_Radio
                    }
                }

            break
            }





        if CMsgBox_Command=CopyTextToClipboard
            {
            if o_Copy
                {



                t_Buttons:=p_Buttons
                StringReplace t_Buttons,t_Buttons,*,,All
                StringReplace t_Buttons,t_Buttons,&,,All
                StringReplace t_Buttons,t_Buttons,`n,,All
                StringReplace t_Buttons,t_Buttons,|,%A_Space% %A_Space%,All

                l_Report=
                    (ltrim
                     ---------------------------
                     %p_Title%
                     ---------------------------
                     %p_Text%
                     ---------------------------
                     %t_Buttons%
                     ---------------------------

                    )


                StringReplace,l_Report,l_Report,`n,`r`n,All



                Clipboard:=l_Report
                SoundPlay *-1



                l_Report=
                }


            CMsgBox_Command:=""
            continue
            }
        }









    if p_Owner
        gui %p_Owner%:-Disabled



    gui %l_GUI%:Destroy









    ErrorLevel:=l_ErrorLevel
    return l_Result













    CMsgBox_DragAction:


    PostMessage 0xA1,2
    return



    CMsgBox_Button:


    if not l_Showing
        return



    l_ButtonIndex:=SubStr(A_GUIControl,StrLen(A_GUIControl))
    loop parse,p_Buttons,|
        if (A_Index=l_ButtonIndex)

            l_Result:=RegExReplace(A_LoopField,"[*&\n]")

    return



    CMsgBox_Timeout:
    SetTimer CMsgBox_Timeout,Off
    l_Result:="_Timeout"
    return



    CMsgBox_Escape:


    if not o_EscapeToClose
        return



    CMsgBox_Close:


    if not o_Close
        return






    if p_Buttons is Space
        l_Result:="_Close"
     else
        if o_EnableCloseIfButton is not Space

            l_Result:=RegExReplace(o_EnableCloseIfButton,"[*&\n]")
         else
            if o_EnableCloseIfOneButton

                l_Result:=RegExReplace(p_Buttons,"[*&\n]")
             else
                l_Result:="_Close"



    return
    }














#IfWinActive ahk_group CMsgBox_Group






^c::
CMsgBox_Command=CopyTextToClipboard
return




#IfWinActive


























CMsgBox_DisableCloseButton(hWnd="") {
 If hWnd=
    hWnd:=WinExist("A")
 hSysMenu:=DllCall("GetSystemMenu","Int",hWnd,"Int",FALSE)
 nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu)
 DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-1,"Uint","0x400")
 DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-2,"Uint","0x400")
 DllCall("DrawMenuBar","Int",hWnd)
Return ""
}





































































CMsgBox_PopupXY(p_Parent,p_Child,ByRef p_ChildX,ByRef p_ChildY)
    {



    l_DetectHiddenWindows:=A_DetectHiddenWindows
    DetectHiddenWindows On
    SysGet l_MonitorWorkArea,MonitorWorkArea
    p_ChildX=0
    p_ChildY=0






    if p_Parent is Integer
        if p_Parent between 1 and 99
            {
            gui %p_Parent%:+LastFoundExist
            IfWinExist
                {
                gui %p_Parent%:+LastFound
                p_Parent:="ahk_id " . WinExist()
                }
            }


    WinGetPos l_ParentX,l_ParentY,l_ParentW,l_ParentH,%p_Parent%



    if l_ParentX is Space
        return






    if p_Child is Integer
        if p_Child between 1 and 99
            {
            gui %p_Child%:+LastFoundExist
            IfWinExist
                {
                gui %p_Child%:+LastFound
                p_Child:="ahk_id " . WinExist()
                }
            }



    WinGetPos,,,l_ChildW,l_ChildH,%p_Child%



    if l_ChildW is Space
        return





    p_ChildX:=round(l_ParentX+((l_ParentW-l_ChildW)/2))
    p_ChildY:=round(l_ParentY+((l_ParentH-l_ChildH)/2))


    if (p_ChildX<l_MonitorWorkAreaLeft)
        p_ChildX:=l_MonitorWorkAreaLeft

    if (p_ChildY<l_MonitorWorkAreaTop)
        p_ChildY:=l_MonitorWorkAreaTop

    l_MaximumX:=l_MonitorWorkAreaRight-l_ChildW
    if (p_ChildX>l_MaximumX)
        p_ChildX:=l_MaximumX

    l_MaximumY:=l_MonitorWorkAreaBottom-l_ChildH
    if (p_ChildY>l_MaximumY)
        p_ChildY:=l_MaximumY





    DetectHiddenWindows %l_DetectHiddenWindows%





    return
    }

;  #include CMsgBox.ahk
