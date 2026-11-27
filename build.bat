@echo off
setlocal

call gradlew.bat assembleGitRelease
if errorlevel 1 exit /b 1

copy /Y app\build\outputs\apk\git\release\app-git-release.apk FreshStrike1.6.apk >nul
if errorlevel 1 exit /b 1

echo Built FreshStrike1.6.apk
