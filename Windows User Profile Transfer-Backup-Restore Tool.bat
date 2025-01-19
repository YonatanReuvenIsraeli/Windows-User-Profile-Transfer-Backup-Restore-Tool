@echo off
setlocal
title Windows User Profile Transfer/Backup/Restore Tool
echo Program Name: Windows User Profile Transfer/Backup/Restore Tool
echo Version: 7.0.13
echo License: GNU General Public License v3.0
echo Developer: @YonatanReuvenIsraeli
echo GitHub: https://github.com/YonatanReuvenIsraeli
echo Sponsor: https://github.com/sponsors/YonatanReuvenIsraeli
"%windir%\System32\net.exe" session > nul 2>&1
if not "%errorlevel%"=="0" goto "NotAdministrator"
goto "Start"

:"NotAdministrator"
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"Start"
echo.
echo [1] Transfer from a user profile to another user profile.
echo [2] Backup from a user profile to file.
echo [3] Restore from a file to a user profile.
echo [4] Exit.
echo.
set Start=
set /p Start="What would you like to do? (1-4) "
if /i "%Start%"=="1" goto "DriveLetterFrom"
if /i "%Start%"=="2" goto "DriveLetterBackup"
if /i "%Start%"=="3" goto "3"
if /i "%Start%"=="4" goto "Close"
echo Invalid syntax!
goto "Start"

:"DriveLetterFrom"
echo.
set DriveLetterFrom=
set /p DriveLetterFrom="What is the drive letter of your Windows installation you want to transfer a user profile from? (A:-Z:) "
if /i "%DriveLetterFrom%"=="A:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="B:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="C:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="D:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="E:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="F:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="G:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="H:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="I:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="J:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="K:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="L:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="M:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="N:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="O:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="P:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="Q:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="R:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="S:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="T:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="U:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="V:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="W:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="X:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="Y:" goto "SureDriveLetterFrom"
if /i "%DriveLetterFrom%"=="Z:" goto "SureDriveLetterFrom"
echo Invalid syntax!
goto "DriveLetterFrom"

:"SureDriveLetterFrom"
echo.
set SureDriveLetterFrom=
set /p SureDriveLetterFrom="Are you sure "%DriveLetterFrom%" is the drive letter of your Windows installation you want to transfer a user profile from? (Yes/No) "
if /i "%SureDriveLetterFrom%"=="Yes" goto "CheckExistDriveLetterFrom"
if /i "%SureDriveLetterFrom%"=="No" goto "DriveLetterFrom"
echo Invalid syntax!
goto "SureDriveLetterFrom"

:"CheckExistDriveLetterFrom"
if not exist "%DriveLetterFrom%" goto "NotExistFrom"
goto "1"

:"NotExistFrom"
echo "%DriveLetterFrom%" does not exist. Please try again.
goto "DriveLetterFrom"

:"1"
if not exist "%DriveLetterFrom%\Users" goto "TransferFromNotExist"
echo.
dir "%DriveLetterFrom%\Users" /b
echo.
set UserProfileFrom=
set /p UserProfileFrom="What is the user profile you want to transfer data from? "
if not exist "%DriveLetterFrom%\Users\%UserProfileFrom%" goto "UserProfileFromNotExist1"
goto "SureUserProfileFrom"

:"TransferFromNotExist"
echo "%DriveLetterFrom%" is not a Windows installation! Please try again.
goto "DriveLetterFrom"

:"UserProfileFromNotExist1"
echo %UserProfileFrom% does not exist! Please try again.
goto "1"

:"SureUserProfileFrom"
echo.
set SureUserProfileFrom=
set /p SureUserProfileFrom="Are you sure %UserProfileFrom% is the user profile you want to transfer data from? (Yes/No) "
if /i "%SureUserProfileFrom%"=="Yes" goto "DriveLetterTo"
if /i "%SureUserProfileFrom%"=="No" goto "DriveLetterFrom"
echo Invalid syntax!
goto "SureUserProfileFrom"

