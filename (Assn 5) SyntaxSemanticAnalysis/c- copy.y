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
#include "yyerror.h"
extern int yylex();
extern FILE *yyin;
extern int line;         // ERR line number from the scanner!!
extern int numErrors;    // ERR err count
extern int numWarnings;
bool semanticDebugging = false;
TreeNode *syntaxTree;
SymbolTable *symbolTable;
#define YYERROR_VERBOSE

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
                    | error   {$$ = NULL;}
                    ;
/*----------------------------------------------------------*/
varDecl             : typeSpec varDeclList ';' {$$ = setNodeType($1, $2, false);}
                    ;

scopedVarDecl       : STATIC typeSpec varDeclList ';' {setScoped($3); $$ = setNodeType($2, $3, true); yyerrok;}
                    | typeSpec varDeclList ';' {setScoped($2); $$ = setNodeType($1, $2, false); yyerrok;} 
                    | error varDeclList {$$ = NULL; yyerrok;}
                    ;

varDeclList         : varDeclList ',' varDeclInit {$$ = setSibling($1, $3); yyerrok;}
                    | varDeclList ',' error {$$ = NULL;}
                    | varDeclInit {$$ = $1;}
                    | error {$$ = NULL;}
                    ;

varDeclInit         : varDeclId {$$ = $1;}
                    | varDeclId ':' simpleExp {$1->child[0] = $3; $1->isInitialized = true; $$ = $1;}
                    | error ':' simpleExp {$$ = NULL;}
                    | varDeclId ':' error {$$ = NULL;}
                    ;

varDeclId           : ID {$$ = newDeclNode(VarDeclK, Void, $1, NULL, NULL, NULL, false);}
                    | ID '[' NUMCONST ']' {$$ = newDeclNode(VarDeclK, Void, $1, NULL, NULL, NULL, true);}
                    | ID '[' error {$$ = NULL;}
                    | error ']' {$$ = NULL; yyerrok;}
                    ;

typeSpec            : INT {$$ = Integer;}
                    | BOOL {$$ = Boolean;}
                    | CHAR {$$ = Char;}
                    ;
/*----------------------------------------------------------*/
funDecl             : typeSpec ID '(' parms ')' stmt {$$ = newDeclNode(FuncDeclK, $1, $2, $4, $6, NULL, false);}
                    | ID '(' parms ')' stmt {$$ = newDeclNode(FuncDeclK, Void, $1, $3, $5, NULL, false);}
                    | typeSpec error {$$ = NULL;}
                    | typeSpec ID '(' error {$$ = NULL;}
                    | typeSpec ID '(' parms ')' error {$$ = NULL;}
                    | ID '(' error {$$ = NULL;}
                    | ID '(' parms ')' error {$$ = NULL;}
                    ; 

parms               : parmList {$$ = $1;}
                    | {$$ = NULL;}
                    ;

parmList            : parmList ';' parmTypeList {$$ = setSibling($1, $3);}
                    | parmTypeList {$$ = $1;}
                    | parmList ';' error {$$ = NULL;}
                    | error {$$ = NULL;}
                    ;

parmTypeList        : typeSpec parmIdList {setScoped($2); $$ = setNodeType($1, $2, false);}
                    | typeSpec error {$$ = NULL;}
                    ;

parmIdList          : parmIdList ',' parmId {$$ = setSibling($1, $3); yyerrok;}
                    | parmId {$$=$1;}
                    | parmIdList ',' error {$$ = NULL;}
                    | error {$$ = NULL;}
                    ;

parmId              : ID {$$ = newDeclNode(ParmK, Void, $1, NULL, NULL, NULL, false);}
                    | ID '['']' {$$ = newDeclNode(ParmK, Void, $1, NULL, NULL, NULL, true);}
                    | error ']' {yyerrok; $$ = NULL;}
                    ;
/*----------------------------------------------------------*/
stmt                : selectStmt {$$ = $1;}
                    ;

expStmt             : exp ';'{$$ = $1; yyerrok;}
                    | ';' {$$ = NULL;}
                    | error ';' {$$ = NULL; yyerrok;}
                    ;

compoundStmt        : '{' localDecls stmtList '}' {$$ = newStmtNode(CompoundK, $1, NULL, $2, $3, NULL);}
                    | '{' localDecls error '}' {$$ = NULL; yyerrok;}
                    | '{' error stmtList '}' {$$ = NULL; yyerrok;}
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
                    | IF error                               {$$ = NULL;}
                    | IF error ELSE matched                  {$$ = NULL; yyerrok;}
                    | IF error ')' matched ELSE matched      {$$ = NULL; yyerrok;}
                    | WHILE error ')' matched                {$$ = NULL; yyerrok;}
                    | WHILE error                            {$$ = NULL;}
                    | FOR error ')' matched                  {$$ = NULL; yyerrok;}
                    | FOR error                              {$$ = NULL;}
                    ;

