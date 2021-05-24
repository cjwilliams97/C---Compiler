%{
// this *order* of these includes is mandatory
#include "scanType.h"  // TokenData Type
#include "tree.h"
#include "c-.tab.h"  // token definitions from the bison

int line = 1;
int numErrors = 0;    // ERR err count

int escapeCount(char* svalue);
char* removeEscapeChars(char* svalue);

static int setValue(int linenum, int tokenClass, char *svalue)
{
    // create the pass-back data space
    yylval.tokenData = new TokenData;
    // fill it up
    yylval.tokenData->tokenclass = tokenClass;
    yylval.tokenData->linenum = linenum;
    yylval.tokenData->tokenstr = strdup(svalue);  // duplicating string!!
    if (tokenClass == NUMCONST) {
        yylval.tokenData->numValue = atoi(svalue);
    }
    else if (tokenClass == CHARCONST) {
        int stringLength = strlen(yylval.tokenData->tokenstr) - 2;
        if (stringLength > 1) {
            if(svalue[1] == '\\') {
                if (svalue[2] == 'n') {
                    yylval.tokenData->numValue = int('\n');
                }
                else if (svalue[2] == '0') {
                    yylval.tokenData->numValue = int('\0');
                }
                else {
                    yylval.tokenData->numValue = svalue[2];
                }
                if(stringLength > 2) {
                    printf("WARNING(%d): character is %d characters long and not a single character: \'%s\'. The first char will be used.\n", linenum, stringLength, svalue);
                }
            }
            else {
                printf("WARNING(%d): character is %d characters long and not a single character: \'%s\'. The first char will be used.\n", linenum, stringLength, svalue);
                yylval.tokenData->numValue = svalue[1];
            }
        }
        else {
            yylval.tokenData->numValue = svalue[1];
        }
    }
    else if (tokenClass == BOOLCONST) {
        if (strcmp(svalue, "false") == 0){
            yylval.tokenData->numValue = 0; //bool is false
        }
        else {
            yylval.tokenData->numValue = 1; //bool must be true
        }
    }
    else if (tokenClass == STRINGCONST) {
        yylval.tokenData->processedStr = removeEscapeChars(strdup(svalue)); //Remove escape characters '\' from string
    }
    
    // return the tokenclass
    return tokenClass;
}
//Takes in a string "This is \n a \" string" and processes/removes escape characters. Returns a new string with escapes removed, containing the value of the escaped
//character
char* removeEscapeChars(char* svalue)
{
    char* processedString = (char*) malloc(strlen(svalue) - escapeCount(svalue) + 1);
    char* r = processedString;
    while(*svalue){
        if (*svalue == '\\') {
            svalue++;
            switch (*svalue) {
                case 'n':
                    *r = '\n';
                    break;
                case '0':
                    *r = '\0';
                    break;
                default:
                    *r = *svalue;
                    break;
            }
        }
        else {
            *r = *svalue;
        }
        if (*svalue) {
            svalue++;
        }
        r++;
    }
    return processedString;

    return processedString;
}
int escapeCount(char* svalue) 
{
    int count = 0;
    while (*svalue){
        if(*svalue == '\\') {
            svalue++;
            count++;
        }
        if(*svalue) {
            svalue++;
        }
    }
    return count;
}

%}
%option noyywrap
%option yylineno
DIGIT               [0-9]
LETTER              [a-zA-Z]
LETDIG              {DIGIT}|{LETTER}
ID                  {LETTER}{LETDIG}*
CHARCONST           '(\\.|[^'\\\n])*'
NUMCONST            {DIGIT}+ 
STRINGCONST         \"(\\.|[^"\\\n])*\"
COMMENT             "//".*\n

%%

static          {return setValue(line, STATIC, yytext);}
int             {return setValue(line, INT, yytext);}
bool            {return setValue(line, BOOL, yytext);}
char            {return setValue(line, CHAR, yytext);}
if              {return setValue(line, IF, yytext);}
then            {return setValue(line, THEN, yytext);}
else            {return setValue(line, ELSE, yytext);}
while           {return setValue(line, WHILE, yytext);}
do              {return setValue(line, DO, yytext);}
for             {return setValue(line, FOR, yytext);}
to              {return setValue(line, TO, yytext);}
by              {return setValue(line, BY, yytext);}
return          {return setValue(line, RETURN, yytext);}
break           {return setValue(line, BREAK, yytext);}
or              {return setValue(line, OR, yytext);}
and             {return setValue(line, AND, yytext);}
not             {return setValue(line, NOT, yytext);}
true            {return setValue(line, BOOLCONST, yytext);}
false           {return setValue(line, BOOLCONST, yytext);}

">="            {return setValue(line, GEQ, yytext);}   
"<="            {return setValue(line, LEQ, yytext);}
">"             {return setValue(line, int('>'), yytext);}
"<"             {return setValue(line, int('<'), yytext);}
"=="            {return setValue(line, EQ, yytext);}
"!="            {return setValue(line, NEQ, yytext);}
":>:"           {return setValue(line, MAX, yytext);}
":<:"           {return setValue(line, MIN, yytext);}
"="             {return setValue(line, int('='), yytext);}
"+="            {return setValue(line, ADDASS, yytext);}
"-="            {return setValue(line, SUBASS, yytext);}  
"*="            {return setValue(line, MULASS, yytext);}
"/="            {return setValue(line, DIVASS, yytext);}
"++"            {return setValue(line, INC, yytext);}
"--"            {return setValue(line, DEC, yytext);}
"+"             {return setValue(line, int('+'), yytext);}
"-"             {return setValue(line, int('-'), yytext);}
"*"             {return setValue(line, int('*'), yytext);}
"/"             {return setValue(line, int('/'), yytext);}
"%"             {return setValue(line, int('%'), yytext);}
"{"             {return setValue(line, int('{'), yytext);}
"}"             {return setValue(line, int('}'), yytext);}
"("             {return setValue(line, int('('), yytext);}
")"             {return setValue(line, int(')'), yytext);}
"["             {return setValue(line, int('['), yytext);}
"]"             {return setValue(line, int(']'), yytext);}
":"             {return setValue(line, int(':'), yytext);}
";"             {return setValue(line, int(';'), yytext);}
","             {return setValue(line, int(','), yytext);}
"?"             {return setValue(line, int('?'), yytext);}
{COMMENT}                               {line++;}
{CHARCONST}                             {return setValue(line, CHARCONST, yytext);}
{ID}                                    {return setValue(line, ID, yytext);}
{NUMCONST}                              {return setValue(line, NUMCONST, yytext);}
{STRINGCONST}                           {return setValue(line, STRINGCONST, yytext);}

[ \t]+                                  /*remove whitespace*/
\n                                      {line++;}
.                                       {printf("ERROR(%d): Invalid or misplaced input character: '%s'. Character Ignored.\n", yylineno, yytext); numErrors++;}

%%
/*
 * This section is the user subroutines section.  It starts after the %% above
 * and continues to the end of the file. Anything appearing in the section is
 * copied verbatim into the lex.yy.c file generated by lex, and will appear
 * toward the bottom of that file.
 *
 * This section is where subroutines specific to a given scanner are placed.
 * Any legal C code can be placed here.
 *
 * The scanner for this application is not intended to be used by yacc, so
 * here we define a main function that will "drive" the lexer.
 */

