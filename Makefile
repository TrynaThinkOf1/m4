CPP = clang++

DATE := $(shell date "+%Y-%m-%d-%H:%M")
# to be used later when binaries are added into the binary dir


INCDIRS = -Iinclude/headers
# where UNcompiled headers are located

LIBDIRS = -Linclude/binaries
# where compiled libraries are located

EXT_LIBS = -lzlibcomplete -lz
# external libraries; -lzlibcomplete=zlibcomplete, -lz=zlib

STD = -std=c++17

OPT = -O2

FLAGS = -Wall -Wextra $(INCDIRS) $(LIBDIRS) $(EXT_LIBS) $(STD) $(OPT)
# -Wall=all errors, -Wextra=extra errors


SRC_DIR = src
CPP_FILES = $(SRC_DIR)/main.cpp $(SRC_DIR)/files.cpp $(SRC_DIR)/utils.cpp
OBJECTS = main.o files.o utils.o

BINARY_DIR = binaries/arm64
BINARY = m4

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CPP) $(FLAGS) -g -o $@ $^
# -g=debugging information for lldb; replaces the "$@" with the binary and the "$^" with the object files

%.o: $(SRC_DIR)/%.cpp # any object file depends on its corresponding source file
	$(CPP) $(FLAGS) -c -o $@ $^
# -c=dont link into ELF; replaces the "$@" with the .o file and the "$^" with the .c file

clean:
	rm -rf $(OBJECTS)
	@for f in $(BINARY_DIR)/*; do \
		if [ -x "$$f" ] && cmp -s $(BINARY) "$$f"; then \
			echo "BINARY IS THE SAME AS ARCHIVED: $$f"; \
			rm $(BINARY); \
		else \
			mv $(BINARY) $(BINARY_DIR)/$(BINARY).$(DATE); \
		fi; \
	done \
# archive binary if its not the same as any of the current archived binaries
