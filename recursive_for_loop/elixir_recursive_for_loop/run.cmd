@echo off

set PATH=C:\ProgramData\chocolatey\lib\Elixir\bin
set PATH=C:\ProgramData\chocolatey\bin;%PATH%

call build N
rem call elixir recursive_for_loop.exs
call elixir -e RecursiveForLoop.main

pause