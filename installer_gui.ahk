; 河许人 AutoAHK 3.1.1
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Add, CheckBox, x16 y23 w108 h23 +Checked, Listary
Gui Add, CheckBox, x15 y53 w109 h23 +Checked, QTTabBar
Gui Add, CheckBox, x142 y86 w107 h23 +Checked, Snipaste
Gui Add, CheckBox, x16 y84 w103 h23 +Checked, Ditto
Gui Add, CheckBox, x15 y114 w106 h23, WGesture
Gui Add, CheckBox, x15 y146 w106 h23, Quicker
Gui Add, CheckBox, x16 y177 w103 h23, 腾讯桌面管理
Gui Add, GroupBox, x135 y6 w120 h49, 代码编辑器
Gui Add, CheckBox, x143 y24 w102 h23 +Checked, VScode
Gui Add, GroupBox, x10 y6 w120 h205, 效率软件
Gui Add, GroupBox, x135 y66 w120 h80, 截取软件
Gui Add, CheckBox, x143 y115 w107 h23 +Checked, ScreenToGif
Gui Add, GroupBox, x135 y153 w120 h58, 播放器
Gui Add, CheckBox, x144 y176 w102 h23, Pot Player
Gui Add, Edit, x65 y218 w190 h21
Gui Add, Text, x10 y218 w54 h23, 安装路径
Gui Add, Button, x8 y244 w248 h23, 自动安装

Gui Show, w260 h272, 窗口

OnMessage(0x201, "OnWM_LBUTTONDOWN")
Return

GuiEscape:
GuiClose:
    ExitApp

OnWM_LBUTTONDOWN(wParam, lParam, msg, hWnd) {

}
