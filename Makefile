# executable is named same as current directory
EXEC=x
SRCS=$(EXEC).asm
LIB_STR_SRCS=$(filter-out ./lib/str/x.asm, $(wildcard ./lib/str/*.asm))

SRCS+=$(LIB_STR_SRCS)
OBJS=$(subst .asm,.o, $(SRCS))

all: $(EXEC)

test: all
	@./$(EXEC)

pre_strlen: lib/strlen.asm
	nasm -e -f $(NASM_FMT) -g -F $(DBGI) $< -o $@ > pre_strlen.asm

include ./common.mk
