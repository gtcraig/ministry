@echo off
set DEVPATH="C:\Program Files\Microsoft Visual Studio 8\Common7\IDE"

echo Building Debug version...

%DEVPATH%\devenv.exe MseBuilder.sln /rebuild Debug /out log\log.debug.txt

echo Building Release version...

%DEVPATH%\devenv.exe MseBuilder.sln /rebuild Release /out log\log.release.txt

