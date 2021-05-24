/*
* Connor Williams
* 2/4/2021
* treeImp.cpp
*/
/*
* Connor Williams
* 2/4/2021
* treeUtils.c
*/
#include "tree.h"
#include "scanType.h"  // TokenData Type
#include "c-.tab.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "semantic.h"
using namespace std;

extern bool mainDefined;
extern int numErrors;
TreeNode *setNodeType(ExpType type, TreeNode *t, bool isStatic)
{
    TreeNode *temp = t;
    while (temp != NULL)
    {
        temp->expType = type;
        temp->isStatic = isStatic;
        temp = temp->sibling;
    }
    return t;
}
TreeNode *setScoped(TreeNode *t)
{
    TreeNode *temp = t;
    while (temp != NULL)
    {
        temp->isScoped = true;
        temp = temp->sibling;
    }
    return t;
}
//Change token type of unary operators
TokenData *changeTokenType(TokenData *token)
{
    switch(token->tokenclass) {
        case int('-'):
        {
            token->tokenclass = CHSIGN;
            token->tokenstr = strdup("chsign");
            break;
        }
        case int('*'):
        {
            token->tokenclass = SIZEOF;
            token->tokenstr = strdup("sizeof");
            break;
        }
        default:
            break;
    }
    return token;
}
//Sets the sibling attribute of target node to sibling
TreeNode *setSibling(TreeNode *t, TreeNode *s)
{
    if (s == NULL)
    {
        //printf("ERROR(SYSTEM): Add NULL to sibling list\n");
        //exit(1);
    }
    if (t != NULL){
        TreeNode *temp = t;
        while(temp->sibling != NULL) {
            temp = temp->sibling;
        }
        temp->sibling = s;
        return t;
    }
        return s;
}
TreeNode *createNewNode()
{
    //printf("new node\n");
    TreeNode *t = new TreeNode;
    t->sibling = NULL;
    for (int i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
    return t;
}
TreeNode *newDeclNode(DeclKind kind, ExpType type, TokenData *id, TreeNode *c1, TreeNode *c2, TreeNode *c3, bool isArray)
{
    TreeNode *t = createNewNode();
    t->expType = type;
    t->nodekind = DeclK;
    t->kind.DeclK = kind;
    t->lineno = id->linenum;
    t->isArray = isArray;
    t->isScoped = false;
    t->isUsed = false;
    t->isInitialized = false;
    t->size = 1;
    t->offset = 0;
    t->nodeMemType = None;
    t->parentIsIdArrK = false;
    if (kind == VarDeclK) {
       t->printInitializedWarning = true; 
    }
    else {
        t->printInitializedWarning = false;
    }
    t->attr.name = strdup(id->tokenstr);
    if (kind == FuncDeclK) {
        t->hasReturnStmt = false;
        if (strcmp(id->tokenstr, "main") == 0) {
            if (c1 == NULL) {
                mainDefined = true;
            }
        }
    }
    t->child[0] = c1;
    t->child[1] = c2;
    t->child[2] = c3;
    return t;
}
//creates new statement node
TreeNode *newStmtNode(StmtKind kind, TokenData *beginStmt, TokenData *id, TreeNode *c1, TreeNode *c2, TreeNode *c3)
{
    TreeNode *t = createNewNode();
    t->parentIsIdArrK = false;
    t->nodekind = StmtK;
    t->kind.StmtK = kind;
    t->lineno = beginStmt->linenum;
    t->child[0] = c1;
    t->child[1] = c2;
    t->child[2] = c3;
    if (kind == ForK) {
        t->child[0] = newDeclNode(VarDeclK, Integer, id, NULL, NULL, NULL, false);
        t->child[0]->isInitialized = true;
    }
    else if (kind == ReturnK) {
        if (c1 != NULL) {
            t->expType = c1->expType;
        }
        else {
            t->expType = Void;
        }
            
    }
    return t;

}
//new expression node
TreeNode *newExpNode(ExpKind kind, TokenData *Op, TreeNode *c1, TreeNode *c2, TreeNode *c3)
{
    TreeNode *t = createNewNode();
    t->nodekind = ExpK;
    t->kind.ExpK = kind;
    t->parentIsIdArrK = false;
    t->lineno = Op->linenum;
    t->expType = Undefined;
    t->isArray = false;
    t->child[0] = c1;
    t->child[1] = c2;
    t->child[2] = c3;
    if(kind == IdArrK) {
        t->attr.op = Op->tokenclass;
        t->OpStr = strdup(Op->tokenstr);
        c1->isArray = true;
    }
    if(kind == AssignK || kind == OpK) {
        t->attr.op = Op->tokenclass;
        t->OpStr = strdup(Op->tokenstr);

    } 
    else if (kind == IdK || kind == CallK) {
        t->attr.name = strdup(Op->tokenstr);
    }
    else if (kind == ConstantK) {
        switch (Op->tokenclass) {
            case NUMCONST:
            {
                t->expType = Integer;
                t->attr.value = Op->numValue;
                break;
            }
            case CHARCONST:
            {
                t->expType = Char;
                t->attr.cvalue = Op->numValue;
                break;
            }
            case STRINGCONST:
            {   
                t->expType = Char;
                t->isArray = true;
                t->attr.string = strdup(Op->processedStr);
                break;
            }
            case BOOLCONST:
            {
                t->expType = Boolean;
                t->attr.value = Op->numValue;
                break;
            }
            default:
            {
                //printf("broke\n");
                break;
            }
        }
    }
    return t;
}
//prints abstract syntax tree
void printTree(TreeNode *t, int level, int childNo, int siblingNo)
{
    for (int i = 0; i < level; i++)
    {
        printf(".   ");
    }
    if (childNo > -1) {
        printf("Child: %d ", childNo);
    } else if (siblingNo > 0) {
        printf("Sibling: %d ", siblingNo);
    }
    printThisNode(t);

    level++;
    if (t->child[0] != NULL) {
        printTree(t->child[0], level, 0, 0);
    }
    if (t->child[1] != NULL) {
        printTree(t->child[1], level, 1, 0);
    }
    if (t->child[2] != NULL) {
        printTree(t->child[2], level, 2, 0);
    }
    level--;
    if (t->sibling != NULL) {
        printTree(t->sibling, level, -1, ++siblingNo);
    }
    return;
}
//prints abstract syntax tree with more type information from semantic analysis
void PrintTree(TreeNode *t, int level, int childNo, int siblingNo, bool printMemInfo)
{
    for (int i = 0; i < level; i++)
    {
        printf(".   ");
    }
    if (childNo > -1) {
        printf("Child: %d ", childNo);
    } else if (siblingNo > 0) {
        printf("Sibling: %d ", siblingNo);
    }
    PrintThisNode(t, printMemInfo);

    level++;
    if (t->child[0] != NULL) {
        PrintTree(t->child[0], level, 0, 0, printMemInfo);
    }
    if (t->child[1] != NULL) {
        PrintTree(t->child[1], level, 1, 0, printMemInfo);
    }
    if (t->child[2] != NULL) {
        PrintTree(t->child[2], level, 2, 0, printMemInfo);
    }
    level--;
    if (t->sibling != NULL) {
        PrintTree(t->sibling, level, -1, ++siblingNo, printMemInfo);
    }
    return;
}
//Prints abstract syntax tree
void printThisNode(TreeNode *t)
{
    if (t->nodekind == DeclK) {
        switch(t->kind.DeclK)
        {
            case VarDeclK:
            {   
                if (t->isArray == true) {
                    printf("Var: %s is array of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                } else {
                    printf("Var: %s of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                }
                break;
            }
            case FuncDeclK:
            {
                printf("Func: %s returns type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                break;
            }
            case ParmK:
            {
                if (t->isArray == true) {
                    printf("Parm: %s is array of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                }
                else {
                    printf("Parm: %s of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                }
                break;
            }
            default :
            {
                //printf("broke\n");
                break;
            }
        }
    }
    else if(t->nodekind == StmtK) {
        switch (t->kind.StmtK)
        {
            case CompoundK:
            {
                printf("Compound [line: %d]\n", t->lineno);
                break;
            }
            case IfK:
            {
                printf("If [line: %d]\n", t->lineno);
                break;
            }
            case WhileK:
            {
                printf("While [line: %d]\n", t->lineno);
                break;
            }
            case ForK:
            {
                printf("For [line: %d]\n", t->lineno);
                break;
            }
            case ReturnK:
            {
                printf("Return [line: %d]\n", t->lineno);
                break;
            }
            case BreakK:
            {
                printf("Break [line: %d]\n", t->lineno);
                break;
            }
            case RangeK:
            {
                printf("Range [line: %d]\n", t->lineno);
                break;
            }
            default:
            {
                //printf("broke\n");
                break;
            }

        }
    }
    else if(t->nodekind == ExpK) {
        switch(t->kind.ExpK)
        {
            case AssignK:
            {
                printf("Assign: %s [line: %d]\n", getOpKind(t->attr.op), t->lineno);
                break;
            }
            case OpK:
            {
                printf("Op: %s [line: %d]\n", getOpKind(t->attr.op), t->lineno);
                break;
            }
            case IdK:
            {
                printf("Id: %s [line: %d]\n", t->attr.name, t->lineno);
                break;
            }
            case IdArrK:
            {
                printf("Op: %s [line: %d]\n", t->OpStr, t->lineno);
                break;
            }
            case ConstantK:
            {
                if (t->expType == Boolean) {
                    printf("Const of type %s: %s [line: %d]\n", getTypeName(t->expType), getBoolVal(t->attr.value), t->lineno);
                } else if (t->expType == Integer) {
                    printf("Const of type %s: %d [line: %d]\n", getTypeName(t->expType), t->attr.value, t->lineno);
                } else if (t->expType == Char) {
                    if (t->isArray == true) {
                         printf("Const is array of type %s: %s [line: %d]\n", getTypeName(t->expType), t->attr.string, t->lineno);
                    } else {
                        printf("Const of type %s: '%c' [line: %d]\n", getTypeName(t->expType), t->attr.cvalue, t->lineno);
                    }
                    }
                break;
            }
            case CallK:
            {
                printf("Call: %s [line: %d]\n", t->attr.name, t->lineno);
                break;
            }
            default: 
            {
                //printf("broke\n");
                break;
            }
        }
    }
    else {
        //do nothing
    }
    return;
}
//prints abstract syntax tree with more type information from semantic analysis
void PrintThisNode(TreeNode *t, bool printMemInfo)
{
    if (t->nodekind == DeclK) {
        switch(t->kind.DeclK)
        {
            case VarDeclK:
            {   
                if (t->isArray == true) {
                    if (printMemInfo) {
                        if (t->isStatic == true) {
                            printf("Var: %s of static array of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                            break;
                        }
                        printf("Var: %s of array of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);

                    }
                    else {
                        printf("Var: %s is array of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                    }
                } else {
                    if (printMemInfo) {
                        if (t->isStatic == true) {
                            printf("Var: %s of static type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                            break;
                        }
                        printf("Var: %s of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                    }
                    else {
                        printf("Var: %s  type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                    }
                }
                break;
            }
            case FuncDeclK:
            {
                if (printMemInfo) {
                    printf("Func: %s returns type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                }
                else {
                    printf("Func: %s returns type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                }
                break;
            }
            case ParmK:
            {
                if (t->isArray == true) {
                    if (printMemInfo) {
                        printf("Parm: %s of array of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                    }
                    else {
                        printf("Parm: %s is array of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                    }
                }
                else {
                    if (printMemInfo) {
                        printf("Parm: %s of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                    }
                    else {
                        printf("Parm: %s of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                    }
                }
                break;
            }
            default :
            {
                //printf("broke\n");
                break;
            }
        }
    }
    else if(t->nodekind == StmtK) {
        switch (t->kind.StmtK)
        {
            case CompoundK:
            {
                if (printMemInfo) {
                    printf("Compound [mem: %s loc: %d size: %d] [line: %d]\n", getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                }
                else {
                    printf("Compound [line: %d]\n", t->lineno);
                }
                break;
            }
            case IfK:
            {
                printf("If [line: %d]\n", t->lineno);
                break;
            }
            case WhileK:
            {
                printf("While [line: %d]\n", t->lineno);
                break;
            }
            case ForK:
            {
                if (printMemInfo) {
                    printf("For [mem: %s loc: %d size: %d] [line: %d]\n", getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                }
                else {
                    printf("For [line: %d]\n", t->lineno);
                }
                break;
            }
            case ReturnK:
            {
                printf("Return [line: %d]\n", t->lineno);
                break;
            }
            case BreakK:
            {
                printf("Break [line: %d]\n", t->lineno);
                break;
            }
            case RangeK:
            {
                printf("Range [line: %d]\n", t->lineno);
                break;
            }
            default:
            {
                //printf("broke\n");
                break;
            }

        }
    }
    else if(t->nodekind == ExpK) {
        switch(t->kind.ExpK)
        {
            case AssignK:
            {
                if (t->child[1] != NULL) {
                    if (t->child[1]->expType == Char) {
                        if (t->child[1]->isArray == true) {
                            printf("Assign: %s of array of type %s [line: %d]\n", getOpKind(t->attr.op), getTypeName(t->expType), t->lineno);
                            break;
                        }
                    }
                }
                printf("Assign: %s of type %s [line: %d]\n", getOpKind(t->attr.op), getTypeName(t->expType), t->lineno);
                break;
            }
            case OpK:
            {
                if (t->expType == Undefined) {
                    printf("Op: %s of undefined type [line: %d]\n", getOpKind(t->attr.op), t->lineno);
                }
                else {
                    printf("Op: %s of type %s [line: %d]\n", getOpKind(t->attr.op), getTypeName(t->expType), t->lineno);
                }
                break;
            }
            case IdK:
            {
                if (t->expType == Undefined) {
                    printf("Id: %s of undefined type [line: %d]\n", t->attr.name, t->lineno);
                }
                else {
                    if (printMemInfo) {

                        if (t->isArray == true) {
                            if (t->isStatic == true) {
                                printf("Id: %s of static array of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                                break;
                            }
                            else {
                                printf("Id: %s of array of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                                break;
                            }

                        }
                        if (t->isStatic == true) {
                            printf("Id: %s of static type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                            break;
                        }
                        printf("Id: %s of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.name, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                    }
                    else {
                        printf("Id: %s of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                    }

                }
                break;
            }
            case IdArrK:
            {
                if (t->expType == Undefined) {
                    printf("Op: %s of undefined type [line: %d]\n", getOpKind(t->attr.op), t->lineno);
                }
                else {
                    printf("Op: %s of type %s [line: %d]\n", getOpKind(t->attr.op), getTypeName(t->expType), t->lineno);
                }
                break;
            }
            case ConstantK:
            {
                if (t->expType == Boolean) {
                    printf("Const %s of type %s [line: %d]\n", getBoolVal(t->attr.value), getTypeName(t->expType), t->lineno);
                } else if (t->expType == Integer) {
                    printf("Const %d of type %s [line: %d]\n", t->attr.value, getTypeName(t->expType), t->lineno);
                } else if (t->expType == Char) {
                    if (t->isArray == true) {
                        if (printMemInfo) {
                            printf("Const  %s of array of type %s [mem: %s loc: %d size: %d] [line: %d]\n", t->attr.string, getTypeName(t->expType), getMemType(t->nodeMemType), t->offset, t->size, t->lineno);
                        }
                        else {
                            printf("Const is array %s of type %s [line: %d]\n", t->attr.string, getTypeName(t->expType), t->lineno);
                        }
                    } else {
                        printf("Const '%c' of type %s [line: %d]\n", t->attr.cvalue, getTypeName(t->expType), t->lineno);
                    }
                }
                break;
            }
            case CallK:
            {
                printf("Call: %s of type %s [line: %d]\n", t->attr.name, getTypeName(t->expType), t->lineno);
                break;
            }
            default: 
            {
                //printf("broke\n");
                break;
            }
        }
    }
    else {
        //do nothing
    }
    return;
}
//returns type name as a string
char* getTypeName(ExpType type)
{
    char *typeName;
    switch (type)
    {
        case Void:
        {
            typeName = strdup("void");
            break;
        }
        case Integer:
        {
            typeName = strdup("int");
            break;
        }
        case Boolean:
        {
            typeName = strdup("bool");
            break;
        }
        case Char:
        {
            typeName = strdup("char");
            break;
        }
        case String:
        {
            typeName = strdup("string");
            break;
        }
        case Undefined:
        {
            typeName = strdup("undefined");
            break;
        }
        case Array:
        {
            typeName = strdup("array");
            break;
        }
        default: 
        {
            //printf("broke\n");
            break;
        }
    }
    return typeName;
}
char* getOpKind(OpKind op)
{
    char *OpStr;
    switch(op)
    {
        case OR:
        {
            OpStr = strdup("or");
            break;
        }
        case AND:
        {
            OpStr = strdup("and");
            break;
        }
        case NOT:
        {
            OpStr = strdup("not");
            break;
        }
        case EQ:
        {
            OpStr = strdup("==");
            break;
        }
        case GEQ:
        {
            OpStr = strdup(">=");
            break;
        }
        case LEQ:
        {
            OpStr = strdup("<=");
            break;
        }
        case NEQ:
        {
            OpStr = strdup("!=");
            break;
        }
        case MAX:
        {
            OpStr = strdup(":>:");
            break;
        }
        case MIN:
        {
            OpStr = strdup(":<:");
            break;
        }
        case int('='):
        {
            OpStr = strdup("=");
            break;
        }
        case ADDASS:
        {
            OpStr = strdup("+=");
            break;
        }
        case SUBASS:
        {
            OpStr = strdup("-=");
            break;
        }
        case MULASS:
        {
            OpStr = strdup("*=");
            break;
        }
        case DIVASS:
        {
            OpStr = strdup("/=");
            break;
        }
        case INC:
        {
            OpStr = strdup("++");
            break;
        }
        case DEC:
        {
            OpStr = strdup("--");
            break;
        }
        case CHSIGN:
        {
            OpStr = strdup("chsign");
            break;
        }
        case SIZEOF:
        {
            OpStr = strdup("sizeof");
            break;
        }
        case int('>'):
        {
            OpStr = strdup(">");
            break;
        }
        case int('<'):
        {
            OpStr = strdup("<");
            break;
        }
        case int('+'):
        {
            OpStr = strdup("+");
            break;
        }
        case int('-'):
        {
            OpStr = strdup("-");
            break;
        }
        case int('*'):
        {
            OpStr = strdup("*");
            break;
        }
            case int('/'):
        {
            OpStr = strdup("/");
            break;
        }
        case int('%'):
        {
            OpStr = strdup("%");
            break;
        }
        case int('?'):
        {
            OpStr = strdup("?");
            break;
        }
        case int('['):
        {
            OpStr = strdup("[");
            break;
        }
        default:
        {
            OpStr = strdup("Unknown Operator");
            break;
        }
    }
    return OpStr;
}
//returns value of bool as a string
char* getBoolVal(int boolVal)
{
    if (boolVal == 1) {
        return strdup("true");
    }
    else {
        return strdup("false");
    }
}
char* getMemType(memType nodeMemType)
{
    char* returnVal = NULL;
    switch (nodeMemType) {
        case Global:
        {
            returnVal = strdup("Global");
            break;
        }
        case Local:
        {
            returnVal = strdup("Local");
            break;
        }
        case LocalStatic:
        {
            returnVal = strdup("LocalStatic");
            break;
        }
        case Parameter:
        {
            returnVal = strdup("Parameter");
            break;
        }
        case None:
        {
            returnVal = strdup("None");
            break;
        }
        default:
        {
            returnVal = strdup("Error in getMemType()");
            break;
        }
    }
    return returnVal;
}
