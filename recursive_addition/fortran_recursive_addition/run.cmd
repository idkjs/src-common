@echo off

rem needed for dll reference
set PATH=C:\TDM-GCC-64\bin

call build N
recursive_addition.exe

pause
