NAME = firmware

# ----- Toolchain --------------------------------------------------------------

TOOLCHAIN_PREFIX = arm-none-eabi-

GCC     = $(TOOLCHAIN_PREFIX)gcc
GDB     = $(TOOLCHAIN_PREFIX)gdb
OBJCOPY = $(TOOLCHAIN_PREFIX)objcopy
SIZE    = $(TOOLCHAIN_PREFIX)size

# ----- Tools ------------------------------------------------------------------

MKDIR = mkdir -p
RMDIR = rm -rf

# ----- Directories and Files --------------------------------------------------

OBJDIR = _obj
OUTDIR = _out
