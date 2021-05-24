%{
// // // // // // // // // // // // // // // // // // // // // // // 
// CS445 - Scanner for c- Compiler
//
// Connor Williams
// Jan 24, 2021    

#include "scanType.h"  // TokenData Type
#include "ourGetOpt.h"
#include "tree.h"
#include <stdio.h>
#include <string.h>
#include "symbolTable.h"
#include "semantic.h"
extern int yylex();
extern FILE *yyin;
extern int line;         // ERR line number from the scanner!!
extern int numErrors;    // ERR err count
extern int numWarnings;
bool semanticDebugging = false;
TreeNode *syntaxTree;
SymbolTable *symbolTable;
#define YYERROR_VERBOSE
void yyerror(const char *msg)
{
    printf("ERROR(%d): %s\n", line, msg);
    numErrors++;
}

%}

// this is included in the tab.h file
// so scanType.h must be included before the tab.h file!!!!
%union {
    TokenData *tokenData;
    TreeNode *treeNode;
    ExpType type;
}

%token <tokenData> STATIC INT BOOL CHAR IF THEN ELSE WHILE DO FOR TO BY RETURN BREAK
%token <tokenData> OR AND NOT GEQ LEQ EQ NEQ MAX MIN ADDASS SUBASS MULASS DIVASS
%token <tokenData> INC DEC CHARCONST ID NUMCONST STRINGCONST BOOLCONST TRUE FALSE CHSIGN SIZEOF
%token <tokenData> '>' '<' '+' '-' '*' '/' '%' '{' '}' '(' ')' '[' ']' ';' '=' ':' ',' '?'
%type <tokenData> sumop unaryop relop minmaxop mulop
%type <treeNode> decList decl varDecl scopedVarDecl varDeclList varDeclInit varDeclId funDecl
%type <treeNode> parms parmList parmTypeList parmIdList parmId sumExp mulExp unaryExp stmt expStmt
%type <treeNode> compoundStmt stmtList otherStmt localDecls selectStmt matched unmatched iterRange
%type <treeNode> returnStmt breakStmt exp simpleExp andExp unaryRelExp relExp minmaxExp mutable
%type <treeNode> immutable call args argList factor constant
%type <type> typeSpec
%%
program             : decList {syntaxTree = $1;}
                    ;

decList             : decList decl {$$ = setSibling($1, $2);}
                    | decl {$$ = $1;}
                    ;

decl                : varDecl {$$ = $1;}
                    | funDecl {$$ = $1;}
                    ;
/*----------------------------------------------------------*/
varDecl             : typeSpec varDeclList ';' {$$ = setNodeType($1, $2, false);}
                    ;

scopedVarDecl       : STATIC typeSpec varDeclList ';' {setScoped($3); $$ = setNodeType($2, $3, true);}
                    | typeSpec varDeclList ';' {setScoped($2); $$ = setNodeType($1, $2, false);} 
                    ;

varDeclList         : varDeclList ',' varDeclInit {$$ = setSibling($1, $3);}
                    | varDeclInit {$$ = $1;}
                    ;

varDeclInit         : varDeclId {$$ = $1;}
                    | varDeclId ':' simpleExp {$1->child[0] = $3; $1->isInitialized = true; $$ = $1;}
                    ;

varDeclId           : ID {$$ = newDeclNode(VarDeclK, Void, $1, NULL, NULL, NULL, false);}
                    | ID '[' NUMCONST ']' {$$ = newDeclNode(VarDeclK, Void, $1, NULL, NULL, NULL, true);}
                    ;

typeSpec            : INT {$$ = Integer;}
                    | BOOL {$$ = Boolean;}
                    | CHAR {$$ = Char;}
                    ;
/*----------------------------------------------------------*/
funDecl             : typeSpec ID '(' parms ')' stmt {$$ = newDeclNode(FuncDeclK, $1, $2, $4, $6, NULL, false);}
                    | ID '(' parms ')' stmt {$$ = newDeclNode(FuncDeclK, Void, $1, $3, $5, NULL, false);}
                    ; 

parms               : parmList {$$ = $1;}
                    | {$$ = NULL;}
                    ;

parmList            : parmList ';' parmTypeList {$$ = setSibling($1, $3);}
                    | parmTypeList {$$ = $1;}
                    ;

parmTypeList        : typeSpec parmIdList {setScoped($2); $$ = setNodeType($1, $2, false);}
                    ;

parmIdList          : parmIdList ',' parmId {$$ = setSibling($1, $3);}
                    | parmId {$$=$1;}
                    ;

parmId              : ID {$$ = newDeclNode(ParmK, Void, $1, NULL, NULL, NULL, false);}
                    | ID '['']' {$$ = newDeclNode(ParmK, Void, $1, NULL, NULL, NULL, true);}
                    ;
