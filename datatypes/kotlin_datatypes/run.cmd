@echo off

set PATH=C:\Java\jre\bin
set OS=Windows_NT

call build N
if exist Datatypes.kt (
    java -jar Datatypes.jar
) else (
    if NOT exist Datatypes.java (
        echo copy datatypes.
        copy "..\..\datatypes\kotlin_datatypes\Datatypes.kt" "Datatypes.kt"
    )
)

pause
