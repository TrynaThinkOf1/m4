CPP=clang++

SOURCE_DIR=src
BUILD_DIR=build

BINARY_DIR=binaries/arm64
BINARY=m4

DATE:=$(shell date "+%Y-%m-%d-%H:%M")
# to be used later when binaries are added into the binary dir


INC_DIRS=include
# where UNcompiled headers are located

LIB_DIRS=lib
# where compiled libraries are located

EXT_LIBS=-lzlibcomplete -lz
# external libraries; -lzlibcomplete=zlibcomplete, -lz=zlib

STD=-std=c++17

OPT=-O2

DEP_FLAGS=-MP -MD
# flags for generating dependancy .d files (for Make)

FINAL_FLAGS=-Wall -Wextra -I$(INC_DIRS) -L$(LIB_DIRS) $(EXT_LIBS) $(STD) $(OPT) $(DEP_FLAGS)
# -Wall=all warnings, -Wextra=extra warnings
OBJECT_FLAGS=-Wall -Wextra -I$(INC_DIRS) $(STD) $(OPT) $(DEP_FLAGS)



CPP_FILES_WITH_DIR=$(wildcard src/*.cpp)

CPP_FILES=$(notdir $(CPP_FILES_WITH_DIR))
OBJECTS=$(patsubst %.cpp, $(BUILD_DIR)/%.o, $(CPP_FILES))
DEP_FILES=$(patsubst %.cpp, $(BUILD_DIR)/%.d, $(CPP_FILES))



all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CPP) $(FINAL_FLAGS) -g -o $@ $^
# -g=debugging information for lldb; replaces the "$@" with the binary and the "$^" with the object files

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp # any object file depends on its corresponding source file
	$(CPP) $(OBJECT_FLAGS) -c -o $@ $^
# -c=dont link into ELF; replaces the "$@" with the .o file and the "$^" with the .c file


clean-full:
	rm -rf $(OBJECTS) $(DEP_FILES)

clean:
	rm -rf $(OBJECTS)

archive:
	@if [ -f "m4" ]; then \
		for f in $(BINARY_DIR)/*; do \
			if [ -x "$$f" ] && cmp -s $(BINARY) "$$f"; then \
				echo "BINARY IS THE SAME AS ARCHIVED: $$f"; \
				rm $(BINARY); \
			else \
				echo "MOVING BINARY TO ARCHIVED BINARY: $(BINARY_DIR)/$(BINARY).$(DATE)"; \
				mv $(BINARY) $(BINARY_DIR)/$(BINARY).$(DATE); \
			fi; \
		done \
	fi
# archive binary if its not the same as any of the current archived binaries


-include $(DEP_FILES)
