BIN = c-
CC = g++
treeUtilsOPS = -g -c
parseOPS = -g -c

SRCS = $(BIN).y  $(BIN).l ourGetOpt.cpp treeUtils.cpp
HDRS = scanType.h ourGetOpt.h tree.h
OBJS = lex.yy.o $(BIN).tab.o ourGetOpt.o treeUtils.o

$(BIN) : $(OBJS)
	$(CC) $(OBJS) -o $(BIN)

treeUtils.o	: treeUtils.cpp
		$(CC) $(treeUtilsOPS) treeUtils.cpp

$(BIN).tab.o	: $(BIN).tab.c
		$(CC) $(parseOPS) $(BIN).tab.c

lex.yy.c : $(BIN).l $(BIN).tab.h $(HDR)
	flex $(BIN).l

$(BIN).tab.h $(BIN).tab.c : $(BIN).y
	bison -v -t -d $(BIN).y

clean :
	rm -f *~ $(OBJS) $(BIN) lex.yy.c $(BIN).tab.h $(BIN).tab.c $(BIN).output

tar : $(HDR) $(SRCS) makefile
	tar -cvf $(BIN).tar $(HDRS) $(SRCS) makefile