:"DriveLetterTo"
echo.
set DriveLetterTo=
set /p DriveLetterTo="What is the drive letter of your Windows installation you want to transfer a user profile to? (A:-Z:) "
if /i "%DriveLetterTo%"=="A:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="B:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="C:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="D:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="E:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="F:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="G:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="H:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="I:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="J:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="K:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="L:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="M:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="N:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="O:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="P:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="Q:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="R:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="S:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="T:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="U:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="V:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="W:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="X:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="Y:" goto "SureDriveLetterTo"
if /i "%DriveLetterTo%"=="Z:" goto "SureDriveLetterTo"
echo Invalid syntax!
goto "DriveLetterTo"

:"SureDriveLetterTo"
echo.
set SureDriveLetterTo=
set /p SureDriveLetterTo="Are you sure "%DriveLetterTo%" is the drive letter of your Windows installation you want to transfer a user profile to? (Yes/No) "
if /i "%SureDriveLetterTo%"=="Yes" goto "CheckExistDriveLetterTo"
if /i "%SureDriveLetterTo%"=="No" goto "DriveLetterTo"
echo Invalid syntax!
goto "SureDriveLetterTo"

:"CheckExistDriveLetterTo"
if not exist "%DriveLetterTo%" goto "NotExistTo"
goto "UserProfileTo1"

:"NotExistTo"
echo "%DriveLetterTo%" does not exist. Please try again.
goto "DriveLetterTo"

:"UserProfileTo1"
if not exist "%DriveLetterTo%\Users" goto "TransferToNotExist"
echo.
dir "%DriveLetterTo%\Users" /b
echo.
set UserProfileTo=
set /p UserProfileTo="What is the user profile you want to transfer data to? "
if not exist "%DriveLetterTo%\Users\%UserProfileTo%" goto "UserProfileToNotExist1"
if /i "%DriveLetterTo%\Users\%UserProfileFrom%"=="%DriveLetterFrom%\Users\%UserProfileTo%" goto "Same1"
goto "SureUserProfileTo1"

:"TransferToNotExist"
echo "%DriveLetterTo%" is not a Windows installation! Please try again.
goto "DriveLetterTo"

:"UserProfileToNotExist1"
echo %UserProfileTo% does not exist! Please try again.
goto "1"

:"Same1"
echo Drive letter "%DriveLetterFrom%" and user %UserProfileFrom% is the same as drive letter "%DriveLetterTo%" and user %UserProfileTo%! Please try again.
goto "DriveLetterFrom"

:"SureUserProfileTo1"
echo.
set SureUserProfileTo=
set /p SureUserProfileTo="Are you sure %UserProfileTo% is the user profile you want to transfer data to? (Yes/No) "
if /i "%SureUserProfileTo%"=="Yes" goto "TransferErrorCheck"
if /i "%SureUserProfileTo%"=="No" goto "DriveLetterTo"
echo Invalid syntax!
goto "SureUserProfileTo1"

:"TransferErrorCheck"
if exist "%DriveLetterTo%\Users\%UserProfileTo%\%UserProfileFrom% Transfer Error Log.txt" goto "TransferErrorExist"
goto "HiddenSystem1"

:"TransferErrorExist"
echo Please rename or move to another location "%DriveLetterTo%\Users\%UserProfileTo%\%UserProfileFrom% Transfer Error Log.txt" in order for this batch file to continue. Press any key to continue when you have renamed or moved to another location "%DriveLetterTo%\Users\%UserProfileTo%\%UserProfileFrom% Transfer Error Log.txt".
pause > nul 2>&1
goto "TransferErrorCheck"

:"HiddenSystem1"
echo.
set HiddenSystem=
set /p HiddenSystem="This will not transfer hidden and system files! Are you sure you want to continue? (Yes/No) "
if /i "%HiddenSystem%"=="Yes" goto "Sure1"
if /i "%HiddenSystem%"=="No" goto "Start"
echo Invalid syntax!
goto "HiddenSystem1"

:"Sure1"
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure%"=="Yes" goto "TransferCheck"
if /i "%Sure%"=="No" goto "Start"
echo Invalid syntax!
goto "Sure1"

:"TransferCheck"
echo.
set Check=
set /p Check="There is no going back after this! Are you sure you want to transfer drive letter "%DriveLetterFrom%" user %UserProfileFrom% to drive letter "%DriveLetterTo%" user %UserProfileTo%? (Yes/No) "
if /i "%Check%"=="Yes" goto "Transfer"
if /i "%Check%"=="No" goto "Start"
echo Invalid syntax!
goto "TransferCheck"

