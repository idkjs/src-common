@echo off

set PATH=%GROOVY_HOME%\bin
set PATH=c:\Java\jre\bin;%PATH%
set OS=Windows_NT

call build N
java -cp %GROOVY_HOME%\embeddable\groovy-all-2.4.13.jar -jar combinations.jar
rem java -cp %GROOVY_HOME%\embeddable\groovy-all-2.4.13.jar -jar combinationsManifest.jar
rem java -cp %GROOVY_HOME%\embeddable\groovy-all-2.4.13.jar;combinations.jar combinations
rem java -cp C:\groovy\embeddable\groovy-all-2.4.12.jar;. combinations

rem as a script
rem groovy combinations
rem groovy combinations.groovy

pause
