@echo off
setlocal
title Windows User Profile Transfer Tool
echo Program Name: Windows User Profile Transfer Tool
echo Version: 1.0.5
echo Developer: @YonatanReuvenIsraeli
echo Website: https://www.yonatanreuvenisraeli.dev
echo License: GNU General Public License v3.0
echo.
echo Please run this batch file as an administrator.
goto Start

:Start
echo.
echo [1] Transfer from a user to another user on the same computer.
echo [2] Copy to file.
echo [3] Transfer from file to user.
echo [4] Exit
set Start=
set /p Start=" What would you like to do? (1-4) "
if /i "%Start%"=="1" goto 1
if /i "%Start%"=="2" goto 2
if /i "%Start%"=="3" goto 3
if /i "%Start%"=="4" goto Close
echo Invalid Syntax!
goto Start

:1
net user
set UserProfileFrom=
set /p UserProfileFrom="Which profile to you want to transfer data from? "
if not exist "%SystemDrive%\Users\%UserProfileFrom%" goto UserProfileFromNotExist1
goto 1UserProfileTo

:UserProfileFromNotExist1
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 1

:1UserProfileTo
echo.
set UserProfileTo=
set /p UserProfileTo="Which profile to you want to transfer data to? "
if not exist "%SystemDrive%\Users\%UserProfileTo%" goto UserProfileFromNotExist1
goto Sure1

:UserProfileToNotExist1
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 1

:Sure1
echo.
set Sure=
set /p Sure1="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure1%"=="Yes" goto Copy1
if /i "%Sure1%"=="No" goto Start
echo Invalid Syntax
goto Sure1

:Copy1
echo.
echo Copying %UserProfileFrom% to %UserProfileTo%.
xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*" "%SystemDrive%\Users\%UserProfileTo%" /y /e /r /h /c /q > nul 2>&1
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
net user
set UserProfileFrom=
set /p UserProfileFrom="Which profile to you want to transfer data from? "
if not exist "%SystemDrive%\Users\%UserProfileFrom%" goto UserProfileFromNotExist2
goto FileTo

:UserProfileFromNotExist2
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 2

:FileTo
echo.
set FileTo=
set /p FileTo="Where do you want to save the user profile %UserProfileFrom% to? "
if not exist "%FileTo%" goto FileToNotExist
if exist "%FileTo%\%UserProfileFrom% File" goto FileToFileExist
echo.
echo Copying %UserProfileFrom% to "%FileTo%".
md "%FileTo%\%UserProfileFrom% File"
xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*"  "%FileTo%\%UserProfileFrom% File" /y /e /r /h /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error2
echo.
echo %UserProfileFrom% copied to "%FileTo%\%UserProfileFrom% File". Press any key to continue.
pause > nul 2>&1
goto Start

:FileToNotExist
echo "%FileTo%" does not exist. Please try again.
goto 2

:FileToFileExist
echo Please rename or move  to another location "%FileTo%\%UserProfileFrom%" in order for this batch file to continue. Press any key to continue when you have renamed or moved  to another location "%FileTo%\%UserProfileFrom%".
pause > nul 2>&1
goto 2

:Error2
echo.
echo There has been an error! You can try again.
goto 2

:3
echo.
set File=
set /p File="What is the full path to your copied user profile file? "
if not exist "%File%" goto FileNotExist
goto 2UserProfileTo

:FileNotExist
echo.
echo "%File%" does not exist! You can try again.
goto 3

:2UserProfileTo
net user
set UserProfileTo=
set /p UserProfileTo="Which profile to you want to transfer data to? "
if not exist "%SystemDrive%\Users\%UserProfileTo%" goto UserProfileFromNotExist2
goto Sure3

:UserProfileToNotExist2
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 3

:Sure3
echo.
set Sure3=
set /p Sure3="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure3%"=="Yes" goto Copy3
if /i "%Sure3%"=="No" goto Start
echo Invalid Syntax
goto Sure3

:Copy3
echo.
echo Copying "%File%" to %UserProfileTo%.
xcopy "%File%\*.*" "%SystemDrive%\Users\%UserProfileTo%" /y /e /r /h /c /q > nul 2>&1
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
