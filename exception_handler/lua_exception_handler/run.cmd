@echo off

PATH=c:\lua
set OS=Windows_NT

call build N
lua exception_handler.lua

pause
