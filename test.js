var UAC = new ActiveXObject("Shell.Application")
var shell = new ActiveXObject("wscript.shell");
var qs = new ActiveXObject("QTTabBarLib.Scripting");
var fso = new ActiveXObject("Scripting.FileSystemObject");

// NOTE 修改 config 路径 复制到 PROGRAMFILES 路径上
var PROGRAMFILES;
PROGRAMFILES = shell.ExpandEnvironmentStrings("%PROGRAMFILES%");
var QTTabBar = fso.BuildPath(PROGRAMFILES, "QTTabBar")
var DIR = fso.GetAbsolutePathName(".")

var USERPROFILE = shell.ExpandEnvironmentStrings("%USERPROFILE%")
shell.popup(USERPROFILE)


// var config = fso.BuildPath(DIR, "config.xml")

// // NOTE https://language-and-engineering.hatenablog.jp/entry/20090203/p1
// var stream = new ActiveXObject("ADODB.Stream");
// stream.CharSet = "utf-8";
// stream.Type = 2;
// stream.Open();
// stream.LoadFromFile(config)
// var config_xml = stream.ReadText(-1)
// stream.Close()

// var sw = new ActiveXObject("ADODB.Stream");
// sw.Type = 2;
// sw.charset = "utf-8";
// sw.Open();
// sw.WriteText(config_xml.replace("{{QTTabBar}}",QTTabBar),1);
// var output = fso.BuildPath(DIR, "config2.xml")
// sw.SaveToFile( output, 2 );
// sw.Close();

// var ForReading = 1, s = "", file = fso.GetFile(config);
// var f = fso.OpenTextFile(file, ForReading, true,-1);

// while (!f.AtEndOfStream)
//     s += f.ReadLine( ) + "\n";

// f.Close( );

// shell.popup(s)

