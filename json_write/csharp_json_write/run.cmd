@echo off

set OS=Windows_NT

call build N
json_write.exe

pause
