@echo off

set PATH=C:\Java\jre\bin
set OS=Windows_NT

call build N
if exist SierpinskiTriangle.kt (
    java -jar SierpinskiTriangle.jar
) else (
    if NOT exist SierpinskiTriangle.java (
        echo copy sierpinski_triangle.
        copy "..\..\sierpinski_triangle\kotlin_sierpinski_triangle\SierpinskiTriangle.kt" "SierpinskiTriangle.kt"
    )
)

pause
