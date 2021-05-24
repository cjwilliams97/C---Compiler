%{
// // // // // // // // // // // // // // // // // // // // // // // 
// CS445 - Scanner for c- Compiler
//
// Connor Williams
// Jan 24, 2021    

#include "scanType.h"  // TokenData Type
#include <stdio.h>
#include <string.h>

extern int yylex();
extern FILE *yyin;
extern int line;         // ERR line number from the scanner!!
extern int numErrors;    // ERR err count

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
    double value;
}

%token <tokenData> STATIC INT BOOL CHAR IF THEN ELSE WHILE DO FOR TO BY RETURN BREAK
%token <tokenData> OR AND NOT GEQ LEQ EQ NEQ MAX MIN ADDASS SUBASS MULASS
%token <tokenData> DIVASS INC DEC CHARCONST ID NUMCONST STRINGCONST BOOLCONST
%token <tokenData> '>' '<' '+' '-' '*' '/' '%' '{' '}' '(' ')' '[' ']' ';' '=' ':' ',' '?'

%%
tokenlist     : tokenlist token
              | token 
              ;

token   : ID            {printf("Line %d Token: ID Value: %s\n", $1->linenum, $1->tokenstr);}
        | NUMCONST      {printf("Line %d Token: NUMCONST Value: %d Input: %s\n", $1->linenum,$1->numValue, $1->tokenstr);}
        | CHARCONST     {printf("Line %d Token: CHARCONST Value: \'%c\' Input: %s\n", $1->linenum, $1->numValue, $1->tokenstr);}
        | STRINGCONST   {printf("Line %d Token: STRINGCONST Value: %s Len: %d Input: %s\n", $1->linenum, $1->processedStr, int(strlen($1->processedStr) - 2), $1->tokenstr);}
        | STATIC        {printf("Line %d Token: STATIC\n", $1->linenum);}
        | INT           {printf("Line %d Token: INT\n", $1->linenum);}
        | BOOL          {printf("Line %d Token: BOOL\n", $1->linenum);}
        | CHAR          {printf("Line %d Token: CHAR\n", $1->linenum);}
        | IF            {printf("Line %d Token: IF\n", $1->linenum);}
        | THEN          {printf("Line %d Token: THEN\n", $1->linenum);}
        | ELSE          {printf("Line %d Token: ELSE\n", $1->linenum);}
        | WHILE         {printf("Line %d Token: WHILE\n", $1->linenum);}
        | DO            {printf("Line %d Token: DO\n", $1->linenum);}
        | FOR           {printf("Line %d Token: FOR\n", $1->linenum);}
        | TO            {printf("Line %d Token: TO\n", $1->linenum);}
        | BY            {printf("Line %d Token: BY\n", $1->linenum);}
        | RETURN        {printf("Line %d Token: RETURN\n", $1->linenum);}
        | BREAK         {printf("Line %d Token: BREAK\n", $1->linenum);}
        | OR            {printf("Line %d Token: OR\n", $1->linenum);}
        | AND           {printf("Line %d Token: AND\n", $1->linenum);}
        | NOT           {printf("Line %d Token: NOT\n", $1->linenum);}
        | GEQ           {printf("Line %d Token: GEQ\n", $1->linenum);}
        | LEQ           {printf("Line %d Token: LEQ\n", $1->linenum);}
        | EQ            {printf("Line %d Token: EQ\n", $1->linenum);}
        | NEQ           {printf("Line %d Token: NEQ\n", $1->linenum);}
        | MAX           {printf("Line %d Token: MAX\n", $1->linenum);}
        | MIN           {printf("Line %d Token: MIN\n", $1->linenum);}
        | ADDASS        {printf("Line %d Token: ADDASS\n", $1->linenum);}
        | SUBASS        {printf("Line %d Token: SUBASS\n", $1->linenum);}
        | MULASS        {printf("Line %d Token: MULASS\n", $1->linenum);}
        | DIVASS        {printf("Line %d Token: DIVASS\n", $1->linenum);}
        | INC           {printf("Line %d Token: INC\n", $1->linenum);}
        | DEC           {printf("Line %d Token: DEC\n", $1->linenum);}
        | BOOLCONST     {printf("Line %d Token: BOOLCONST Value: %d Input: %s\n", $1->linenum, $1->BoolVal, $1->tokenstr);}
        | '>'           {printf("Line %d Token: >\n", $1->linenum);}
        | '<'           {printf("Line %d Token: <\n", $1->linenum);}
        | '+'           {printf("Line %d Token: +\n", $1->linenum);}             
        | '-'           {printf("Line %d Token: -\n", $1->linenum);}
        | '*'           {printf("Line %d Token: *\n", $1->linenum);}
        | '/'           {printf("Line %d Token: /\n", $1->linenum);}
        | '%'           {printf("Line %d Token: %\n", $1->linenum);}
        | '{'           {printf("Line %d Token: {\n", $1->linenum);}
        | '}'           {printf("Line %d Token: }\n", $1->linenum);}
        | '('           {printf("Line %d Token: (\n", $1->linenum);}
        | ')'           {printf("Line %d Token: )\n", $1->linenum);}
        | '['           {printf("Line %d Token: [\n", $1->linenum);}
        | ']'           {printf("Line %d Token: ]\n", $1->linenum);}
        | ':'           {printf("Line %d Token: :\n", $1->linenum);}
        | ';'           {printf("Line %d Token: ;\n", $1->linenum);}
        | '='           {printf("Line %d Token: =\n", $1->linenum);}
        | ','           {printf("Line %d Token: ,\n", $1->linenum);}
        | '?'           {printf("Line %d Token: ?\n", $1->linenum);}
        ;               

%%             
int main(int argc, char *argv[])
{
    #ifdef YYDEBUG
    yydebug = 0;
    #endif
    //if command line arguments were provided, open the file
    if (argc > 1) {
        if ((yyin = fopen(argv[1], "r"))) {
            // file open successful
        }
        else {
            // failed to open file
            printf("ERROR: failed to open \'%s\'\n", argv[1]);
            exit(1);
        }
    }

    //parse
    numErrors = 0;
    yyparse();

    return 0;
}
