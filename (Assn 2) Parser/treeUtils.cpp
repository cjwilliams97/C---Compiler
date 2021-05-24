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
using namespace std;

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
//Change token type of unary operators
TokenData *changeTokenType(TokenData *token)
{
    switch(token->tokenclass) {
        case int('-'):
        {
            token->tokenclass = CHSIGN;
            token->tokenstr = strdup("CHSIGN");
            break;
        }
        case int('*'):
        {
            token->tokenclass = SIZEOF;
            token->tokenstr = strdup("SIZEOF");
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
        printf("ERROR(SYSTEM): Add NULL to sibling list\n");
        exit(1);
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
    t->nodekind = DeclK;
    t->kind.DeclK = kind;
    t->lineno = id->linenum;
    t->expType = type;
    t->isArray = isArray;
    t->attr.name = strdup(id->tokenstr);
    t->child[0] = c1;
    t->child[1] = c2;
    t->child[2] = c3;
    return t;
}
//creates new statement node
TreeNode *newStmtNode(StmtKind kind, TokenData *beginStmt, TokenData *id, TreeNode *c1, TreeNode *c2, TreeNode *c3)
{
    TreeNode *t = createNewNode();
    t->nodekind = StmtK;
    t->kind.StmtK = kind;
    t->lineno = beginStmt->linenum;
    t->child[0] = c1;
    t->child[1] = c2;
    t->child[2] = c3;
    if (kind == ForK) {
        t->child[0] = newDeclNode(VarDeclK, Integer, id, NULL, NULL, NULL, false);
    }
    return t;

}
//new expression node
TreeNode *newExpNode(ExpKind kind, TokenData *Op, TreeNode *c1, TreeNode *c2, TreeNode *c3)
{
    TreeNode *t = createNewNode();
    t->nodekind = ExpK;
    t->kind.ExpK = kind;
    t->lineno = Op->linenum;
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
                printf("broke\n");
                break;
            }
        }
    }
    return t;
}
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
                printf("broke\n");
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
                printf("broke\n");
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
                printf("broke\n");
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
        default: 
        {
            printf("broke\n");
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
            OpStr = strdup("OR");
            break;
        }
        case AND:
        {
            OpStr = strdup("AND");
            break;
        }
        case NOT:
        {
            OpStr = strdup("NOT");
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
            OpStr = strdup("CHSIGN");
            break;
        }
        case SIZEOF:
        {
            OpStr = strdup("SIZEOF");
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