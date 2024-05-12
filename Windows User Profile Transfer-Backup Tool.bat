@echo off
setlocal
title Windows User Profile Transfer/Backup Tool
echo Program Name: Windows User Profile Transfer Tool
echo Version: 4.0.0
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
echo [1] Transfer from a user to another user on the this computer.
echo [2] Copy this computers user to file.
echo [3] Copy from file to this computers user.
echo [4] Transfer from a user to another user on connected Windows drive.
echo [5] Copy from connected Windows drive user to file.
echo [6] Copy from file to connected Windows drive user.
echo [7] Exit.
set Start=
set /p Start=" What would you like to do? (1-7) "
if /i "%Start%"=="1" goto 1
if /i "%Start%"=="2" goto 2
if /i "%Start%"=="3" goto 3
if /i "%Start%"=="4" goto DriveLetter
if /i "%Start%"=="5" goto DriveLetter
if /i "%Start%"=="6" goto DriveLetter
if /i "%Start%"=="7" goto Close
echo Invalid Syntax!
goto Start

:1
net user
set UserProfileFrom=
set /p UserProfileFrom="Which profile to you want to transfer data from? "
if not exist "%SystemDrive%\Users\%UserProfileFrom%" goto UserProfileFromNotExist1
goto UserProfileTo1

:UserProfileFromNotExist1
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 1

:UserProfileTo1
echo.
set UserProfileTo=
set /p UserProfileTo="Which profile to you want to transfer data to? "
if not exist "%SystemDrive%\Users\%UserProfileTo%" goto UserProfileFromNotExist1
if "%UserProfileFrom%"=="%UserProfileTo%" goto SameUsers1
goto Sure1

:UserProfileToNotExist1
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 1

:SameUsers1
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
set /p HiddenSystem2="This will not copy hidden and system files! Are you sure you want to continue? " (Yes/No)
if /i "%HiddenSystem%"=="Yes" goto Copy1
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid Syntax!
goto HiddenSystem1

:Copy1
echo.
echo Copying %UserProfileFrom% to %UserProfileTo%.
xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*" "%SystemDrive%\Users\%UserProfileTo%" /y /s /e /k /r /c /q > nul 2>&1
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
goto FileTo1

:UserProfileFromNotExist2
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 2

:FileTo1
echo.
set FileTo=
set /p FileTo="Where do you want to save the user profile %UserProfileFrom% to? "
if not exist "%FileTo%" goto FileToNotExist
if exist "%FileTo%\%UserProfileFrom% File" goto FileToFileExist
goto HiddenSystem2

:FileToNotExist
echo "%FileTo%" does not exist. Please try again.
goto 2

:FileToFileExist1
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
xcopy "%SystemDrive%\Users\%UserProfileFrom%\*.*"  "%FileTo%\%UserProfileFrom% File" /y /s /e /k /r /c /q > nul 2>&1
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
if not exist "%File%" goto FileNotExist1
goto UserProfileTo2

:FileNotExist1
echo.
echo "%File%" does not exist! You can try again.
goto 3

:UserProfileTo2
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
set Sure=
set /p Sure="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure%"=="Yes" goto Copy3
if /i "%Sure%"=="No" goto Start
echo Invalid Syntax
goto Sure3

:Copy3
echo.
echo Copying "%File%" to %UserProfileTo%.
xcopy "%File%\*.*" "%SystemDrive%\Users\%UserProfileTo%\*.*" /y /s /e /k /r /c /q > nul 2>&1 > nul 2>&1
if not "%errorlevel%"=="0" goto Error3
echo.
echo User Profile transfer complete! Press any key to continue.
pause > nul 2>&1
goto Start

:Error3
echo.
echo There has been an error! You can try again.
goto 3

:Driveletter
echo.
set DriveLetter=
set /p DriveLetter="What is the drive letter of the connected Windows drive. (A:-Z:) "
if /i "%DriveLetter%"=="A:" goto SureDriveLetter
if /i "%DriveLetter%"=="B:" goto SureDriveLetter
if /i "%DriveLetter%"=="C:" goto SureDriveLetter
if /i "%DriveLetter%"=="D:" goto SureDriveLetter
if /i "%DriveLetter%"=="E:" goto SureDriveLetter
if /i "%DriveLetter%"=="F:" goto SureDriveLetter
if /i "%DriveLetter%"=="G:" goto SureDriveLetter
if /i "%DriveLetter%"=="H:" goto SureDriveLetter
if /i "%DriveLetter%"=="I:" goto SureDriveLetter
if /i "%DriveLetter%"=="J:" goto SureDriveLetter
if /i "%DriveLetter%"=="K:" goto SureDriveLetter
if /i "%DriveLetter%"=="L:" goto SureDriveLetter
if /i "%DriveLetter%"=="M:" goto SureDriveLetter
if /i "%DriveLetter%"=="N:" goto SureDriveLetter
if /i "%DriveLetter%"=="O:" goto SureDriveLetter
if /i "%DriveLetter%"=="P:" goto SureDriveLetter
if /i "%DriveLetter%"=="Q:" goto SureDriveLetter
if /i "%DriveLetter%"=="R:" goto SureDriveLetter
if /i "%DriveLetter%"=="S:" goto SureDriveLetter
if /i "%DriveLetter%"=="T:" goto SureDriveLetter
if /i "%DriveLetter%"=="U:" goto SureDriveLetter
if /i "%DriveLetter%"=="V:" goto SureDriveLetter
if /i "%DriveLetter%"=="W:" goto SureDriveLetter
if /i "%DriveLetter%"=="X:" goto SureDriveLetter
if /i "%DriveLetter%"=="Y:" goto SureDriveLetter
if /i "%DriveLetter%"=="Z:" goto SureDriveLetter
echo Invalid Syntax!
goto DriveLetter

