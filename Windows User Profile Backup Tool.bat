@echo off
setlocal
title Windows User Profile Backup Tool
echo Program Name: Windows User Profile Transfer Tool
echo Version: 2.0.0
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
echo [1] Copy to file.
echo [2] Transfer from file to user.
echo [3] Exit.
set Start=
set /p Start=" What would you like to do? (1-4) "
if /i "%Start%"=="1" goto 1
if /i "%Start%"=="2" goto 2
if /i "%Start%"=="3" goto Close
echo Invalid Syntax!
goto Start

:1
net user
set UserProfileFrom=
set /p UserProfileFrom="Which profile to you want to transfer data from? "
if not exist "%SystemDrive%\Users\%UserProfileFrom%" goto UserProfileFromNotExist1
if not "%UserProfileFrom%"=="%USERNAME%" goto NotCurrentUser
goto FileTo

:UserProfileFromNotExist1
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 1

:FileTo
echo.
set FileTo=
set /p FileTo="Where do you want to save the user profile %UserProfileFrom% to? "
if not exist "%FileTo%" goto FileToNotExist
if exist "%FileTo%\%UserProfileFrom% File" goto FileToFileExist
echo.
echo Copying %UserProfileFrom% to "%FileTo%".
md "%FileTo%\%UserProfileFrom% File"
xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*"  "%FileTo%\%UserProfileFrom% File" /y /s /e /k /r /c /q /h > nul 2>&1
if not "%errorlevel%"=="0" goto Error1
echo.
echo %UserProfileFrom% copied to "%FileTo%\%UserProfileFrom% File". Press any key to continue.
pause > nul 2>&1
goto Start

:FileToNotExist
echo "%FileTo%" does not exist. Please try again.
goto 1

:FileToFileExist
echo Please rename or move  to another location "%FileTo%\%UserProfileFrom%" in order for this batch file to continue. Press any key to continue when you have renamed or moved  to another location "%FileTo%\%UserProfileFrom%".
pause > nul 2>&1
goto 1

:Error1
echo.
echo There has been an error! You can try again.
goto 1

:2
echo.
set File=
set /p File="What is the full path to your copied user profile file? "
if not exist "%File%" goto FileNotExist
goto 2UserProfileTo

:FileNotExist
echo.
echo "%File%" does not exist! You can try again.
goto 2

:2UserProfileTo
net user
set UserProfileTo=
set /p UserProfileTo="Which user profile to you want to transfer data to? "
if not exist "%SystemDrive%\Users\%UserProfileTo%" goto UserProfileFromNotExist2
if not "%UserProfileFrom%"=="%USERNAME%" goto NotCurrentUser
goto Sure2

:UserProfileToNotExist2
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 2

:Sure2
echo.
set Sure3=
set /p Sure3="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure3%"=="Yes" goto Copy2
if /i "%Sure3%"=="No" goto Start
echo Invalid Syntax
goto Sure2

:Copy2
echo.
echo Copying "%File%" to %UserProfileTo%.
xcopy "%File%\*.*" "%SystemDrive%\Users\%UserProfileTo%" xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*"  "%FileTo%\%UserProfileFrom% File" /y /s /e /k /r /c /q /h > nul 2>&1 > nul 2>&1
if not "%errorlevel%"=="0" goto Error2
echo.
echo User Profile transfer complete! Press any key to continue.
pause > nul 2>&1
goto Start

:Error2
echo.
echo There has been an error! You can try again.
goto 2

:NotCurrentUser
echo.
echo %UserProfileFrom% is not the current user. Please switch switch user to %UserProfileFrom%. Press any key to close this batch file.
goto Close

:Close
endlocal
exit
