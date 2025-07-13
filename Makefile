# === mcwCards Makefile ===

# Project Name and Paths
PROJECT := mcwCards
SRC_DIR := src
OBJ_DIR := lib
BIN_DIR := bin
INC_DIR := include

# Compiler
CXX := g++
LD := $(CXX)

# Colors
YELLOW := \033[1;33m
GREEN := \033[1;32m
RED := \033[1;31m
RESET := \033[0m

# Build Type: DEBUG=1 for Debug build
DEBUG ?= 0
ifeq ($(DEBUG), 1)
    CXXFLAGS := -Wall -Wextra -g -DDEBUG -I$(INC_DIR)
    BUILD_MODE := Debug
else
    CXXFLAGS := -Wall -Wextra -O2 -I$(INC_DIR)
    BUILD_MODE := Release
endif

# Linker flags
LDFLAGS := -lncurses

# File discovery
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

# Final binary
TARGET := $(BIN_DIR)/$(PROJECT)

# === Rules ===

all: print_mode $(TARGET)

print_mode:
	@echo -e "$(YELLOW)==> Building $(PROJECT) [$(BUILD_MODE)]$(RESET)"

# Link step
$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	@echo -e "$(GREEN)==> Linking: $@$(RESET)"
	@$(LD) $^ -o $@ $(LDFLAGS)

# Compile step with dependency generation
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	@echo -e "$(GREEN)==> Compiling: $<$(RESET)"
	@$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

# Include dependency files
-include $(DEPS)

# === Utility Targets ===

run: all
	@echo -e "$(YELLOW)==> Running: $(TARGET)$(RESET)"
	@./$(TARGET)

clean:
	@echo -e "$(RED)==> Cleaning project...$(RESET)"
	@rm -rf $(OBJ_DIR)/*.o $(OBJ_DIR)/*.d $(TARGET)

rebuild: clean all

# === PHONY ===
.PHONY: all clean run rebuild print_mode

