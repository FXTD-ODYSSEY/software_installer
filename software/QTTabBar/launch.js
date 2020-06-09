var qs = new ActiveXObject( "QTTabBarLib.Scripting" );

var wnd;
wnd = qs.ActiveWindow;
if(wnd == null){
    // NOTE 打开窗口
    wnd = qs.Open("C:");
    // NOTE 开启 TabBar
    wnd.InvokeCommand("ShowToolbar",0,true)
    // NOTE 导入中文设定
    wnd.InvokeCommand("Import","C:/Program Files/QTTabBar/config.xml")
    wnd.InvokeCommand("CloseWindow")
}else{
    // NOTE 记录当前打开的窗口 | 合并到一个窗口重新打开
    // NOTE 获取所有开启窗口
    var wins;
    wins = qs.Windows;

    if (wins != null){
        var arr = [];
    
        for(var i = 0; i < wins.Count; i++){
            var wnd = wins.Item(i);
            arr.push(wnd.InvokeCommand("GetCurrentPath"));
        }
        
        // var myMsgBox=new ActiveXObject("wscript.shell")
        // myMsgBox.Popup(arr.toString());

        qs.CloseAllWindows()
        
        wnd = qs.open(arr[0])
        // NOTE 开启 TabBar
        wnd.InvokeCommand("ShowToolbar",0,true)
        // NOTE 导入中文设定
        wnd.InvokeCommand("Import","C:/Program Files/QTTabBar/config.xml")

        // NOTE https://github.com/JohnTravolski/restart_explorer_keep_qttabbar_tabs
        for(var ii = 1; ii < arr.length; ii++)
        {
            var returned_tab = wnd.Insert(arr[ii], 0, 1, 1);
        }
    }
}