:"Transfer"
echo.
echo Transfering drive letter "%DriveLetterFrom%" user %UserProfileFrom% to drive letter "%DriveLetterTo%" user %UserProfileTo%.
"%windir%\System32\xcopy.exe" "%DriveLetterFrom%\Users\%UserProfileFrom%\*.*" "%DriveLetterTo%\Users\%UserProfileTo%" /y /s /e /k /r /c /q > nul 2>>"%DriveLetterTo%\Users\%UserProfileTo%\%UserProfileFrom% Transfer Error Log.txt"
if not "%errorlevel%"=="0" goto "Error1"
echo Drive letter "%DriveLetterFrom%" user %UserProfileFrom% transfered to drive letter "%DriveLetterTo%" user %UserProfileTo%! Transfer error logs can be viewed at "%DriveLetterTo%\Users\%UserProfileTo%\%UserProfileFrom% Transfer Error Log.txt". Press any key to continue.
pause > nul 2>&1
goto "Start"

:"Error1"
echo There has been an error! You can try again.
goto "DriveLetterFrom"

:"DriveLetterBackup"
echo.
set DriveLetterBackup=
set /p DriveLetterBackup="What is the drive letter of your Windows installation you want to backup a user profile from? (A:-Z:) "
if /i "%DriveLetterBackup%"=="A:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="B:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="C:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="D:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="E:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="F:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="G:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="H:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="I:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="J:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="K:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="L:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="M:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="N:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="O:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="P:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="Q:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="R:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="S:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="T:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="U:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="V:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="W:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="X:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="Y:" goto "SureDriveLetterBackup"
if /i "%DriveLetterBackup%"=="Z:" goto "SureDriveLetterBackup"
echo Invalid syntax!
goto "DriveLetterBackup"

:"SureDriveLetterBackup"
echo.
set SureDriveLetterBackup=
set /p SureDriveLetterBackup="Are you sure "%DriveLetterBackup%" is the drive letter of your Windows installation you want to backup a user profile from? (Yes/No) "
if /i "%SureDriveLetterBackup%"=="Yes" goto "CheckExistDriveLetterBackup"
if /i "%SureDriveLetterBackup%"=="No" goto "DriveLetterBackup"
echo Invalid syntax!
goto "SureDriveLetterBackup"

:"CheckExistDriveLetterBackup"
if not exist "%DriveLetterBackup%" goto "NotExistBackup"
goto "2"

:"NotExistBackup"
echo "%DriveLetterBackup%" does not exist. Please try again.
goto "DriveLetterBackup"

:"2"
if not exist "%DriveLetterBackup%\Users" goto "BackupNotExist"
echo.
dir "%DriveLetterBackup%\Users" /b
echo.
set UserProfileFrom=
set /p UserProfileFrom="What is the user profile to you want to backup data from? "
if not exist "%DriveLetterBackup%\Users\%UserProfileFrom%" goto "UseProfileFromNotExist2"
goto "SureBackup"

:"BackupNotExist"
echo "%DriveLetterBackup%" is not a Windows installation! Please try again.
goto "DriveLetterBackup"

:"UserProfileFromNotExist2"
echo %UserProfileFrom% does not exist! Please try again.
goto "2"

:"SureBackup"
echo.
set SureBackup=
set /p SureBackup="Are you sure %UserProfileFrom% is the user profile you want to backup data from? (Yes/No) "
if /i "%SureBackup%"=="Yes" goto "FileTo"
if /i "%SureBackup%"=="No" goto "DriveLetterBackup"
echo Invalid syntax!
goto "SureBackup"

:"FileTo"
echo.
set FileTo=
set /p FileTo="Where do you want to save the user profile %UserProfileFrom% to? "
if not exist "%FileTo%" goto "FileToNotExist"
if /i "%DriveLetterBackup%\Users\%UserProfileFrom%"=="%FileTo%" goto "Same2"
goto "BackupName"

:"FileToNotExist"
echo "%FileTo%" does not exist. Please try again.
goto "2"

:"Same2"
echo %UserProfileFrom% is the same location as "%FileTo%"! Please try again.
goto "2"

:"BackupName"
echo.
set BackupName=
set /p BackupName="What would you like the %UserProfileFrom% backup file to be named? "
if exist "%FileTo%\%BackupName%" goto "FileToFileExist"
goto "SureFileTo"

