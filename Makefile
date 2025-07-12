# Makefile for Crafting Interpreters (Lox)
# Usage:
#   make           # Compile the project
#   make run       # Run the REPL
#   make run FILE=path/to/script.lox  # Run a script file
#   make ast       # Generate AST classes

# Directory containing Java source files
SRC_DIR = src/main/java/com/craftinginterpreters/lox
# Output directory for compiled classes
OUT_DIR = out
# Main class to run
MAIN_CLASS = com.craftinginterpreters.lox.Lox
# Tool directory
TOOL_DIR = src/main/java/com/craftinginterpreters/tool

# Find all Java source files
SOURCES = $(wildcard $(SRC_DIR)/*.java)

# Default target: compile the project
all: $(OUT_DIR)/classes.stamp

# Compile all Java files to the output directory
$(OUT_DIR)/classes.stamp: $(SOURCES)
	@mkdir -p $(OUT_DIR)
	javac -d $(OUT_DIR) $(SOURCES)
	@touch $(OUT_DIR)/classes.stamp

# Generate AST classes
ast: $(OUT_DIR)/ast.stamp

$(OUT_DIR)/ast.stamp: $(TOOL_DIR)/GenerateAst.java
	@mkdir -p $(OUT_DIR)
	javac -d $(OUT_DIR) $(TOOL_DIR)/GenerateAst.java
	java -cp $(OUT_DIR) com.craftinginterpreters.tool.GenerateAst $(SRC_DIR)
	@touch $(OUT_DIR)/ast.stamp

# Run the REPL
run: all
	java -cp $(OUT_DIR) $(MAIN_CLASS) $(FILE)

# Clean compiled files
clean:
	rm -rf $(OUT_DIR)

.PHONY: all run clean ast 