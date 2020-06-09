# coding:utf-8
from __future__ import unicode_literals, division, print_function

__author__ = 'timmyliang'
__email__ = '820472580@qq.com'
__date__ = '2020-05-12 11:31:30'

"""

"""

import os
import sys
import json
import codecs
import ctypes
import platform
import tempfile

# NOTE Python 3 & 2 兼容
try:
    import tkinter as tk
    from tkinter import ttk
    from tkinter import filedialog, messagebox
except:
    import ttk
    import Tkinter as tk
    import tkFileDialog as filedialog
    import tkMessageBox as messagebox


def take_parm(kwargs, key, default=None):
    res = kwargs.get(key, default)
    if key in kwargs:
        del kwargs[key]
    return res


class SelectPathWidget(tk.Frame):
    def __init__(self, *args, **kwargs):
        label_text = take_parm(kwargs, "label_text", "")
        path_text = take_parm(kwargs, "path_text", "")
        button_text = take_parm(kwargs, "button_text", "")
        clickEvent = take_parm(kwargs, "clickEvent")

        tk.Frame.__init__(self, *args, **kwargs)

        self.grid_columnconfigure(1, weight=1)

        if label_text:
            self.label = tk.Label(self, text=label_text)
            self.label.grid(row=0, column=0, sticky="nsew")

        self.edit = tk.Entry(self, text='', width=25)
        self.edit.insert(0, path_text)
        self.edit.grid(row=0, column=1, sticky="nsew", padx=10)

        callback = clickEvent if callable(clickEvent) else self.selectDirectory

        self.btn = tk.Button(self, text=button_text,
                             command=callback, width=15)
        self.btn.grid(row=0, column=2, sticky="nsew")

    def selectDirectory(self):
        path = filedialog.askdirectory()
        if path:
            self.edit.delete(0, tk.END)
            self.edit.insert(0, path)

    def get(self):
        return self.edit.get()


class ProgressDialog(tk.Toplevel):

    canceled = False

    def __init__(self, *args, **kwargs):
        self.parent = take_parm(kwargs, 'parent')
        tk.Toplevel.__init__(self, self.parent, *args, **kwargs)

        # NOTE 阻断其他窗口
        self.grab_set()
        self.progress = ttk.Progressbar(self, orient=tk.HORIZONTAL,
                                        length=100, mode='determinate')
        self.progress.pack(side="top", fill="x", expand=1, padx=5, pady=5)
        self.button = tk.Button(self, text="Cancel", command=lambda: [
                                None for self.canceled in [True]])
        self.button.pack()

    @classmethod
    def loop(cls, seq, **kwargs):
        self = cls(**kwargs)
        maximum = len(seq)
        for i, item in enumerate(seq):
            if self.canceled:
                break

            try:
                yield item  # with body executes here
            except:
                import traceback
                traceback.print_exc()
                self.destroy()

            self.progress['value'] = i/maximum * 100
            self.update()

        self.destroy()