:"FileToFileExist"
echo Please rename or move to another location "%FileTo%\%BackupName%" in order for this batch file to continue. Press any key to continue when you have renamed or moved to another location "%FileTo%\%BackupName%".
pause > nul 2>&1
goto "2"

:"SureFileTo"
echo.
set SureFileTo=
set /p SureFileTo="Are you sure "%FileTo%\%BackupName%" is the where you want to backup to? (Yes/No) "
if /i "%SureFileTo%"=="Yes" goto "HiddenSystem2"
if /i "%SureFileTo%"=="No" goto "FileTo"
echo Invalid syntax!
goto "SureFileName"

:"HiddenSystem2"
echo.
set HiddenSystem=
set /p HiddenSystem="This will not backup hidden and system files! Are you sure you want to continue? (Yes/No) "
if /i "%HiddenSystem%"=="Yes" goto "BackupCheck"
if /i "%HiddenSystem%"=="No" goto "Start"
echo Invalid syntax!
goto "HiddenSystem2"

:"BackupCheck"
echo.
set Check=
set /p Check="There is no going back after this! Are you sure you want to backup drive letter "%DriveLetterBackup%" user %UserProfileFrom% to "%FileTo%\%BackupName%"? (Yes/No) "
if /i "%Check%"=="Yes" goto "Backup"
if /i "%Check%"=="No" goto "Start"
echo Invalid syntax!
goto "BackupCheck"

:"Backup"
echo.
echo Backing up drive letter "%DriveLetterBackup%" user %UserProfileFrom% to "%FileTo%\%BackupName%".
md "%FileTo%\%BackupName%" > nul 2>&1
md "%FileTo%\%BackupName%\Files" > nul 2>&1
"%windir%\System32\xcopy.exe" "%DriveLetterBackup%\Users\%UserProfileFrom%\*.*" "%FileTo%\%BackupName%\Files" /y /s /e /k /r /c /q > nul 2>>"%FileTo%\%BackupName%\Backup Error Log.txt"
if not "%errorlevel%"=="0" goto "Error2"
echo Drive letter "%DriveLetterBackup%" user %UserProfileFrom% backed up to "%FileTo%"! Backup Error logs can be viewed at "%FileTo%\%BackupName%\Backup Error Log.txt". Press any key to continue.
pause > nul 2>&1
goto "Start"

:"Error2"
echo There has been an error! You can try again.
goto "DriveLetterBackup"

:"3"
echo.
set FileFrom=
set /p FileFrom="What is the full path to your backed up user profile file? "
if not exist "%FileFrom%" goto "FileFromNotExist"
goto "SureFileFrom"

:"FileFromNotExist"
echo "%FileFrom%" does not exist! You can try again.
goto "3"

:"SureFileFrom"
echo.
set SureFileFrom=
set /p SureFileFrom="Are you sure "%FileFrom%" is the full path to your backed up user profile file? (Yes/No) "
if /i "%SureFileFrom%"=="Yes" goto "DriveLetterRestore"
if /i "%SureFileFrom%"=="No" goto "3"
echo Invalid syntax!
goto "SureFileFrom"

:"DriveLetterRestore"
echo.
set DriveLetterRestore=
set /p DriveLetterRestore="What is the drive letter of your Windows installation you want to restore a user profile to? (A:-Z:) "
if /i "%DriveLetterRestore%"=="A:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="B:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="C:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="D:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="E:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="F:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="G:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="H:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="I:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="J:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="K:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="L:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="M:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="N:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="O:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="P:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="Q:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="R:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="S:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="T:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="U:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="V:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="W:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="X:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="Y:" goto "SureDriveLetterRestore"
if /i "%DriveLetterRestore%"=="Z:" goto "SureDriveLetterRestore"
echo Invalid syntax!
goto "DriveLetterRestore"

:"SureDriveLetterRestore"
echo.
set SureDriveLetterRestore=
set /p SureDriveLetterRestore="Are you sure "%DriveLetterRestore%" is the drive letter of your Windows installation you want to restore a user profile to? (Yes/No) "
if /i "%SureDriveLetterRestore%"=="Yes" goto "CheckExistDriveLetterRestore"
if /i "%SureDriveLetterRestore%"=="No" goto "DriveLetterRestore"
echo Invalid syntax!
goto "SureDriveLetterRestore"

