@echo off

rem need to escape space to work with mingw32-make
set PATH=c:\lua
set PATH=C:\TDM-GCC-64\bin;%PATH%
set OS=Windows_NT

mingw32-make Windows_NT

IF "%~1"=="" pause
