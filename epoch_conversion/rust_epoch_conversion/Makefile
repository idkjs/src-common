ifeq ($(OS),Windows_NT)
  OS := Windows_NT
else
  OS := $(shell uname -s)
endif

all: linux
linux:
	@cargo build  #>&/dev/null
	@mv target/debug/epoch_conversion epoch_conversion.exe
	@rm -rf target
	@rm -f Cargo.lock
Windows_NT:
	@cargo build
	@move "target\debug\epoch_conversion.exe" .
clean:
