ifeq ($(OS),Windows_NT)
  OS := Windows_NT
else
  OS := $(shell uname -s)
endif

all: unix
unix:
	@fsharpc --nologo luhn.fs
Windows_NT:
	@fsc /nologo luhn.fs /o luhn.exe
core:
	@dotnet
clean:
	@rm luhn.exe
