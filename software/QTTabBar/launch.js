var UAC = new ActiveXObject("Shell.Application")
var shell = new ActiveXObject("wscript.shell");
var qs = new ActiveXObject("QTTabBarLib.Scripting");
var fso = new ActiveXObject("Scripting.FileSystemObject");

// NOTE 修改 config 路径 复制到 PROGRAMFILES 路径上
// var PROGRAMFILES = shell.ExpandEnvironmentStrings("%PROGRAMFILES%")
// var QTTabBar = fso.BuildPath(PROGRAMFILES, "QTTabBar")
var DIR = fso.GetAbsolutePathName(".")

var APPDATA = shell.ExpandEnvironmentStrings("%APPDATA%")
var xml = fso.BuildPath(DIR, "*.xml")
fso.CopyFile(xml, APPDATA)

var config = fso.BuildPath(DIR, "config.xml")

// NOTE https://language-and-engineering.hatenablog.jp/entry/20090203/p1
var stream = new ActiveXObject("ADODB.Stream");
stream.CharSet = "utf-8";
stream.Type = 2;
stream.Open();
stream.LoadFromFile(config)
var config_xml = stream.ReadText(-1)
stream.Close()

var target_config = fso.BuildPath(APPDATA, "config.xml")

var stream = new ActiveXObject("ADODB.Stream");
stream.Type = 2;
stream.charset = "utf-8";
stream.Open();
stream.WriteText(config_xml.replace("{{QTTabBar}}",APPDATA),1);
stream.SaveToFile( target_config, 2 );
stream.Close();

qs.CloseAllWindows()
var SYSTEMDRIVE = shell.ExpandEnvironmentStrings("%SYSTEMDRIVE%")
wnd = qs.open(SYSTEMDRIVE)
// NOTE 导入中文设定
wnd.InvokeCommand("Import",target_config)

// // NOTE 记录当前打开的窗口 | 合并到一个窗口重新打开
// // NOTE 获取所有开启窗口
// var wnd;
// var wins;
// wins = qs.Windows;

// if (wins != null){
//     var arr = [];

//     // for(var i = 0; i < wins.Count; i++){
//     //     wnd = wins.Item(i);
//     //     arr.push(wnd.InvokeCommand("GetCurrentPath"));
//     // }
    
//     // var myMsgBox=new ActiveXObject("wscript.shell")
//     // myMsgBox.Popup(arr.toString());

//     qs.CloseAllWindows()
    
//     var SYSTEMDRIVE = shell.ExpandEnvironmentStrings("%SYSTEMDRIVE%")
//     wnd = qs.open(SYSTEMDRIVE)
//     // NOTE 开启 TabBar
//     wnd.InvokeCommand("ShowToolbar",0,true)
//     // NOTE 导入中文设定
//     wnd.InvokeCommand("Import",target_config)

//     // // NOTE https://github.com/JohnTravolski/restart_explorer_keep_qttabbar_tabs
//     // for(var ii = 1; ii < arr.length; ii++)
//     // {
//     //     var returned_tab = wnd.Insert(arr[ii], 0, 1, 1);
//     // }
// }