:SureDriveLetter
echo.
set SureDriveLetter=
set /p SureDriveLetter="Are you sure "%DriveLetter%" is the drive letter of your Windows Disk Image? (Yes/No) "
if /i "%SureDriveLetter%"=="Yes" goto CheckExistDriveLetter
if /i "%SureDriveLetter%"=="No" goto DriveLetter
echo Invalid Syntax!
goto SureDriveLetter

:CheckExistDriveLetter
if not exist "%DriveLetter%" goto DriveLetterNotExist
if /i "%Start%"=="4" goto 4
if /i "%Start%"=="5" goto 5
if /i "%Start%"=="6" goto 6

:DriveLetterNotExist1
echo "%DriveLetter%" does not exist. Please try again.
goto DriveLetter

:4
set UserProfileFrom=
set /p UserProfileFrom="Which profile to you want to transfer data from? "
if not exist "%DriveLetter%\Users\%UserProfileFrom%" goto UserProfileFromNotExist3
goto UserProfileTo3

:UserProfileFromNotExist3
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 4

:UserProfileTo3
echo.
set UserProfileTo=
set /p UserProfileTo="Which profile to you want to transfer data to? "
if not exist "%DriveLetter%\Users\%UserProfileTo%" goto UsePathToNotExist1
if "%UserProfileFrom%"=="%UserProfileTo%" goto SameUsers2
goto Sure3

:UserProfileToNotExist3
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 4

:SameUsers2
echo.
echo "%UserProfileFrom%" is the same as "%UserProfileTo%"! Please try again.
goto 4

:Sure3
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! (Yes/No) "
if /i "%Sure%"=="Yes" goto HiddenSystem3
if /i "%Sure%"=="No" goto Start
echo Invalid Syntax
goto Sure3

:HiddenSytem3
echo.
set HiddenSystem=
set /p HiddenSystem="This will not copy hidden and system files! Are you sure you want to continue? " (Yes/No)
if /i "%HiddenSystem%"=="Yes" goto Copy4
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid Syntax!
goto HiddenSystem3

:Copy4
echo.
echo Copying %UserProfileFrom% to %UserProfileTo%.
xcopy "%DriveLetter%\Users\%UserProfileFrom%\*.*" "%DriveLetter%\Users\%UserProfileTo%" /y /s /e /k /r /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error4
echo.
echo User Profile transfer complete! Press any key to continue.
pause > nul 2>&1
goto Start

:Error4
echo.
echo There has been an error! You can try again.
goto 4

:5
echo.
set UserProfileFrom=
set /p UserProfileFrom="Which profile to you want to transfer data From? "
if not exist "%DriveLetter%\Users\%UserProfileFrom%" goto UseProfileFromNotExist4
goto FileTo2

:UserProfileFromNotExist4
echo.
echo %UserProfileFrom% does not exist! Please try again.
goto 5

:FileTo2
echo.
set FileTo=
set /p FileTo="Where do you want to save the user profile %UserProfileFrom% to? "
if not exist "%FileTo%" goto FileToNotExist2
if exist "%FileTo%\%UserProfileFrom% File" goto FileToFileExist4
goto HiddenSystem4

:FileToNotExist2
echo "%FileTo%" does not exist. Please try again.
goto 5

:FileToFileExist2
echo Please rename or move to another location "%FileTo%\%UserProfileFrom%" in order for this batch file to continue. Press any key to continue when you have renamed or moved  to another location "%FileTo%\%UserProfileFrom%".
pause > nul 2>&1
goto 5

:HiddenSystem4
echo.
set HiddenSystem=
set /p HiddenSystem="This will not copy hidden and system files! Are you sure you want to continue? " (Yes/No)
if /i "%HiddenSystem%"=="Yes" goto Copy5
if /i "%HiddenSystem%"=="No" goto Start
echo Invalid Syntax!
goto HiddenSystem4

:Copy5
echo.
echo Copying %UserProfileFrom% to "%FileTo%".
md "%FileTo%\%UserProfileFrom% File"
xcopy "%DriveLetter%\Users\%UserProfileFrom%\*.*"  "%FileTo%\%UserProfileFrom% File" /y /s /e /k /r /c /q > nul 2>&1
if not "%errorlevel%"=="0" goto Error5
echo.
echo %UserProfileFrom% copied to "%FileTo%\%UserProfileFrom% File". Press any key to continue.
pause > nul 2>&1
goto Start

:Error5
echo.
echo There has been an error! You can try again.
goto 5

:6
echo.
set File=
set /p File="What is the full path to your copied user profile file? "
if not exist "%File%" goto FileNotExist2
goto UserProfileTo4

:FileNotExist2
echo.
echo "%File%" does not exist! You can try again.
goto 6

:UserProfileTo4
net user
set UserProfileTo=
set /p UserProfileTo="Which profile to you want to transfer data to? "
if not exist "%SystemDrive%\Users\%UserProfileTo%" goto UserProfileToNotExist4
goto Sure3

:UserProfileToNotExist4
echo.
echo %UserProfileTo% does not exist! Please try again.
goto 3

:Sure4
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure%"=="Yes" goto Copy6
if /i "%Sure%"=="No" goto Start
echo Invalid Syntax
goto Sure4

:Copy6
echo.
echo Copying "%File%" to %UserProfileTo%.
xcopy "%File%\*.*" "%DriveLetter%\Users\%UserProfileTo%\*.*" /y /s /e /k /r /c /q > nul 2>&1 > nul 2>&1
if not "%errorlevel%"=="0" goto Error6
echo.
echo User Profile transfer complete! Press any key to continue.
pause > nul 2>&1
goto Start

:Error6
echo.
echo There has been an error! You can try again.
goto 6

:Close
endlocal
exit
