CPP=clang++


INCDIRS=-I./include/headers # where are UNcompiled headers located?
LIBDIRS=-L./include/binaries # where are compiled libraries located?
STD=-std=c++17
OPT=-O2

FLAGS=-Wall -Wextra -g $(INCDIRS) $(LIBDIRS) $(STD) $(OPT)
# -Wall = all errors, -Wextra = extra errors, -g = debugging information for lldb


SRC_DIR=./src
CPP_FILES=$(SRC_DIR)/main.cpp $(SRC_DIR)/utils.cpp
OBJECTS=main.o utils.o

BINARY_DIR=./binaries/arm64
BINARY=m4

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CPP) -o $@ $^
# replaces the "$@" with the binary and the "$^" with the object files

%.o: $(SRC_DIR)/%.cpp # any object file depends on its corresponding source file
	$(CPP) $(FLAGS) -c -o $@ $^
# -c flag doesnt link into executable; replaces the "$@" with the .o file and the "$^" with the .c file

clean:
	rm -rf $(OBJECTS)
	mv $(BINARY) $(BINARY_DIR)
