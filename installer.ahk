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
Gui Add, CheckBox, y+5 w100 h25 vTencentDesktop, 腾讯桌面管理
Gui Add, GroupBox, x135 y6 w120 h49, 代码编辑器
Gui Add, CheckBox, x143 y24 w102 h23 +Checked vVScode, VScode
Gui Add, GroupBox, x135 y66 w120 h80, 截取软件
Gui Add, CheckBox, x143 y86 w107 h23 +Checked vSnipaste, Snipaste
Gui Add, CheckBox, x143 y115 w107 h23 +Checked vScreenToGif, ScreenToGif
Gui Add, GroupBox, x135 y153 w120 h58, 播放器
Gui Add, CheckBox, x143 y176 w102 h23 +Checked vPotPlayer, Pot Player
; Gui Add, Text, x10 y222 w54 h23, 安装路径
; Gui Add, Edit, x65 y218 w135 h21 vPathSelector
; Gui Add, Button, x208 y214 w45 h27, 选择
Gui Add, Button, x8 y222 w248 h23, 自动安装

Gui +AlwaysOnTop
Gui Show , w260 h252 , 自动安装 - 界面
; 设置默认安装路径
; GuiControl,, PathSelector, %A_ScriptDir%
Return

GuiEscape:
GuiClose:
    ExitApp


Button自动安装:
    Gui, Submit ,NoHide   ; Save each control's contents to its associated variable.
    SetTitleMatchMode, 1
    
    if (QTTabBar = 1){
        install_QTTabBar()
    }
    
    if (PotPlayer = 1){
        install_PotPlayer()
    }

    if (WGesture = 1){
        install_WGesture()
    }

    if (VScode = 1){
        install_VScode()
    }
    
    if (ScreenToGif = 1){
        install_ScreenToGif()
    }
    
    
    if (Listary = 1){
        install_Listary()
    }

    if (Snipaste = 1){
        install_Snipaste()
    }
    
    if (TencentDesktop = 1){
        install_TencentDesktop()
    }

    if (Ditto = 1){
        install_Ditto()
    }
    
    if (Quicker = 1){
        install_Quicker()
    }

    MsgBox, 262144, 恭喜你, 安装完成, 3
    ExitApp

Button选择:
    FileSelectFolder, Installation_Path, , 3
    if FileExist(Installation_Path)
        GuiControl,, PathSelector, %Installation_Path%
    return

; listary 安装操作
install_Listary(){
    install_path := A_ScriptDir "\software\Listary.exe"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "Listary.exe not exists"
        return
    }

    install_cmd := install_path " /VERYSILENT" 
    Run, %install_cmd%
    ToolTip, 安装 listary
}

; WGesture 安装操作
install_WGesture(){
    install_path := A_ScriptDir "\software\Install WGestures.msi"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "Install WGestures.msi not exists"
        return
    }

    install_cmd := install_path " /passive" 
    Run, %install_cmd%
    
    Loop {
        result := WinExist("安全警告")
        ToolTip, 等待 WGesture 安装

        sleep 500
        if (result){
            SendInput,  {Y}
            break
        }
    }

}

; Quicker 安装操作
install_Quicker(){
    install_path := A_ScriptDir "\software\Quicker.x64.1.8.0.0.msi"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "Quicker.x64.1.8.0.0.msi not exists"
        return
    }

    install_cmd := install_path " /passive" 
    Run, %install_cmd%
    ToolTip, 安装 Quicker
}

; Ditto 安装操作
install_Ditto(){
    install_path := A_ScriptDir "\software\DittoSetup_64bit_3_22_88_0.exe"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "DittoSetup_64bit_3_22_88_0.exe not exists"
        return
    }

    install_cmd := install_path " /VERYSILENT" 
    Run, %install_cmd%
    ToolTip, 安装 Ditto
}

; VScode 安装操作
install_VScode(){
    install_path := A_ScriptDir "\software\VSCodeUserSetup-x64-1.46.0.exe"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "VSCodeUserSetup-x64-1.46.0.exe not exists"
        return
    }

    install_cmd := install_path " /VERYSILENT" 
    Run, %install_cmd%
    ToolTip, 安装 VScode
}

; ScreenToGif 安装操作
install_ScreenToGif(){
    install_path := A_ScriptDir "\software\ScreenToGif.2.25.Setup.msi"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "ScreenToGif.2.25.Setup.msi not exists"
        return
    }

    install_cmd := install_path " /passive" 
    Run, %install_cmd%
    ToolTip, 安装 ScreenToGif
}

; 腾讯桌面管理 安装操作
install_TencentDesktop(){
    install_path := A_ScriptDir "\software\DeskGo_2_9_1051_127_lite.exe"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "DeskGo_2_9_1051_127_lite.exe not exists"
        return
    }

    install_cmd := install_path
    Run, %install_cmd%
    ToolTip, 安装 腾讯桌面管理
}

