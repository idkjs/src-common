ifeq ($(OS),Windows_NT)
  OS := Windows_NT
else
  OS := $(shell uname -s)
endif

all: unix
unix:
	@erlc date_utc.erl
Windows_NT:
	@erlc date_utc.erl
clean:
