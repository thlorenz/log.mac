# executable is named same as current directory
EXEC=x
SRCS=$(EXEC).asm
LIB_STR_SRCS=$(wildcard ./lib/*.asm)

SRCS+=$(LIB_STR_SRCS)
OBJS=$(subst .asm,.o, $(SRCS))

BITS:=32
ifeq ($(BITS),64)
NASM_FMT=elf64
LD_EMM=elf_x86_64
else
NASM_FMT=elf32
LD_EMM=elf_i386
endif

DBGI=dwarf

all: $(EXEC)

gdb: clean $(EXEC)
	gdb -- $(EXEC)

.SUFFIXES: .asm .o
.asm.o:
	@nasm -f $(NASM_FMT) -g -F $(DBGI) $< -o $@

$(EXEC): $(OBJS)
	@ld -m $(LD_EMM) -o $@ $^

clean:
	@rm -f $(OBJS) $(EXEC)

.PHONY: all clean gdb
