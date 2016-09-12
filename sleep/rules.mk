# ----- Configuration ---------------------------------------------------------

include rules_config.mk

# ----- Flags -----------------------------------------------------------------

CPPFLAGS += $(addprefix -D,$(SYMBOLS))
CPPFLAGS += $(addprefix -I,$(realpath $(INCLUDE_DIRS)))

LDFLAGS += $(addprefix -L,$(realpath $(LIBRARY_DIRS)))
LDFLAGS += -Wl,-Map=$(OUTPUT_DIR)/$(MAPFILE)

LIBFLAGS = $(addprefix -l,$(LIBRARIES))
# LIBFLAGS = -Wl,--start-group $(addprefix -l, $(LIBRARIES)) -Wl,--end-group

# ----- Objects ---------------------------------------------------------------

SORTED_SOURCE_FILES = $(sort $(realpath $(SOURCE_FILES)))
SORTED_OBJECT_FILES = $(addprefix $(OUTPUT_DIR),$(addsuffix .o,$(basename $(SORTED_SOURCE_FILES))))

# ----- Rules -----------------------------------------------------------------

.PHONY: all clean download

all: $(EXECUTABLE) $(BINARY)
	@echo # New line for better reading
	$(SIZE) $<
	@echo # Another new line for even better reading

clean:
	$(RM) $(OUTPUT_DIR)

download: $(EXECUTABLE)
	$(GDB) -q -x download.gdb $<

$(OUTPUT_DIR)/$(EXECUTABLE): $(SORTED_OBJECT_FILES)
	$(MKDIR) $(dir $@)
	$(GCC) $(GCCFLAGS) $(LDFLAGS) $^ $(LIBFLAGS) -o $@

$(OUTPUT_DIR)/$(BINARY): $(EXECUTABLE)
	$(MKDIR) $(dir $@)
	$(OBJCOPY) -O binary $< $@

$(OUTPUT_DIR)/%.o: /%.c
	$(MKDIR) $(dir $@)
	$(GCC) $(GCCFLAGS) $(COMMON_CFLAGS) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
	@echo "$(subst $(PARENT_DIR),,$^)"

$(OUTPUT_DIR)/%.o: /%.cpp
	$(MKDIR) $(dir $@)
	$(GCC) $(GCCFLAGS) $(COMMON_CFLAGS) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<
	@echo "$(subst $(PARENT_DIR),,$^)"
