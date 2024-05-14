@echo off
setlocal
title Windows User Profile Transfer/Backup Tool
echo Program Name: Windows User Profile Transfer/Backup Tool
echo Version: 5.0.1
echo Developer: @YonatanReuvenIsraeli
echo Website: https://www.yonatanreuvenisraeli.dev
echo License: GNU General Public License v3.0
net session > nul 2>&1
if not "%errorlevel%"=="0" goto NotAdministrator
net user > nul 2>&1
if not "%errorlevel%"=="0" goto WindowsRecoveryEnvironment
goto Start

:NotAdministrator
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto Close

:WindowsRecoverynEvironment
echo.
echo Please do not run this batch file from Windows Recovery Environment. Press any key to close this batch file.
pause > nul 2>&1
exit

:Start
echo.
echo [1] Transfer from a user profile to another user profile.
echo [2] Copy from a user profile to file.
echo [3] Copy from a file to user profile.
echo [4] Exit.
set Start=
set /p Start=" What would you like to do? (1-4) "
if /i "%Start%"=="1" goto 1
if /i "%Start%"=="2" goto 2
if /i "%Start%"=="3" goto 3
if /i "%Start%"=="4" goto Close
echo Invalid Syntax!
goto Start

:1
set UserProfileFrom=
set /p UserProfileFrom="What is the user profile path you want to transfer data from? "
if not exist "%UserProfileFrom%" goto UserProfileFromNotExist1
goto UserProfileTo1

:UserProfileFromNotExist1
echo.
echo "%UserProfileFrom%" does not exist! Please try again.
goto 1

:UserProfileTo1
echo.
set UserProfileTo=
set /p UserProfileTo="What is the user profile path you want to transfer data to? "
if not exist "%UserProfileTo%" goto UsePathToNotExist1
if "%UserProfileFrom%"=="%UserProfileTo%" goto SameUsers
goto Sure1

:UserProfileToNotExist1
echo.
echo "%UserProfileTo%" does not exist! Please try again.
goto 1

:SameUsers
echo.
echo "%UserProfileFrom%" is the same as "%UserProfileTo%"! Please try again.
goto 1

:Sure1
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! (Yes/No) "
if /i "%Sure%"=="Yes" goto HiddenSystem1
if /i "%Sure%"=="No" goto Start
echo Invalid Syntax
goto Sure1

:HiddenSytem1
echo.
set HiddenSystem=
set /p HiddenSystem="This will not copy hidden and system files! Are you sure you want to continue? (Yes/No) "
if /i "%HiddenSystem%"=="Yes" goto Copy1
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid Syntax!
goto HiddenSystem1

:Copy1
echo.
echo Copying "%UserProfileFrom%" to "%UserProfileTo%".
xcopy "%UserProfileFrom%\*.*" "%UserProfileTo%" /y /s /e /k /r /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error1
echo.
echo User Profile transfer complete! Press any key to continue.
pause > nul 2>&1
goto Start

:Error1
echo.
echo There has been an error! You can try again.
goto 1

:2
echo.
set UserProfileFrom=
set /p UserProfileFrom="What is the user profile path to you want to transfer data from? "
if not exist "%UserProfileFrom%" goto UseProfileFromNotExist2
goto FileTo

:UserProfileFromNotExist2
echo.
echo "%UserProfileFrom%" does not exist! Please try again.
goto 2

:FileTo
echo.
set FileTo=
set /p FileTo="Where do you want to save the user profile "%UserProfileFrom%" to? "
if not exist "%FileTo%" goto FileToNotExist
if exist "%FileTo%\%UserProfileFrom% File" goto FileToFileExist
goto HiddenSystem2

:FileToNotExist
echo "%FileTo%" does not exist. Please try again.
goto 2

:FileToFileExist
echo Please rename or move to another location "%FileTo%\%UserProfileFrom%" in order for this batch file to continue. Press any key to continue when you have renamed or moved  to another location "%FileTo%\%UserProfileFrom%".
pause > nul 2>&1
goto 2

:HiddenSystem2
echo.
set HiddenSystem=
set /p HiddenSystem="This will not copy hidden and system files! Are you sure you want to continue? " (Yes/No)
if /i "%HiddenSystem%"=="Yes" goto Copy2
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid Syntax!
goto HiddenSystem2

:Copy2
echo.
echo Copying %UserProfileFrom% to "%FileTo%".
md "%FileTo%\%UserProfileFrom% File"
xcopy "%UserProfileFrom%\*.*" "%UserProfileFrom% File" /y /s /e /k /r /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error2
echo.
echo %UserProfileFrom% copied to "%FileTo%\%UserProfileFrom% File". Press any key to continue.
pause > nul 2>&1
goto Start

:Error2
echo.
echo There has been an error! You can try again.
goto 2

:3
echo.
set File=
set /p File="What is the full path to your copied user profile file? "
if not exist "%File%" goto FileFromNotExist
goto UserProfileTo2

:FileFromNotExist
echo.
echo "%File%" does not exist! You can try again.
goto 3

:UserProfileTo2
net user
set UserProfileTo=
set /p UserProfileTo="What is the user profile path that you want to transfer data to? "
if not exist "%UserProfileTo%" goto UserProfileToNotExist2
goto Sure3

:UserProfileToNotExist2
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 3

:Sure3
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure%"=="Yes" goto Copy3
if /i "%Sure%"=="No" goto Start
echo Invalid Syntax
goto Sure3

:Copy3
echo.
echo Copying "%File%" to %UserProfileTo%.
xcopy "%File%\*.*" "%UserProfileTo%\*.*" /y /s /e /k /r /c /q > nul 2>&1 > nul 2>&1
if not "%errorlevel%"=="0" goto Error3
echo.
echo User Profile transfer complete! Press any key to continue.
pause > nul 2>&1
goto Start

:Error3
echo.
echo There has been an error! You can try again.
goto 3

:Close
endlocal
exit
