@echo off

SET PATH=c:\perl\bin
SET PATH=C:\Perl64\bin;%PATH%
set OS=Windows_NT

perl postgresql_connect.pl

pause
