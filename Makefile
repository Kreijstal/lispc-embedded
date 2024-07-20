CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -I$(INCLUDE_DIR)
LDFLAGS = 
SRC_DIR = src
INCLUDE_DIR = include
OBJ_DIR = obj
BIN_DIR = bin
LISP_FILE = src/stdlib.lisp
HEADER_FILE = $(INCLUDE_DIR)/stdlib_lisp.h

SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCES))
EXECUTABLE = $(BIN_DIR)/lisp_interpreter

.PHONY: all clean

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS) $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HEADER_FILE) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(HEADER_FILE): $(LISP_FILE)
	python3 scripts/generate_c_header.py > $(HEADER_FILE)

$(OBJ_DIR) $(BIN_DIR):
	mkdir -p $@

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)
