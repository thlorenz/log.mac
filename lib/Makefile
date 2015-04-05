SRCS=$(EXEC).asm ./strlen.asm
OBJS= $(subst .asm,.o, $(SRCS))
EXECS=$(subst .asm,, $(SRCS))

BITS:=32
ifeq ($(BITS),64)
NASM_FMT=elf64
LD_EMM=elf_x86_64
else
NASM_FMT=elf32
LD_EMM=elf_i386
endif

DBGI=dwarf

ifdef STRLEN
	TASK=strlen
else
	TASK=help
endif

all: $(TASK)

gdb: clean $(EXEC)
	gdb -- $(EXEC)

.SUFFIXES: .asm .o
.asm.o:
	@nasm -f $(NASM_FMT) -g -F $(DBGI) $< -o $@

strlen: strlen.o
	@ld -m $(LD_EMM) -o $@ $^

help:
	@echo "Please run make with a task, i.e.: make STRLEN=1"

clean:
	@rm -f $(OBJS) $(EXECS)

.PHONY: all clean gdb
