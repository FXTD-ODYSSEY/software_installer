var shell =new ActiveXObject("wscript.shell");
var fso =new ActiveXObject("Scripting.FileSystemObject");

var PROGRAMFILES = shell.ExpandEnvironmentStrings("%PROGRAMFILES%")
shell.Popup(PROGRAMFILES);

// var path;
// path = fso.BuildPath(fso.GetAbsolutePathName("."), "software")
// path = fso.BuildPath(path, "QTTabBar")
// path = fso.BuildPath(path, "config.xml")

// if (fso.FileExists(path)){
//     shell.Popup(path);
// }else{
//     shell.Popup("not exists");
// }



// shell.Popup(shell.CurrentDirectory);