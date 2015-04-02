EXEC=x
SRCS=$(EXEC).asm ./strlen.asm
OBJS= $(subst .asm,.o, $(SRCS))

all: $(EXEC)
test: all
	@./$(EXEC)

include ../../common.mk
