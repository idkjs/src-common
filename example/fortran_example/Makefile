ifeq ($(OS),Windows_NT)
  OS := Windows_NT
else
  OS := $(shell uname -s)
endif

all: unix
unix:
	@gfortran example.f -o example.exe
Windows_NT:
	@gfortran example.f -o example.exe