:"CheckExistDriveLetterRestore"
if not exist "%DriveLetterRestore%" goto "NotExistRestore"
goto "UserProfileTo2"

:"NotExistRestore"
echo "%DriveLetterRestore%" does not exist. Please try again.
goto "DriveLetterRestore"

:"UserProfileTo2"
if not exist "%DriveLetterRestore%\Users" goto "RestoreNotExist"
echo.
dir "%DriveLetterRestore%\Users" /b
echo.
set UserProfileTo=
set /p UserProfileTo="What is the user profile that you want to restore data to? "
if not exist "%DriveLetterRestore%\Users\%UserProfileTo%" goto "UserProfileToNotExist2"
if /i "%FileFrom%"=="%DriveLetterRestore%\Users\%UserProfileTo%" goto "Same3"
goto "HiddenSystem3"

:"RestoreNotExist"
echo "%DriveLetterRestore%" is not a Windows installation! Please try again.
goto "DriveLetterRestore"

:"UserProfileToNotExist2"
echo %UserProfileTo% does not exist! Please try again.
goto "3"

:"Same3"
echo "%FileFrom%" is the same location as "%UserProfileTo%"! Please try again.
goto "3"

:"SureUserProfileTo2"
echo.
set SureUserProfileTo=
set /p SureUserProfileTo="Are you sure %UserProfileTo% is the where you want to backup user profile %UserProfileFrom% to? (Yes/No) "
if /i "%SureUserProfileTo%"=="Yes" goto "RestoreErrorCheck"
if /i "%SureUserProfileTo%"=="No" goto "DriveLetterRestore"
echo Invalid syntax!
goto "SureUserProfileTo2"

:"RestoreErrorCheck"
if exist "%DriveLetterRestore%\Users\%UserProfileTo%\%FileFrom% Restore Error Log.txt" goto "RestoreErrorExist"
goto "HiddenSystem3"

:"RestoreErrorExist"
echo Please rename or move to another location "%DriveLetterRestore%\Users\%UserProfileTo%\%FileFrom% Restore Error Log.txt" in order for this batch file to continue. Press any key to continue when you have renamed or moved to another location "%DriveLetterRestore%\Users\%UserProfileTo%\%FileFrom% Restore Error Log.txt".
pause > nul 2>&1
goto "RestoreErrorCheck"

:"HiddenSystem3"
echo.
set HiddenSystem=
set /p HiddenSystem="This will not restore hidden and system files! Are you sure you want to continue? (Yes/No) "
if /i "%HiddenSystem%"=="Yes" goto "Sure3"
if /i "%HiddenSystem%"=="No" goto "Start"
echo Invalid syntax!
goto "HiddenSystem3"

:"Sure3"
echo.
set Sure=
set /p Sure="This will overwrite files with the same name! Are you sure you want to continue? (Yes/No) "
if /i "%Sure%"=="Yes" goto "RestoreCheck"
if /i "%Sure%"=="No" goto "Start"
echo Invalid syntax!
goto "Sure3"

:"RestoreCheck"
echo.
set Check=
set /p Check="There is no going back after this! Are you sure you want to restore "%FileFrom%" to drive letter "%DriveLetterRestore%" user %UserProfileTo%? (Yes/No) "
if /i "%Check%"=="Yes" goto "Restore"
if /i "%Check%"=="No" goto "Start"
echo Invalid syntax!
goto "RestoreCheck"

:"Restore"
echo.
echo Restoring "%FileFrom%" to drive letter "%DriveLetterRestore%" user %UserProfileTo%.
"%windir%\System32\xcopy.exe" "%FileFrom%\*.*" "%DriveLetterRestore%\Users\%UserProfileTo%" /y /s /e /k /r /c /q > nul 2>>"%DriveLetterRestore%\Users\%UserProfileTo%\%FileFrom% Restore Error Log.txt"
if not "%errorlevel%"=="0" goto "Error3"
echo %FileFrom% restored to drive letter "%DriveLetterRestore%" user %UserProfileTo%! Restore error log can be viewd at %DriveLetterRestore%\Users\%UserProfileTo%\%FileFrom% Restore Error Log.txt". Press any key to continue.
pause > nul 2>&1
goto "Start"

:"Error3"
echo There has been an error! You can try again.
goto "3"

:"Close"
endlocal
exit
