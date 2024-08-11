@echo off
setlocal
title Windows User Profile Transfer/Backup/Restore Tool
echo Program Name: Windows User Profile Transfer/Backup/Restore Tool
echo Version: 6.0.10
echo Developer: @YonatanReuvenIsraeli
echo Website: https://www.yonatanreuvenisraeli.dev
echo License: GNU General Public License v3.0
net session > nul 2>&1
if not "%errorlevel%"=="0" goto NotAdministrator
goto Start

:NotAdministrator
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto Close

:Start
echo.
echo [1] Transfer from a user profile to another user profile.
echo [2] Backup from a user profile to file.
echo [3] Restore from a file to a user profile.
echo [4] Exit.
set Start=
set /p Start=" What would you like to do? (1-4) "
if /i "%Start%"=="1" goto 1
if /i "%Start%"=="2" goto 2
if /i "%Start%"=="3" goto 3
if /i "%Start%"=="4" goto Close
echo Invalid syntax!
goto Start

:1
echo.
dir "%SystemDrive%\Users" /b
echo.
set UserProfileFrom=
set /p UserProfileFrom="What is the user profile you want to transfer data from? "
if not exist "%SystemDrive%\Users\%UserProfileFrom%" goto UserProfileFromNotExist1
goto UserProfileTo1

:UserProfileFromNotExist1
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 1

:UserProfileTo1
echo.
dir "%SystemDrive%\Users" /b
echo.
set UserProfileTo=
set /p UserProfileTo="What is the user profile path you want to transfer data to? "
if not exist "%SystemDrive%\Users\%UserProfileTo%" goto UsePathToNotExist1
if /i "%SystemDrive%\Users\%UserProfileFrom%"=="%SystemDrive%\Users\%UserProfileTo%" goto Same1
goto HiddenSystem1

:UserProfileToNotExist1
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 1

:Same1
echo.
echo %UserProfileFrom% is the same as %UserProfileTo%! Please try again.
goto 1

:HiddenSystem1
echo.
set HiddenSystem=
set /p HiddenSystem="This will not transfer hidden and system files! Are you sure you want to continue? (Yes/No) "
if /i "%HiddenSystem%"=="Yes" goto Sure1
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid syntax!
goto HiddenSystem1

:Sure1
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure%"=="Yes" goto Transfer
if /i "%Sure%"=="No" goto Start
echo Invalid syntax!
goto Sure1

:Transfer
echo.
echo Transfering %UserProfileFrom% to %UserProfileTo%.
xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*" "%SystemDrive%\Users\%UserProfileTo%" /y /s /e /k /r /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error1
echo %UserProfileFrom% transfered to %UserProfileTo%! Press any key to continue.
pause > nul 2>&1
goto Start

:Error1
echo.
echo There has been an error! You can try again.
goto 1

:2
echo.
dir "%SystemDrive%\Users" /b
echo.
set UserProfileFrom=
set /p UserProfileFrom="What is the user profile to you want to transfer data from? "
if not exist "%SystemDrive%\Users\%UserProfileFrom%" goto UseProfileFromNotExist2
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
if /i "%SystemDrive%\Users\%UserProfileFrom%"=="%FileTo%" goto Same2
goto BackupName

:FileToNotExist
echo "%FileTo%" does not exist. Please try again.
goto 2

:Same2
echo.
echo %UserProfileFrom% is the same location as "%FileTo%"! Please try again.
goto 2

:BackupName
echo.
set BackupName=
set /p BackupName="What would you like the %UserProfileFrom% backup file to be named? "
if exist "%FileTo%\%BackupName%" goto FileToFileExist
goto HiddenSystem2

:FileToFileExist
echo Please rename or move to another location "%FileTo%\%UserProfileFrom% Backup File" in order for this batch file to continue. Press any key to continue when you have renamed or moved to another location "%FileTo%\%UserProfileFrom% Backup File".
pause > nul 2>&1
goto 2

:HiddenSystem2
echo.
set HiddenSystem=
set /p HiddenSystem="This will not backup hidden and system files! Are you sure you want to continue? " (Yes/No)
if /i "%HiddenSystem%"=="Yes" goto Backup
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid syntax!
goto HiddenSystem2

:Backup
echo.
echo Backing up %UserProfileFrom% to "%FileTo%".
md "%FileTo%\%BackupName%"
xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*" "%FileTo%\%BackupName%" /y /s /e /k /r /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error2
echo %UserProfileFrom% backed up to %FileTo%\%BackupName%! Press any key to continue.
pause > nul 2>&1
goto Start

:Error2
echo.
echo There has been an error! You can try again.
goto 2

:3
echo.
set FileFrom=
set /p FileFrom="What is the full path to your backed up user profile file? "
if not exist "%FileFrom%" goto FileFromNotExist
goto UserProfileTo2

:FileFromNotExist
echo.
echo "%FileFrom%" does not exist! You can try again.
goto 3

:UserProfileTo2
echo.
dir "%SystemDrive%\Users" /b
echo.
set UserProfileTo=
set /p UserProfileTo="What is the user profile that you want to restore data to? "
if not exist "%SystemDrive%\Users\%UserProfileTo%" goto UserProfileToNotExist2
if /i "%FileFrom%"=="%SystemDrive%\Users\%UserProfileTo%" goto Same3
goto HiddenSystem3

:UserProfileToNotExist2
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 3

:Same3
echo.
echo "%FileFrom%" is the same location as "%UserProfileTo%"! Please try again.
goto 3

:HiddenSystem3
echo.
set HiddenSystem=
set /p HiddenSystem="This will not restore hidden and system files! Are you sure you want to continue? " (Yes/No)
if /i "%HiddenSystem%"=="Yes" goto Sure3
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid syntax!
goto HiddenSystem3

:Sure3
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure%"=="Yes" goto Restore
if /i "%Sure%"=="No" goto Start
echo Invalid syntax!
goto Sure3

:Restore
echo.
echo Restoring "%FileFrom%" to %UserProfileTo%.
xcopy "%FileFrom%\*.*" "%SystemDrive%\Users\%UserProfileTo%" /y /s /e /k /r /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error3
echo %FileFrom% restored to %UserProfileTo%! Press any key to continue.
pause > nul 2>&1
goto Start

:Error3
echo.
echo There has been an error! You can try again.
goto 3

:Close
endlocal
exit
