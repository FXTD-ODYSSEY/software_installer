; 河许人 AutoAHK 3.1.1
#SingleInstance Force
#NoEnv
;以管理员身份运行
if !A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Add, GroupBox, x10 y6 w120 h205, 效率软件
Gui Add, CheckBox, x20 y23 w100 h25 +Checked vListary, Listary
Gui Add, CheckBox, y+5 w100 h25 +Checked vQTTabBar, QTTabBar
Gui Add, CheckBox, y+5 w100 h25 +Checked vDitto, Ditto
Gui Add, CheckBox, y+5 w100 h25 vWGesture, WGesture
Gui Add, CheckBox, y+5 w100 h25 vQuicker, Quicker
Gui Add, CheckBox, y+5 w100 h25 vDesktop, 腾讯桌面管理
Gui Add, GroupBox, x135 y6 w120 h49, 代码编辑器
Gui Add, CheckBox, x143 y24 w102 h23 +Checked vVScode, VScode
Gui Add, GroupBox, x135 y66 w120 h80, 截取软件
Gui Add, CheckBox, x143 y86 w107 h23 +Checked vSnipaste, Snipaste
Gui Add, CheckBox, x143 y115 w107 h23 +Checked vScreenToGif, ScreenToGif
Gui Add, GroupBox, x135 y153 w120 h58, 播放器
Gui Add, CheckBox, x143 y176 w102 h23 +Checked vPot_Player, Pot Player
Gui Add, Text, x10 y222 w54 h23, 安装路径
Gui Add, Edit, x65 y218 w135 h21 vPathSelector
Gui Add, Button, x208 y214 w45 h27, 选择
Gui Add, Button, x8 y244 w248 h23, 自动安装

Gui Show, w260 h272, 自动安装 - 界面
; 设置默认安装路径
GuiControl,, PathSelector, %A_ScriptDir%
Return

GuiEscape:
GuiClose:
    ExitApp


Button自动安装:
    Gui, Submit ,NoHide   ; Save each control's contents to its associated variable.

    if (Listary = 1){
        install_listary()
    }
    
    if (QTTabBar = 1){

    }
    
    if (Ditto = 1){

    }
    
    if (WGesture = 1){

    }
    
    if (Quicker = 1){

    }
    
    if (Desktop = 1){

    }
    
    if (VScode = 1){

    }
    
    if (ScreenToGif = 1){

    }
    
    if (Pot_Player = 1){

    }

    return

Button选择:
    FileSelectFolder, Installation_Path, , 3
    if FileExist(Installation_Path)
        GuiControl,, PathSelector, %Installation_Path%
    return

; listary 安装操作
install_listary(){
    MsgBox You entered:`n%Listary%`
}