/*----------------------------------------------------------*/
stmt                : selectStmt {$$ = $1;}
                    ;

expStmt             : exp ';'{$$ = $1;}
                    | ';' {$$ = NULL;}
                    ;

compoundStmt        : '{' localDecls stmtList '}' {$$ = newStmtNode(CompoundK, $1, NULL, $2, $3, NULL);}
                    ;  

stmtList            : stmtList stmt {$$ = setSibling($1, $2);}
                    | {$$ = NULL;}
                    ;

otherStmt           : compoundStmt {$$ = $1;}
                    | expStmt {$$ = $1;}
                    | returnStmt {$$ = $1;}
                    | breakStmt {$$ = $1;}
                    ;     

localDecls          : localDecls scopedVarDecl {$$ = setSibling($1, $2);}
                    | {$$ = NULL;}
                    ;

selectStmt          : matched {$$ = $1;}
                    | unmatched {$$ = $1;}
                    ;
                
matched             : IF simpleExp THEN matched ELSE matched {$$ = newStmtNode(IfK, $1, NULL, $2, $4, $6);}
                    | otherStmt {$$ = $1;}
                    | WHILE simpleExp DO matched {$$ = newStmtNode(WhileK, $1, NULL, $2, $4, NULL);}
                    | FOR ID '=' iterRange DO matched {$$ = newStmtNode(ForK, $1, $2, NULL, $4, $6);}
                    ;

unmatched           : IF simpleExp THEN matched {$$ = newStmtNode(IfK, $1, NULL, $2, $4, NULL);}
                    | IF simpleExp THEN unmatched {$$ = newStmtNode(IfK, $1, NULL, $2, $4, NULL);}
                    | IF simpleExp THEN matched ELSE unmatched {$$ = newStmtNode(IfK, $1, NULL, $2, $4, $6);}
                    | WHILE simpleExp DO unmatched {$$ = newStmtNode(WhileK, $1, NULL, $2, $4, NULL);}
                    | FOR ID '=' iterRange DO unmatched {$$ = newStmtNode(ForK, $1, $2, NULL, $4, $6);}
                    ;
                    
iterRange           : simpleExp TO simpleExp {$$ = newStmtNode(RangeK, $2, NULL, $1, $3, NULL);}
                    | simpleExp TO simpleExp BY simpleExp {$$ = newStmtNode(RangeK, $2, NULL, $1, $3, $5);}
                    ;

returnStmt          : RETURN ';' {$$ = newStmtNode(ReturnK, $1, NULL, NULL, NULL, NULL);}
                    | RETURN exp ';' {$$ = newStmtNode(ReturnK, $1, NULL, $2, NULL, NULL);}
                    ;

breakStmt           : BREAK ';' {$$ = newStmtNode(BreakK, $1, NULL, NULL, NULL, NULL);}
                    ;
/*----------------------------------------------------------*/
exp                 : mutable '=' exp {$$ = newExpNode(AssignK, $2, $1, $3, NULL);}
                    | mutable ADDASS exp {$$ = newExpNode(AssignK, $2, $1, $3, NULL);}
                    | mutable SUBASS exp {$$ = newExpNode(AssignK, $2, $1, $3, NULL);}
                    | mutable MULASS exp {$$ = newExpNode(AssignK, $2, $1, $3, NULL);}
                    | mutable DIVASS exp {$$ = newExpNode(AssignK, $2, $1, $3, NULL);}
                    | mutable INC {$$ = newExpNode(AssignK, $2, $1, NULL, NULL);}
                    | mutable DEC {$$ = newExpNode(AssignK, $2, $1, NULL, NULL);}
                    | simpleExp {$$ = $1;}
                    ;

simpleExp           : simpleExp OR andExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | andExp {$$ = $1;}
                    ;

andExp              : andExp AND unaryRelExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | unaryRelExp {$$ = $1;}
                    ;

unaryRelExp         : NOT unaryRelExp {$$ = newExpNode(OpK, $1, $2, NULL, NULL);}
                    | relExp {$$ = $1;}
                    ;

relExp              : minmaxExp relop minmaxExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | minmaxExp {$$ = $1;}
                    ;

relop               : LEQ {$$ = $1;}
                    | '<' {$$ = $1;}
                    | '>' {$$ = $1;}
                    | GEQ {$$ = $1;}
                    | EQ {$$ = $1;}
                    | NEQ {$$ = $1;}
                    ;

minmaxExp           : minmaxExp minmaxop sumExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | sumExp {$$ = $1;}
                    ;

minmaxop            : MAX {$$ = $1;}
                    | MIN {$$ = $1;}
                    ;

