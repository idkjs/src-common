@echo off

set PATH=C:\mosml\bin
set OS=Windows_NT

call build N
base64_encode.exe

pause
