ifeq ($(OS),Windows_NT)
  OS := Windows_NT
else
  OS := $(shell uname -s)
endif

all: mono

Windows_NT:
	@csc /nologo /t:exe /out:stream_processing.exe stream_processing.cs
mono:
ifeq ($(OS),FreeBSD)
	@mcs -t:exe -out:stream_processing.exe stream_processing.cs
endif
ifeq ($(OS),Linux)
	@mcs -t:exe -out:stream_processing.exe stream_processing.cs
endif
vstudio:
	@devenv stream_processing.sln /build release
	@rd /S /Q obj
	-@if exist *.obj del *.obj > nul
core:
	@dotnet
clean:
	@rm stream_processing.exe