class MainApplication(tk.Frame):
    def __init__(self, parent, *args, **kwargs):
        tk.Frame.__init__(self, parent, *args, **kwargs)

        self.DIR = os.path.dirname(__file__)

        self.parent = parent
        parent.title("软件自动安装工具")
        parent.protocol("WM_DELETE_WINDOW", self.onClosing)

        # NOTE 获取系统临时路径
        temp_dir = tempfile.gettempdir()
        self.json_file = os.path.join(temp_dir, "subst_TK_GUI.json")
        # NOTE 获取 startup 目录
        user_path = os.path.expanduser('~')
        self.startup_path = os.path.join(
            user_path, r"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup")

        # NOTE 生成菜单
        menubar = tk.Menu(self)
        filemenu = tk.Menu(menubar, tearoff=0)
        filemenu.add_command(label="使用说明", command=self.helpWin)
        filemenu.add_separator()
        filemenu.add_command(label="退出", command=self.onClosing)
        menubar.add_cascade(label="帮助", menu=filemenu)
        parent.config(menu=menubar)

        UNC_Frame = tk.Frame()
        gen_frame = tk.LabelFrame(UNC_Frame, text="软件自动安装")
        gen_frame.pack(side="top", fill="both", expand=1)

        # NOTE 复选框
        self.QTTabBar = tk.IntVar()
        self.QTTabBar.set(1)
        tk.Checkbutton(gen_frame, text='QTTabBar', variable=self.QTTabBar).pack(
            side="top", fill="both", expand=1, padx=5, pady=5)

        self.path_widget = SelectPathWidget(
            gen_frame, label_text="安装目录", button_text="选择路径", path_text=os.path.dirname(__file__))
        self.path_widget.pack(side="top", fill="both",
                              expand=1, padx=5, pady=5)

        gen_btn = tk.Button(gen_frame, text="自动安装",
                            command=self.install_software)
        gen_btn.pack(side="top", fill="x", expand=1, padx=5, pady=5)

        UNC_Frame.pack(side="top", fill="x", expand=1, padx=5, pady=5)

        self.loadJson()

    def helpWin(self):
        # NOTE 删除重复的窗口
        if hasattr(self, "help_win") and self.help_win.winfo_exists():
            self.help_win.destroy()
        self.help_win = tk.Toplevel(self.parent)
        self.help_win.title("使用说明")
        tk.Label(self.help_win, text="选择可映射盘符进行映射").pack(
            side="top", fill="x", expand=1, padx=5, pady=5)
        tk.Label(self.help_win, text="如果盘符已经存在需要先删除已有盘符再映射").pack(
            side="top", fill="x", expand=1, padx=5, pady=5)
        tk.Label(self.help_win, text="删除盘符为系统分区会提示执行出错，不用担心错误删除系统分区").pack(
            side="top", fill="x", expand=1, padx=5, pady=5)

    def onClosing(self):
        self.saveJson()
        self.parent.destroy()

    def loadJson(self, directory=None):
        pass
        # directory = self.json_file if directory is None else directory
        # if not os.path.exists(directory):
        #     return

        # data = {}
        # try:
        #     with open(directory, "r") as f:
        #         data = json.load(f,encoding="utf-8")
        # except:
        #     import traceback
        #     traceback.print_exc()
        #     return

        # gen_drive = data.get("gen_comboBox")
        # del_drive = data.get("del_comboBox")
        # path = data.get("path")

        # for i,val in enumerate(self.gen_comboBox.combo['values']):
        #     if val == gen_drive:
        #         self.gen_comboBox.current(i)
        #         break

        # for i,val in enumerate(self.del_comboBox.combo['values']):
        #     if val == del_drive:
        #         self.del_comboBox.current(i)
        #         break

        # self.path_widget.edit.delete(0,tk.END)
        # self.path_widget.edit.insert(0,path)

    def saveJson(self, directory=None):
        pass
        # data = {
        #     "gen_comboBox" : self.gen_comboBox.get(),
        #     "del_comboBox" : self.del_comboBox.get(),
        #     "path" : self.path_widget.get(),
        # }
        # directory = self.json_file if directory is None else directory
        # with open(directory, "w") as f:
        #     json.dump(data,f,indent=4)

    def get_cmd(self):
        # NOTE 获取cmd.exe的本地路径 https://stackoverflow.com/questions/49545009
        is_wow64 = (platform.architecture()[
                    0] == '32bit' and 'ProgramFiles(x86)' in os.environ)
        system32 = os.path.join(
            os.environ['SystemRoot'], 'SysNative' if is_wow64 else 'System32')
        cmd_exe = os.path.join(system32, "cmd.exe")
        return cmd_exe

    def install_QTTabBar(self):
        command = ""
        QTTabBar_dir = os.path.join(self.DIR,"software","QTTabBar").replace("/","\\")
        # program_dir = os.path.join(QTTabBar_dir,"QTTabBar.exe")
        # command += '"%s" /QI & ' % program_dir
        # program_dir = os.path.join(QTTabBar_dir,"UpdateQTTabBar1040.exe")
        # command += '"%s" /QI & ' % program_dir

        # NOTE 复制文件
        QTTabBar_install_dir = os.path.join(os.environ["ProgramFiles"],"QTTabBar").replace("/","\\")
        
        command += r'copy "%s\*.xml" "%s\" /y & ' % (QTTabBar_dir,QTTabBar_install_dir)

        # script = os.path.join(QTTabBar_dir,"launch.js")
        # command += 'cscript "%s" & ' % script
        
        return command

    def install_software(self):

        command = ""
        command += self.install_QTTabBar() if self.QTTabBar.get() else ""

        cmd_exe = self.get_cmd()

        # command = 'mshta vbscript:msgbox("我是提示内容",64,"我是提示标题")(window.close) & mshta vbscript:msgbox("我是提示内容123131",64,"我是提示标题")(window.close) & '
        command = '/c "%s"' % command
        print("command",command)
        result = ctypes.windll.shell32.ShellExecuteW(
            None, u"runas", unicode(cmd_exe), unicode(command), None, 1)

        # NOTE 返回 5 说明没有提供权限
        if result == 5:
            messagebox.showerror(title=u'提示', message=u'没有获取到权限，命令执行不成功')
        else:
            messagebox.showinfo(title=u'提示', message=u'执行成功')


if __name__ == "__main__":
    root = tk.Tk()
    MainApplication(root).pack(side="top", expand=True)
    root.mainloop()
