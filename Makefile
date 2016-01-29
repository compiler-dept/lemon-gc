BIN = lemon-gc

CFLAGS = -g -Wall -Werror -std=c11
LDFLAGS =
LDLIBS = -lgc
YACC = lemon/lemon

SOURCES = parser.y lemon-gc.c str.c node.c
OBJECTS = $(patsubst %.y, %.o, $(patsubst %.c, %.o, $(SOURCES)))

.PHONY: all valgrind clean lemon

all: $(BIN)

$(BIN): $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

parser.c: parser.y lemon
	$(YACC) $<

valgrind: $(BIN)
	@valgrind --leak-check=full --error-exitcode=1 --suppressions=gc.supp ./$(BIN)

clean:
	rm -f $(BIN) *.o parser.c parser.h parser.out
	rm -rf *.dSYM
	@make -C lemon clean

lemon:
	@make -C lemon
