@echo off

set PATH=%GROOVY_HOME%\bin
set PATH=c:\Java\jre\bin;%PATH%
set OS=Windows_NT

call build N
java -cp %GROOVY_HOME%\embeddable\groovy-all-2.4.13.jar -jar example.jar
rem java -cp %GROOVY_HOME%\embeddable\groovy-all-2.4.13.jar -jar exampleManifest.jar
rem java -cp %GROOVY_HOME%\embeddable\groovy-all-2.4.13.jar;example.jar example
rem java -cp C:\groovy\embeddable\groovy-all-2.4.12.jar;. example

rem as a script
rem groovy example
rem groovy example.groovy

pause