unmatched           : IF simpleExp THEN matched {$$ = newStmtNode(IfK, $1, NULL, $2, $4, NULL);}
                    | IF simpleExp THEN unmatched {$$ = newStmtNode(IfK, $1, NULL, $2, $4, NULL);}
                    | IF simpleExp THEN matched ELSE unmatched {$$ = newStmtNode(IfK, $1, NULL, $2, $4, $6);}
                    | WHILE simpleExp DO unmatched {$$ = newStmtNode(WhileK, $1, NULL, $2, $4, NULL);}
                    | FOR ID '=' iterRange DO unmatched {$$ = newStmtNode(ForK, $1, $2, NULL, $4, $6);}
                    | IF error ')' stmt                      { $$ = NULL; yyerrok; }
                    | IF error ELSE unmatched                { $$ = NULL; yyerrok; }
                    | IF error ')' matched ELSE unmatched    { $$ = NULL; yyerrok; }
                    | WHILE error ')' unmatched              { $$ = NULL; yyerrok; }
                    | FOR error ')' unmatched                { $$ = NULL; yyerrok; }
                    ;
                    
iterRange           : simpleExp TO simpleExp {$$ = newStmtNode(RangeK, $2, NULL, $1, $3, NULL);}
                    | simpleExp TO simpleExp BY simpleExp {$$ = newStmtNode(RangeK, $2, NULL, $1, $3, $5);}
                    ;

returnStmt          : RETURN ';' {$$ = newStmtNode(ReturnK, $1, NULL, NULL, NULL, NULL);}
                    | RETURN exp ';' {$$ = newStmtNode(ReturnK, $1, NULL, $2, NULL, NULL); yyerrok;}
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
                    | error '=' error {$$ = NULL;}
                    | error ADDASS error {$$ = NULL;}
                    | error SUBASS error {$$ = NULL;}
                    | error MULASS error {$$ = NULL;}
                    | error DIVASS error {$$ = NULL;}
                    | error INC {$$=NULL; yyerrok;}
                    | error DEC {$$=NULL; yyerrok;}
                    ;

simpleExp           : simpleExp OR andExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | simpleExp OR error {$$ = NULL; yyerrok;}
                    | andExp {$$ = $1;}
                    ;

andExp              : andExp AND unaryRelExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | unaryRelExp {$$ = $1;}
                    | andExp AND error {$$ = NULL;}
                    ;

unaryRelExp         : NOT unaryRelExp {$$ = newExpNode(OpK, $1, $2, NULL, NULL);}
                    | relExp {$$ = $1;}
                    | NOT error {$$ = NULL;}
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
                    | sumExp sumop error {$$= NULL; yyerrok;}
                    ;

sumop               : '+' {$$ = $1;}
                    | '-' {$$ = $1;}
                    ;

mulExp              : mulExp mulop unaryExp {$$ = newExpNode(OpK, $2, $1, $3, NULL);}
                    | unaryExp {$$ = $1;}
                    | mulExp mulop error {$$ = NULL;}
                    ;

mulop               : '*' {$$ = $1;}
                    | '/' {$$ = $1;}
                    | '%' {$$ = $1;}
                    ;

unaryExp            : unaryop unaryExp {$$ = newExpNode(OpK, $1, $2, NULL, NULL);}
                    | factor {$$ = $1;}
                    | unaryop error {$$ = NULL;}
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
                    | '(' error                              {$$ = NULL;}
                    | error ')'                              {$$ = NULL; yyerrok;}
                    ;

call                : ID '(' args ')' {$$ = newExpNode(CallK, $1, $3, NULL, NULL);}
                    | error '(' {$$ = NULL; yyerrok;}
                    ;

args                : argList {$$ = $1;}
                    | {$$ = NULL;}
                    ;

argList             : argList ',' exp {$$ = setSibling($1, $3); yyerrok;}
                    | exp {$$ = $1;}
                    | argList ',' error {$$ = NULL;}
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
    initErrorProcessing();
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
        symbolTable->applyToAllGlobal(checkIfUsed);
    }
    if (Pflg == 1 && numErrors == 0) {
        PrintTree(syntaxTree, 0, -1, 0);
    }
    printf("Number of warnings: %d\n", numWarnings);
    printf("Number of errors: %d\n", numErrors);
    return 0;
}
