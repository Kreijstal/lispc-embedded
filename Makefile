CC = gcc
CFLAGS = -Wall -Wextra -std=c99
LDFLAGS = 
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LISP_FILE = src/stdlib.lisp
HEADER_FILE = src/stdlib_lisp.h

SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCES))
EXECUTABLE = $(BIN_DIR)/lisp_interpreter

.PHONY: all clean

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) $(HEADER_FILE) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS) $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(HEADER_FILE): $(LISP_FILE)
	python3 scripts/generate_c_header.py

$(OBJ_DIR) $(BIN_DIR):
	mkdir -p $@

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR) $(HEADER_FILE)