; PotPlayer 安装操作
install_PotPlayer(){
    install_path := A_ScriptDir "\software\PotPlayerSetup64-200512-ads.exe"

    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "PotPlayerSetup64-200512-ads.exe not exists"
        return
    }
    ToolTip, 解压 PotPlayer 安装包

    install_cmd := install_path
    Run, %install_cmd%
    WinWait, Installer Language, , 3
    SendInput,{Enter}
    ; ControlClick, OK , Installer Language
    Sleep, 2000
    WinWait, PotPlayer-64 bit 安装
    SendInput,{Enter}
    SendInput,{Enter}
    SendInput,{Enter}
    Loop, 10
    {
        Sleep, 200
        ControlClick, 安装 , PotPlayer-64 bit 安装
    }

    ; ; 等待 关闭 按钮激活
    ; Sleep, 2000
    while (WinExist(PotPlayer-64 bit 安装)) {
        ToolTip, 等待 PotPlayer 安装
        Sleep, 500
        ; ControlGet, button_enable, Visible ,,  ClassNN Button2
        ControlClick, 关闭 , PotPlayer-64 bit 安装
    }

}

; 解压 zip
Unz(sZip, sUnz)
{
    fso := ComObjCreate("Scripting.FileSystemObject")
    If Not fso.FolderExists(sUnz)  ;http://www.autohotkey.com/forum/viewtopic.php?p=402574
       fso.CreateFolder(sUnz)
    psh  := ComObjCreate("Shell.Application")
    zippedItems := psh.Namespace( sZip ).items().count
    psh.Namespace( sUnz ).CopyHere( psh.Namespace( sZip ).items, 4|16 )
    Loop {
        sleep 50
        unzippedItems := psh.Namespace( sUnz ).items().count
        ToolTip Unzipping in progress..
        IfEqual,zippedItems,%unzippedItems%
            break
    }
    ToolTip
}

install_Snipaste(){
    install_path := A_ScriptDir "\software\Snipaste-2.3.5-Beta-x64.zip"
    ; 判断安装包是否存在
    if !FileExist(install_path){
        MsgBox, "Snipaste-2.3.5-Beta-x64.zip not exists"
        return
    }
    EnvGet, APPDATA, APPDATA
    install_directory := APPDATA "\Snipaste"
    if !FileExist(install_path)
        FileCreateDir, %install_directory%
    Sleep, 100
    Unz(install_path,install_directory)
    Snipaste_exe := install_directory "\Snipaste.exe"
    Run, %Snipaste_exe%
    
    ; ; 创建自启动 lnk
    ; startup_directory := APPDATA "\Microsoft\Windows\Start Menu\Programs\Startup"
    ; FileCreateShortcut, %Snipaste_exe%, %startup_directory%\Snipaste.lnk
}


install_QTTabBar(){
    QTTabBar_exe := A_ScriptDir "\software\QTTabBar\QTTabBar.exe"
    update_exe := A_ScriptDir "\software\QTTabBar\UpdateQTTabBar1040.exe"

    ToolTip, 等待 QTTabBar 安装


    ; 启动程序进行安装
    Run, %QTTabBar_exe% , , , OutputVarPID
    WinWait ahk_pid %OutputVarPID%
    Send {Enter}
    Send {Enter}

    ; 等待 Exit 按钮激活
    button_enable := 0
    while (button_enable = 0) {
        Sleep, 100
        ToolTip, 等待 QTTabBar 安装
        ControlGet, button_enable, Enabled ,, Exit
    }

    ; 关闭窗口
    WinClose ahk_pid %OutputVarPID%
    ; SetControlDelay -1
    ; ControlClick, Exit

    ; 运行 update 程序
    Run, %update_exe% , , , OutputVarPID
    WinWait ahk_pid %OutputVarPID%
    Send {Enter}

    Sleep, 500
    ; 等待 OK 按钮激活
    button_enable := 0
    while (button_enable = 0) {
        Sleep, 200
        ToolTip, 等待 QTTabBar 安装
        ControlGet, button_enable, Enabled ,, WindowsForms10.BUTTON.app.0.141b42a_r6_ad11
    }

    ; 关闭窗口
    WinClose ahk_pid %OutputVarPID%

    ToolTip, 启动 QTTabBar
    
    ; EnvGet, USERPROFILE, USERPROFILE
    ; SetTitleMatchMode,2
    RunWait, explorer , , , OutputVarPID
    ; WinWaitActive ahk_pid %OutputVarPID% 

    Sleep, 2000
    SendInput  {Alt}
    Sleep, 2000
    SendInput  {V}
    Sleep, 1000
    SendInput,  {Y}
    Sleep, 1000
    SendInput  {down}
    SendInput  {down}
    SendInput  {down}
    SendInput  {Enter}

    Sleep, 1000
    ToolTip, 启动 QTTabBar
    directory := A_ScriptDir "\software\QTTabBar" 
    Run, cscript launch.js , %directory%

}


