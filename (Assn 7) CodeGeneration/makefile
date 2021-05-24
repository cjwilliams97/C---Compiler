BIN = c-
CC = g++
treeUtilsOPS = -g -c
parseOPS = -c -g
semanticOPS = -c -g
yyerrorOPS = -c -g
symbolTableOPS = -c -g
codeGenerationOPS = -c -g
emitcodeOPS = -c -g
SRCS = $(BIN).y  $(BIN).l ourGetOpt.cpp treeUtils.cpp semantic.cpp symbolTable.cpp yyerror.cpp codeGeneration.cpp emitcode.cpp
HDRS = scanType.h ourGetOpt.h tree.h semantic.h symbolTable.h yyerror.h codeGeneration.h emitcode.h
OBJS = lex.yy.o $(BIN).tab.o ourGetOpt.o treeUtils.o semantic.o symbolTable.o yyerror.o codeGeneration.o emitcode.o

$(BIN) : $(OBJS)
	$(CC) $(OBJS) -o $(BIN)

symbolTable.o : symbolTable.cpp
		$(CC) $(symbolTableOPS) symbolTable.cpp

treeUtils.o	: treeUtils.cpp
		$(CC) $(treeUtilsOPS) treeUtils.cpp

semantic.o: semantic.cpp
		$(CC) $(semanticOPS) semantic.cpp

yyerror.o : yyerror.cpp
		$(CC) $(yyerrorOPS) yyerror.cpp
		
emitcode.o : emitcode.cpp
		$(CC) $(emitcodeOPS) emitcode.cpp

codeGeneration.o : codeGeneration.cpp
		$(CC) $(codeGenerationOPS) codeGeneration.cpp

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
