# -*- coding: utf-8 -*-
"""

"""

from __future__ import division
from __future__ import print_function
from __future__ import absolute_import

__author__ = 'timmyliang'
__email__ = '820472580@qq.com'
__date__ = '2020-06-11 09:06:29'


import time

from pywinauto.application import Application
from pywinauto import Desktop, keyboard

def main():

    new_win = False
    for win in Desktop(backend="uia").windows():
        if win.class_name() == "CabinetWClass":
            break
    else:
        new_win = True
        app = Application(backend="uia").start('explorer.exe')
        win = Desktop(backend="uia").window(class_name="CabinetWClass")
            
    win.set_focus()

    # NOTE 开启 QTTabBar 
    keyboard.send_keys("{VK_MENU}")
    keyboard.send_keys("{V}")
    time.sleep(0.5)
    keyboard.send_keys("{Y}")
    keyboard.send_keys("{DOWN}")
    keyboard.send_keys("{DOWN}")
    keyboard.send_keys("{DOWN}")
    keyboard.send_keys("{ENTER}")

    if new_win:
        win.close()


if __name__ == "__main__":
    main()
