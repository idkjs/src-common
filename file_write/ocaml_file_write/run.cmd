@echo off

set PATH=C:\OCaml\bin
set OS=Windows_NT

call build N
ocamlrun file_write.exe

pause
