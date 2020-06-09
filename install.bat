@echo off

set ListaryDIR= %~dp0effecitve\listary

%ListaryDIR%\Listary.exe /sp- /verysilent /dir="C:\Program Files\Listary"

copy %ListaryDIR%\Preferences.json %USERPROFILE%\AppData\Roaming\Listary\UserData\

REM %~dp0"programing\VSCodeUserSetup-x64-1.40.2.exe/?"

pause