sumExp              : sumExp sumop mulExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | mulExp {$$ = $1;}
                    ;

sumop               : '+' {$$ = $1;}
                    | '-' {$$ = $1;}
                    ;

mulExp              : mulExp mulop unaryExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | unaryExp {$$ = $1;}
                    ;

mulop               : '*' {$$ = $1;}
                    | '/' {$$ = $1;}
                    | '%' {$$ = $1;}
                    ;

unaryExp            : unaryop unaryExp {$$ = newExpNode(OpK, $1, $2, NULL, NULL);}
                    | factor {$$ = $1;}
                    ;

unaryop             : '-' {$$ = changeTokenType($1);}
                    | '*' {$$ = changeTokenType($1);}
                    | '?' {$$ = $1;}
                    ;

factor              : immutable {$$ = $1;}
                    | mutable {$$ = $1;}
                    ;

mutable             : ID {$$ = newExpNode(IdK, $1, NULL, NULL, NULL);}
                    | ID '[' exp ']' {$$ = newExpNode(IdArrK, $2, newExpNode(IdK, $1, NULL, NULL, NULL), $3, NULL);}
                    ;

immutable           : '(' exp ')' {$$ = $2;}
                    | call {$$ = $1;}
                    | constant {$$ = $1;}
                    ;

call                : ID '(' args ')' {$$ = newExpNode(CallK, $1, $3, NULL, NULL);}
                    ;

args                : argList {$$ = $1;}
                    | {$$ = NULL;}
                    ;

argList             : argList ',' exp {$$ = setSibling($1, $3);}
                    | exp {$$ = $1;}
                    ;

constant            : NUMCONST {$$ = newExpNode(ConstantK, $1, NULL, NULL, NULL);}
                    | CHARCONST {$$ = newExpNode(ConstantK, $1, NULL, NULL, NULL);}
                    | STRINGCONST {$$ = newExpNode(ConstantK, $1, NULL, NULL, NULL);}
                    | BOOLCONST {$$ = newExpNode(ConstantK, $1, NULL, NULL, NULL);}
                    ;


%%             
int main(int argc, char **argv)
{
    #ifdef YYDEBUG
    yydebug = 0;
    #endif

    int c;
    extern char *optarg;
    extern int optind;
    int dflg, pflg, Pflg, hflg, Sflg;
    int errflg;
    char *ofile;
    char *infile;
    errflg = dflg = pflg = Pflg = hflg = Sflg= 0;
    ofile = NULL;
    infile = NULL;
    while (1) {

        // hunt for a string of options
        while ((c = ourGetopt(argc, argv, (char *)"dpPo:")) != EOF)
            switch (c) {
                case        'd':
                    dflg = 1;
                    break;
                case        'p':
                    pflg = 1;
                    break;
                case        'P':
                    Pflg = 1;
                    break;
                case        'o':
		            if (ofile) {
		                break;
		            }
                    ofile = strdup(optarg);
                    break;
                case        '?':
                    errflg = 1;
                case        'h':
                    hflg = 1;
                    break;
                case        'S':
                    Sflg = 1;
                    break;
                default:
                    break;
            }

            // report any errors or usage request
            if (errflg) {
                (void)fprintf(stderr, "usage: cmd [-a] [-o <filename>] files...\n");
                exit(2);
            }
            if (hflg) {
                printf("Usage: c- [options] [sourceFile]\n");
            }

            // pick off a nonoption
            if (optind < argc) {
                infile = strdup(argv[optind]);
                optind++;
            }
            else {
                break;
            }
        }
    //if command line arguments were provided, open the file
    if (infile) {
        if ((yyin = fopen(infile, "r"))) {
            // file open successful
        }
        else {
            // failed to open file
            numErrors++;
            printf("ERROR(ARGLIST): source file \"%s\" could not be opened.\n", infile);
            printf("Number of warnings: %d\n", numWarnings);
            printf("Number of errors: %d\n", numErrors);
            exit(1);
        }
    }
    if (dflg == 1)
    {
        //yydebug = 1;
    }
    //parse
    numErrors = 0;
    numWarnings = 0;
    yyparse();
    if (numErrors == 0) {
        if (pflg == 1) {
            printTree(syntaxTree, 0, -1, 0);
        }
        symbolTable = new SymbolTable();
        if (dflg) {
            symbolTable->debug(true);
            semanticDebugging = true;
        }
        else {
            symbolTable->debug(false);
        }
        semanticAnalysis(syntaxTree, symbolTable);
    }
    if (Pflg == 1 && numErrors == 0) {
        PrintTree(syntaxTree, 0, -1, 0);
    }
    printf("Number of warnings: %d\n", numWarnings);
    printf("Number of errors: %d\n", numErrors);
    return 0;
}
