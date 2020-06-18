var UAC = new ActiveXObject("Shell.Application")
var shell = new ActiveXObject("wscript.shell");
var qs = new ActiveXObject("QTTabBarLib.Scripting");
var fso = new ActiveXObject("Scripting.FileSystemObject");

// NOTE 修改 config 路径 复制到 PROGRAMFILES 路径上
var PROGRAMFILES = shell.ExpandEnvironmentStrings("%PROGRAMFILES%")
var QTTabBar = fso.BuildPath(PROGRAMFILES, "QTTabBar")
var DIR = fso.GetAbsolutePathName(".")

var xml = fso.BuildPath(DIR, "*.xml")
fso.CopyFile (xml, QTTabBar)

var config = fso.BuildPath(DIR, "config.xml")
var ForReading = 1, s = "", file = fso.GetFile(config);
var f = fso.OpenTextFile(file, ForReading, false);

while (!f.AtEndOfStream)
    s += f.ReadLine( ) + "\n";

f.Close( );

// NOTE 修正开头的乱码
s = s.substr(2,s.length)
s = "<" + s.replace("{{QTTabBar}}",QTTabBar)

var target_config = fso.BuildPath(QTTabBar, "config.xml")
f = fso.CreateTextFile(target_config, true);
f.WriteLine(s);



// NOTE 记录当前打开的窗口 | 合并到一个窗口重新打开
// NOTE 获取所有开启窗口
var wnd;
var wins;
wins = qs.Windows;

if (wins != null){
    var arr = [];

    for(var i = 0; i < wins.Count; i++){
        wnd = wins.Item(i);
        arr.push(wnd.InvokeCommand("GetCurrentPath"));
    }
    
    // var myMsgBox=new ActiveXObject("wscript.shell")
    // myMsgBox.Popup(arr.toString());

    qs.CloseAllWindows()
    
    wnd = qs.open(arr[0])
    // NOTE 开启 TabBar
    wnd.InvokeCommand("ShowToolbar",0,true)
    // NOTE 导入中文设定
    wnd.InvokeCommand("Import",target_config)

    // NOTE https://github.com/JohnTravolski/restart_explorer_keep_qttabbar_tabs
    for(var ii = 1; ii < arr.length; ii++)
    {
        var returned_tab = wnd.Insert(arr[ii], 0, 1, 1);
    }
}

