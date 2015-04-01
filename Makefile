# executable is named same as current directory
EXEC=example
SRCS=$(EXEC).asm
OBJS=$(EXEC).o

# dwarf info is more powerful but to start out stabs is good as well
DBGI=dwarf
# DBGI=stabs

all: $(EXEC)

lldb: clean $(EXEC)
	lldb -- $(EXEC)

$(OBJS): $(SRCS)
	@nasm -f elf32 -g -F $(DBGI) $^ 

$(EXEC): $(OBJS)
	@ld -melf_i386 -o $@ $^ 

clean:
	@rm -f $(OBJS) $(EXEC)

.PHONY: all clean lldb
