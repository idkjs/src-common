@echo off

PATH=c:\lua
set OS=Windows_NT

call build N
lua nqueens.lua

pause
