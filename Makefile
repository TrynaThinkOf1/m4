CPP=clang++


INCDIRS=-I./include/headers # where UNcompiled headers are located
LIBDIRS=-L./include/binaries # where compiled libraries are located
EXT_LIBS=-lz # external libraries; -lz=zlib, 
STD=-std=c++17
OPT=-O2

FLAGS=-Wall -Wextra $(INCDIRS) $(LIBDIRS) $(EXT_LIBS) $(STD) $(OPT)
# imperative that ext libraries go AFTER internal libraries; -Wall=all errors, -Wextra=extra errors


SRC_DIR=./src
CPP_FILES=$(SRC_DIR)/main.cpp $(SRC_DIR)/files.cpp $(SRC_DIR)/utils.cpp
OBJECTS=main.o files.o utils.o

BINARY_DIR=./binaries/arm64
BINARY=m4

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CPP) -g -o $@ $^
# -g=debugging information for lldb; replaces the "$@" with the binary and the "$^" with the object files

%.o: $(SRC_DIR)/%.cpp # any object file depends on its corresponding source file
	$(CPP) $(FLAGS) -c -o $@ $^
# -c=dont link into ELF; replaces the "$@" with the .o file and the "$^" with the .c file

clean:
	rm -rf $(OBJECTS)
	mv $(BINARY) $(BINARY_DIR)
