ifeq ($(OS),Windows_NT)
  OS := Windows_NT
else
  OS := $(shell uname -s)
endif

all: unix
unix:
	@scalac gcd.scala
	@jar cmf manifest.mf gcd.jar *.class
	@rm *.class
Windows_NT:
	@scalac gcd.scala
	@jar cmf manifest.mf gcd.jar *.class
#	@del *.class
clean:
	@echo clean
