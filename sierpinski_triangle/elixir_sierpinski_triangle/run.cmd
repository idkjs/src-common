@echo off

set PATH=C:\ProgramData\chocolatey\lib\Elixir\bin
set PATH=C:\ProgramData\chocolatey\bin;%PATH%

call build N
rem call elixir sierpinski_triangle.exs
call elixir -e SierpinskiTriangle.main

pause