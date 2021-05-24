#include "semantic.h"
#include "symbolTable.h"
#include "tree.h"
#include "c-.tab.h"
#include <string.h>
#include <string>
int numWarnings;
extern int numErrors;
extern bool semanticDebugging;
bool mainDefined = false;
bool ignoreNextCompound = false;//used to not create duplicate compound statements for functions
bool prevOperation = true;
int loopLevel = 0; //keeps track of the level we are in for loops. Level 0 = not in any loop
bool firstInGlobal = true; // Track what object is the first that is inserted in global scope (to check for if any functions are declared but not used)

void semanticAnalysis(struct TreeNode *syntaxTree, SymbolTable *symbolTable)
{
    /*build IO Library prototypes
        void output(int)
        void outputb(bool)
        void outputc(char)
        int input()
        bool inputb()
        char inputc()
        void outnl()
    */
    struct TokenData* parmId;
    struct TokenData* functionId;
    struct TreeNode* prototypeTreeRoot;
    struct TreeNode* parmNode;
    struct TreeNode* functionNode;
    //build parameter token. All parameters are named "dummy"
    parmId = new TokenData;
    parmId->linenum = -1;
    parmId->tokenstr = strdup("dummy");
    //begin tree construction
    //function void output(int dummy)
    functionId = new TokenData;
    functionId->linenum = -1;
    parmNode = newDeclNode(ParmK, Integer, parmId, NULL, NULL, NULL, false);
    parmNode->isUsed = true;
    functionId->tokenstr = strdup("output");
    functionNode = newDeclNode(FuncDeclK, Void, functionId, parmNode, NULL, NULL, false);
    functionNode->isUsed = true;
    prototypeTreeRoot = functionNode; //set tree's root
    //function void outputb(bool dummy)
    parmNode = newDeclNode(ParmK, Boolean, parmId, NULL, NULL, NULL, false);
    parmNode->isUsed = true;
    functionId->tokenstr = strdup("outputb");
    functionNode->sibling = newDeclNode(FuncDeclK, Void, functionId, parmNode, NULL, NULL, false);
    functionNode->sibling->isUsed = true;
    functionNode = functionNode->sibling;
    //function void outputc(char dummy)
    parmNode = newDeclNode(ParmK, Char, parmId, NULL, NULL, NULL, false);
    parmNode->isUsed = true;
    functionId->tokenstr = strdup("outputc");
    functionNode->sibling = newDeclNode(FuncDeclK, Void, functionId, parmNode, NULL, NULL, false);
    functionNode->sibling->isUsed = true;
    functionNode = functionNode->sibling;
    //function int input()
    functionId->tokenstr = strdup("input");
    functionNode->sibling = newDeclNode(FuncDeclK, Integer, functionId, NULL, NULL, NULL, false);
    functionNode->sibling->isUsed = true;
    functionNode = functionNode->sibling;
    //function bool inputb()
    functionId->tokenstr = strdup("inputb");
    functionNode->sibling = newDeclNode(FuncDeclK, Boolean, functionId, NULL, NULL, NULL, false);
    functionNode->sibling->isUsed = true;
    functionNode = functionNode->sibling;
    //function char inputc()
    functionId->tokenstr = strdup("inputc");
    functionNode->sibling = newDeclNode(FuncDeclK, Char, functionId, NULL, NULL, NULL, false);
    functionNode->sibling->isUsed = true;
    functionNode = functionNode->sibling;
    //function void outnl()
    functionId->tokenstr = strdup("outnl");
    functionNode->sibling = newDeclNode(FuncDeclK, Void, functionId, NULL, NULL, NULL, false);
    functionNode->sibling->isUsed = true;
    functionNode = functionNode->sibling;
    //traverse prototype tree to add all the above function prototypes to the symbol table
    prototypeTraverse(prototypeTreeRoot, symbolTable);
    //traverse program's parse tree
    treeTraverse(syntaxTree, symbolTable, NULL);
    if (mainDefined == false) {
        printf("ERROR(LINKER): A function named 'main' with no parameters must be defined.\n");
        numErrors++;
    }
    return;
}
void prototypeTraverse(struct TreeNode *t, SymbolTable *symbolTable)
{
    if (t != NULL) {
        if (t->nodekind == DeclK) {
            if (t->kind.DeclK == FuncDeclK) {
                symbolTable->insert(t->attr.name, (TreeNode*) t);
            }
        }
        prototypeTraverse(t->sibling, symbolTable);
    }
    return;
}
void treeTraverse(struct TreeNode *t, SymbolTable *symbolTable, TreeNode* currentFuncDecl)
{
    std::string s; //for converting c strings to std strings
    struct TreeNode* temp = NULL;
    struct TreeNode* temp2 = NULL;
    struct operatorTypes* opTypes = NULL;
    ExpType lhsType;
    ExpType rhsType;
    bool rhsIsArray = false; //true if rhs is unindexed array
    bool lhsIsArray = false; //true if lhs is unindexed array
    bool isUnary = false;
    bool isBinary = false;
    bool turnWarningsOn = false; //An error may cause warnings to be turned off for the rest of that statement. This is used to turn them back on.
    bool turnWarningsOn2 = false;
    bool rhsFunctionAsVariable = false;
    bool lhsFunctionAsVariable = false;
    char *scopeName = NULL;
    bool exitScope = false;
    bool isFuncDecl = false;
    bool badVarInit = false;
    bool varRedeclaration = false;
    if (t != NULL) {
        switch (t->nodekind) {
            case DeclK:
            {
                if (t->kind.DeclK == ParmK || t->kind.DeclK == VarDeclK) {
                    if ((symbolTable->insert(t->attr.name, (TreeNode*) t)) == false) {
                        printf("ERROR(%d): Symbol '%s' is already declared at line %d.\n", t->lineno, t->attr.name, ((TreeNode*)symbolTable->lookup(s.assign(t->attr.name)))->lineno);
                        numErrors++;
                        varRedeclaration = true;
                    }
                    if (t->child[0] != NULL) {
                        
                        if (t->kind.DeclK == VarDeclK) {
                            //check initializer
                            if (t->child[0]->kind.ExpK == IdK) {
                                if (rhsConstainsUninitLhs(t, t->child[0], symbolTable) == true) {
                                    if (varRedeclaration == false) {
                                        printf("ERROR(%d): Symbol '%s' is not declared.\n", t->lineno, t->child[0]->attr.name);
                                        numErrors++;
                                        badVarInit = true;
                                    }
                                }
                            }
                            t->isInitialized = true;
                            if (checkConstantExpression(t->child[0]) == false) {
                                printf("ERROR(%d): Initializer for variable '%s' is not a constant expression.\n", t->lineno, t->attr.name);
                                numErrors++;
                            }
                            if (getType(t->child[0], symbolTable) != t->expType && getType(t->child[0], symbolTable) != Undefined) {
                                printf("ERROR(%d): Initializer for variable '%s' of %s is of %s\n", t->lineno, t->attr.name, strcat(strdup("type "), getTypeName(t->expType)), strcat(strdup("type "), getTypeName(getType(t->child[0], symbolTable))));
                                numErrors++;
                            }
                            if (t->isArray == true && t->child[0]->isArray == false) {
                                printf("ERROR(%d): Initializer for variable '%s' requires both operands be arrays or not but variable is%s an array and rhs is%s an array.\n", t->lineno, t->attr.name, "", " not");
                                numErrors++;
                            }
                            if (t->isArray == false && t->child[0]->isArray == true) {
                                printf("ERROR(%d): Initializer for variable '%s' requires both operands be arrays or not but variable is%s an array and rhs is%s an array.\n", t->lineno, t->attr.name, " not", "");
                                numErrors++;
                            }
                        }
                    }
                }
                else if (t->kind.DeclK == FuncDeclK) {
                    if ((symbolTable->insert(t->attr.name, (TreeNode*) t)) == false) {
                        printf("ERROR(%d): Symbol '%s' is already declared at line %d.\n", t->lineno, t->attr.name, ((TreeNode*)symbolTable->lookup(s.assign(t->attr.name)))->lineno);
                        numErrors++;
                        if (strcmp(t->attr.name, "main") == 0) {
                            if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->attr.name))) != NULL) {
                                if (temp->kind.DeclK == ParmK || temp->kind.DeclK == VarDeclK) {
                                    mainDefined = false;
                                }
                            }
                        }              
                    }
                    //if its a function declaration with a single statement (not compound) following, we still need a new scope
                    if (t->kind.DeclK == FuncDeclK) {
                        isFuncDecl = true;
                        currentFuncDecl = t;
                        if (t->child[1] != NULL) {
                            if(t->child[1]->kind.StmtK != CompoundK) {
                                //statement that follows will be a single statement
                                //we have to create the scope now to allow parameters to be added to the function's scope
                                scopeName = (char*)malloc(sizeof(char) * (strlen(t->attr.name) + strlen("FuncScope") + 1));
                                strcat(scopeName, t->attr.name);
                                strcat(scopeName, "FuncScope");
                                symbolTable->enter((std::string) scopeName);
                            }
                            else {
                                //This is a function's main compound statement
                                //we have to create the scope now to allow parameters to be added to the function's scope
                                scopeName = (char*)malloc(sizeof(char) * (strlen(t->attr.name) + strlen("FuncScope(Compound)") + 1));
                                strcat(scopeName, t->attr.name);
                                strcat(scopeName, "FuncScope(Compound)");
                                symbolTable->enter((std::string) scopeName);
                                //Need to know the prev definition was a function so we dont create two compount stmt scopes
                                ignoreNextCompound = true;
                            }
                            exitScope = true;
                        }
                        else {
                            //No statements follow, but still create a scope to add Parms to
                            scopeName = (char*)malloc(sizeof(char) * (strlen(t->attr.name) + strlen("FuncScope") + 1));
                            strcat(scopeName, t->attr.name);
                            strcat(scopeName, "FuncScope");
                            symbolTable->enter((std::string) scopeName);
                            exitScope = true;
                        }
                    }
                    
                }
                
                break;
            }
            case StmtK:
            {
                if (t->kind.StmtK == CompoundK) {

                    if (ignoreNextCompound == true) {
                        //Dont need to do anything because a compound statement scope was created before this point
                        ignoreNextCompound = false;
                    }
                    else {
                        scopeName = (char*)malloc(sizeof(char) * strlen("CompoundScope") + 26);
                        sprintf(scopeName, "%d", t->lineno);
                        strcat(scopeName, "CompoundScope");
                        symbolTable->enter((std::string) scopeName);
                        exitScope = true;
                    }
                    
                }
                else if (t->kind.StmtK == IfK) {
                    if (t->child[0] != NULL) {
                        if (t->child[0]->kind.ExpK == IdK) {
                            if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->attr.name))) != NULL) {
                                if (temp->isArray) {
                                    printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->lineno, "if");
                                    numErrors++;
                                }
                                if (temp->expType != Boolean) {
                                    printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", t->lineno, "if", getTypeName(temp->expType));
                                    numErrors++;
                                }
                            }
                        }
                        else {
                            if (t->child[0]->kind.ExpK == ConstantK) {
                                if (t->child[0]->isArray == true) {
                                    printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->lineno, "if");
                                    numErrors++;
                                }
                            }
                            if (getType(t->child[0], symbolTable) != Boolean) {
                                printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", t->lineno, "if", getTypeName(getType(t->child[0], symbolTable)));
                                numErrors++;
                            }
                        }
                    }
                }
                else if (t->kind.StmtK == ForK) {
                    loopLevel++;
                    if (t->child[2] != NULL) {
                        if (t->child[2]->nodekind == StmtK) {
                            if(t->child[2]->kind.StmtK != CompoundK) {
                                scopeName = (char*)malloc(sizeof(char) * strlen("ForScope") + 26);
                                sprintf(scopeName, "%d", t->lineno);
                                strcat(scopeName, "ForScope");
                                symbolTable->enter((std::string) scopeName);
                                exitScope = true;
                            }
                            else {
                                scopeName = (char*)malloc(sizeof(char) * strlen("ForScope(Compound)") + 26);
                                sprintf(scopeName, "%d", t->lineno);
                                strcat(scopeName, "ForScope(Compound)");
                                symbolTable->enter((std::string) scopeName);
                                ignoreNextCompound = true;
                                exitScope = true;
                            }
                        }
                        else {
                                scopeName = (char*)malloc(sizeof(char) * strlen("ForScope") + 26);
                                sprintf(scopeName, "%d", t->lineno);
                                strcat(scopeName, "ForScope");
                                symbolTable->enter((std::string) scopeName);
                                exitScope = true;
                        }
                    }
                    else {
                        scopeName = (char*)malloc(sizeof(char) * strlen("ForScope") + 26);
                        sprintf(scopeName, "%d", t->lineno);
                        strcat(scopeName, "ForScope");
                        symbolTable->enter((std::string) scopeName);
                        exitScope = true;
                    }
                }
                else if (t->kind.StmtK == WhileK) {
                    loopLevel++;
                    if (t->child[0] != NULL) {
                        if (t->child[0]->kind.ExpK == IdK) {
                            if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->attr.name))) != NULL) {
                                if (temp->isArray) {
                                    printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->lineno, "while");
                                    numErrors++;
                                }
                                if (temp->expType != Boolean) {
                                    printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", t->lineno, "while", getTypeName(temp->expType));
                                    numErrors++;
                                }
                            }
                        }
                        else {
                            if (t->child[0]->kind.ExpK == ConstantK) {
                                if (t->child[0]->isArray == true) {
                                    printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->lineno, "while");
                                    numErrors++;
                                }
                            }
                            if (getType(t->child[0], symbolTable) != Boolean) {
                                printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", t->lineno, "while", getTypeName(getType(t->child[0], symbolTable)));
                                numErrors++;
                            }
                        }
                    }
                }
                else if (t->kind.StmtK == ReturnK) {
                    if (t->child[0] != NULL) {
                        if (t->child[0]->kind.ExpK == IdK) {
                            if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->attr.name))) != NULL) {
                                if(temp->isArray) {
                                    printf("ERROR(%d): Cannot return an array.\n", t->lineno);
                                    numErrors++;
                                }
                            }
                        }
                        else if (t->child[0]->kind.ExpK == AssignK) {
                            if (t->child[0]->child[0]->kind.ExpK == IdK) {
                                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->child[0]->attr.name))) != NULL) {
                                    if (temp->isArray == true) {
                                        printf("ERROR(%d): Cannot return an array.\n", t->lineno);
                                        numErrors++;
                                    }
                                }
                            }
                        }
                        else if (t->child[0]->kind.ExpK == ConstantK) {
                            if (t->child[0]->isArray == true) {
                                printf("ERROR(%d): Cannot return an array.\n", t->lineno);
                                numErrors++;
                            }
                        }
                    }
                    if (currentFuncDecl != NULL) {
                        currentFuncDecl->hasReturnStmt = true;
                        if (currentFuncDecl->expType == Void) {
                            if (t->expType != Void) {
                                printf("ERROR(%d): Function '%s' at line %d is expecting no return value, but return has a value.\n", t->lineno, currentFuncDecl->attr.name, currentFuncDecl->lineno);
                                numErrors++;
                            }
                        }
                        else {
                            if (t->child[0] != NULL) {
                                t->expType = getType(t->child[0], symbolTable);
                            }
                            if (t->child[0] == NULL) {
                                printf("ERROR(%d): Function '%s' at line %d is expecting to return %s but return has no value.\n", t->lineno, currentFuncDecl->attr.name, currentFuncDecl->lineno, strcat(strdup("type "), getTypeName(currentFuncDecl->expType)));
                                numErrors++;
                            }
                            else {
                                t->expType = getType(t->child[0], symbolTable);
                                if (currentFuncDecl->expType != t->expType && t->expType != Undefined) {
                                    printf("ERROR(%d): Function '%s' at line %d is expecting to return %s but returns %s.\n", t->lineno, currentFuncDecl->attr.name, currentFuncDecl->lineno, strcat(strdup("type "), getTypeName(currentFuncDecl->expType)), strcat(strdup("type "), getTypeName(t->expType)));
                                    numErrors++;
                                }
                            }
                        }
                    }
                } else if (t->kind.StmtK == BreakK) {
                    if (loopLevel == 0) {
                        printf("ERROR(%d): Cannot have a break statement outside of loop.\n", t->lineno);
                        numErrors++;
                    }
                } else if (t->kind.StmtK == RangeK) {
                    for (int i = 0; i < 3; i++) {
                        if (t->child[i] != NULL) {
                            if (getType(t->child[i], symbolTable) != Integer && getType(t->child[i], symbolTable) != Undefined) {
                                //!Assignment 4 fix for file rangeifwhile.c-. Expected output doesn't complain about main being void in position 3 of for stmt line 13
                                if (t->child[i]->kind.ExpK == IdK) {
                                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[i]->attr.name))) != NULL) {
                                        if (temp->kind.DeclK != FuncDeclK) {
                                            printf("ERROR(%d): Expecting %s in position %d in range of for statement but got %s.\n", t->lineno, "type int", i+1, strcat(strdup("type "), getTypeName(getType(t->child[i], symbolTable))));
                                            numErrors++;
                                        }
                                    }
                                }
                                else {
                                    printf("ERROR(%d): Expecting %s in position %d in range of for statement but got %s.\n", t->lineno, "type int", i+1, strcat(strdup("type "), getTypeName(getType(t->child[i], symbolTable))));
                                    numErrors++;
                                }
                            }
                            if(t->child[i]->kind.ExpK == IdK) {
                                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[i]->attr.name))) != NULL) {
                                    if (temp->isArray == true) {
                                        printf("ERROR(%d): Cannot use array in position %d in range of for statement.\n", t->lineno, i+1);
                                        numErrors++;
                                    }
                                }   
                            }
                        }
                    }
                }

                break;
            }
            case ExpK:
            {
                if (t->kind.ExpK == CallK) {
                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->attr.name))) != NULL) {
                        temp->isUsed = true;

                        t->expType = temp->expType;
                        if (temp->kind.DeclK == VarDeclK || temp->kind.DeclK == ParmK) {
                            printf("ERROR(%d): '%s' is a simple variable and cannot be called.\n", t->lineno, t->attr.name);
                            numErrors++;
                        }
                        else {
                            //Check parameters for errors
                            struct TreeNode* funcDecl = temp; 
                            struct TreeNode* tempParm = temp->child[0]; //This is for readability
                            struct TreeNode* tempArg = t->child[0]; //This is for readability
                            ExpType argType;

                            int argNum = 0;
                            while(tempParm != NULL)
                            { 
                                argNum++;
                                if (tempArg == NULL) {
                                    printf("ERROR(%d): Too few parameters passed for function '%s' declared on line %d.\n", t->lineno, t->attr.name, temp->lineno);
                                    numErrors++;
                                    break;
                                }
                                else {
                                    if (tempArg->kind.ExpK == IdK) {
                                        if ((temp2 = (TreeNode*)symbolTable->lookup(s.assign(tempArg->attr.name))) != NULL) {
                                            if (tempParm->isArray == true && temp2->isArray == false) {
                                                printf("ERROR(%d): Expecting array in parameter %i of call to '%s' declared on line %d.\n", t->lineno, argNum, t->attr.name, funcDecl->lineno);
                                                numErrors++;
                                            }
                                            if (tempParm->isArray == false && temp2->isArray == true) {
                                                printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' declared on line %d.\n", t->lineno, argNum, t->attr.name, funcDecl->lineno);
                                                numErrors++;
                                            }
                                        }
                                    }
                                    else if (tempArg->kind.ExpK == IdArrK) {
                                        if (tempParm->isArray == true) {
                                            printf("ERROR(%d): Expecting array in parameter %i of call to '%s' declared on line %d.\n", t->lineno, argNum, t->attr.name, funcDecl->lineno);
                                            numErrors++;
                                        }                                        
                                    } else if (tempArg->kind.ExpK == ConstantK) {
                                        if (tempParm->isArray == true && tempArg->isArray == false) {
                                            printf("ERROR(%d): Expecting array in parameter %i of call to '%s' declared on line %d.\n", t->lineno, argNum, t->attr.name, funcDecl->lineno);
                                            numErrors++;
                                        }
                                        if (tempParm->isArray == false && tempArg->isArray == true) {
                                            printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' declared on line %d.\n", t->lineno, argNum, t->attr.name, funcDecl->lineno);
                                            numErrors++;
                                        }
                                    }
                                    else {
                                        if (tempParm->isArray == true) {
                                            printf("ERROR(%d): Expecting array in parameter %i of call to '%s' declared on line %d.\n", t->lineno, argNum, t->attr.name, funcDecl->lineno);
                                            numErrors++;
                                        }                                        
                                    }
                                    argType = getType(tempArg, symbolTable);

                                    if (tempParm->expType != argType && argType != Undefined) {
                                        printf("ERROR(%d): Expecting %s in parameter %i of call to '%s' declared on line %d but got %s.\n", t->lineno, strcat(strdup("type "), getTypeName(tempParm->expType)), argNum, t->attr.name, funcDecl->lineno, strcat(strdup("type "), getTypeName(argType)));
                                        numErrors++;
                                    }
                                    tempParm = tempParm->sibling;
                                    tempArg = tempArg->sibling;
                                }
                            }
                            if (tempArg != NULL) {
                                printf("ERROR(%d): Too many parameters passed for function '%s' declared on line %d.\n", t->lineno, t->attr.name, funcDecl->lineno);
                                numErrors++;
                            }
                        }
                    }
                    else {
                        printf("ERROR(%d): Symbol '%s' is not declared.\n", t->lineno, t->attr.name);
                        numErrors++;
                    }
                }
                if (t->kind.ExpK == IdK) {
                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->attr.name))) != NULL) {
                        temp->isUsed = true;
                        t->expType = temp->expType;
                        if (temp->isInitialized == false) {
                            if (temp->printInitializedWarning == true) {
                                if (temp->kind.DeclK != ParmK && temp->isScoped == true && temp->isStatic == false && temp->kind.DeclK != FuncDeclK) {
                                    printf("WARNING(%d): Variable '%s' may be uninitialized when used here.\n", t->lineno, temp->attr.name);
                                    temp->isInitialized = true;
                                    temp->printInitializedWarning = false;
                                    numWarnings++;
                                }
                            }
                        }
                        if (temp->kind.DeclK == FuncDeclK) {
                            printf("ERROR(%d): Cannot use function '%s' as a variable.\n", t->lineno, temp->attr.name);
                            numErrors++;
                        }
                    }
                    else {
                        printf("ERROR(%d): Symbol '%s' is not declared.\n", t->lineno, t->attr.name);
                        numErrors++;
                    }
                }
                else if (t->kind.ExpK== IdArrK) {
                    lhsType = getType(t->child[0], symbolTable);
                    rhsType = getType(t->child[1], symbolTable);
                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->attr.name))) != NULL) {
                        t->expType = temp->expType;
                        if (temp->isArray == false) {
                            printf("ERROR(%d): Cannot index nonarray '%s'.\n", t->lineno, temp->attr.name);
                            numErrors++;
                        }
                    }
                    else {
                        printf("ERROR(%d): Cannot index nonarray '%s'.\n", t->lineno, t->child[0]->attr.name);
                        numErrors++;
                    }

                    if (t->child[1]->kind.ExpK == IdK || t->child[1]->kind.ExpK == CallK) {
                        if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[1]->attr.name))) != NULL) {
                            if (t->child[1]->kind.ExpK == IdK) {
                                if (temp->isArray == true) {
                                    printf("ERROR(%d): Array index is the unindexed array '%s'.\n", t->lineno, temp->attr.name);
                                    numErrors++;
                                }
                            }
                            if (((temp->kind.DeclK == VarDeclK || temp->kind.DeclK == ParmK) && t->child[1]->kind.ExpK == IdK) || (temp->kind.DeclK == FuncDeclK && t->child[1]->kind.ExpK == CallK)) {
                                if (rhsType != Integer && rhsType != Undefined) {
                                    printf("ERROR(%d): Array '%s' should be indexed by type int but got type %s.\n", t->lineno, t->child[0]->attr.name, getTypeName(rhsType));
                                    numErrors++;
                                }
                            }

                        }
                    } else if (t->child[1]->kind.ExpK == IdArrK) {
                        if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[1]->child[0]->attr.name))) !=NULL) {
                            if (temp->kind.DeclK == VarDeclK || temp->kind.DeclK == ParmK) {
                                if (rhsType != Integer && rhsType != Undefined) {
                                    printf("ERROR(%d): Array '%s' should be indexed by type int but got type %s.\n", t->lineno, t->child[0]->attr.name, getTypeName(rhsType));
                                    numErrors++;
                                }
                            }
                            //!bestworking
                            //turnOffInitializedWarnings(t->child[1], symbolTable);
                            //turnWarningsOn = true;
                        }
                    }
                    else {
                        if (rhsType != Integer && rhsType != Undefined) {
                            printf("ERROR(%d): Array '%s' should be indexed by type int but got type %s.\n", t->lineno, t->child[0]->attr.name, getTypeName(rhsType));
                            numErrors++;
                        }
                    }
                    //!bestworking
                    //turnOffInitializedWarnings(t->child[1], symbolTable);
                    //turnWarningsOn = true;
                }
                else if (t->kind.ExpK == AssignK || t->kind.ExpK == OpK) {
                    prevOperation = true;
                    //!bestworking
                    if (t->attr.op == int('=')) {
                        turnOffInitializedWarnings(t->child[0], symbolTable);
                        turnWarningsOn2 = true;
                    }
                    //get operand and return type information for this operator
                    opTypes = getOperatorTypes(t->attr.op);
                    if (opTypes->isBinary == true && t->child[0] != NULL && t->child[1] != NULL) {
                        isBinary = true;
                        if (t->child[1]->nodekind == ExpK) {
                            if (t->child[1]->kind.ExpK == IdK) {
                                //This operator must be a binary operator.
                                //check if rhs is an unindexed array
                                //set variable as used
                                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[1]->attr.name))) != NULL) {
                                    temp->isUsed = true;
                                    if (temp->isArray == true) {
                                        rhsIsArray = true;
                                    }
                                    //check if rhs is function used as variable
                                    if (temp->kind.DeclK == FuncDeclK) {
                                        rhsFunctionAsVariable = true;
                                    }
                                }
                            }
                            else if (t->child[1]->kind.ExpK == IdArrK) {
                                //set variable as used
                                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[1]->child[0]->attr.name))) != NULL) {
                                    temp->isUsed = true;
                                }
                            }
                            else if (t->child[1]->kind.ExpK == ConstantK) {
                                if (t->child[1]->isArray == true) {
                                    rhsIsArray = true;
                                }
                            }
                        }
                        if (t->child[0]->nodekind == ExpK) {
                            if (t->child[0]->kind.ExpK == IdK) {
                                //check if lhs is an unindexed array 
                                //set variable as initialized if this is an assignment, but first check if lhs variable is the same as rhs variable. If it is, check if rhs is initialized and set lhsrhsSameAndUninitiated flag accordingly
                                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->attr.name))) != NULL) {
                                    if (temp->kind.DeclK == FuncDeclK) {
                                        lhsFunctionAsVariable = true;
                                    }
                                    if (t->kind.ExpK == OpK) {
                                        temp->isUsed = true;
                                    } else if (t->kind.ExpK == AssignK) {

                                        //if  rhs is an identifier
                                        //printf("%d, %s, line: %d\n", t->child[1]->kind.ExpK, t->child[1]->OpStr, t->child[1]->lineno);
                                        if (temp->isInitialized == false) {
                                            if (rhsConstainsUninitLhs(temp, t->child[1], symbolTable) == true) {
                                                temp->isInitialized = false;
                                                temp->printInitializedWarning = true; //!bestworking
                                            }
                                            else {
                                                temp->isInitialized = true;
                                            }
                                        }
                                        if (t->child[1]->kind.ExpK == IdK) {
                                            if (strcmp(temp->attr.name, t->child[1]->attr.name) == 0) {
                                                if ((temp2 = (TreeNode*)symbolTable->lookup(s.assign(t->child[1]->attr.name))) != NULL) {
                                                    if (temp2->kind.DeclK == FuncDeclK) {
                                                        rhsFunctionAsVariable = true;
                                                    }

                                                }                                              
                                            }

                                        }
                                    }
                                    if (temp->isArray == true) {
                                        lhsIsArray = true;
                                    }
                                }
                            }
                            //if lhs is an array
                            else if (t->child[0]->kind.ExpK == IdArrK) {
                                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->child[0]->attr.name))) != NULL) {
                                    if(temp->kind.DeclK == FuncDeclK) {
                                        lhsFunctionAsVariable = true;
                                    }
                                    if (t->kind.ExpK == OpK) {
                                        temp->isUsed = true;
                                    } else if (t->kind.ExpK == AssignK) {
                                        if (temp->isInitialized == false) {
                                            if (rhsConstainsUninitLhs(temp, t->child[1], symbolTable) == true) {
                                                temp->isInitialized = false;
                                                temp->printInitializedWarning = true; //!bestworking
                                            }
                                            else {
                                                temp->isInitialized = true;
                                            }
                                        }
                                    }
                                }
                            }
                            else if (t->child[0]->kind.ExpK == ConstantK) {
                                if (t->child[0]->isArray == true) {
                                    lhsIsArray = true;
                                }
                            }
                        }
                        lhsType = getType(t->child[0], symbolTable);
                        rhsType = getType(t->child[1], symbolTable);
                        //Set this operator's return type
                        if (opTypes->returnType == Undefined) {
                            t->expType = lhsType;
                        } else {
                            t->expType = opTypes->returnType;
                        }
                        //begin error checking for binary operator
                        if (lhsFunctionAsVariable == true) {
                            //printf("ERROR(%d): Cannot use function '%s' as a variable.\n", t->lineno, t->child[0]->attr.name);
                            //numErrors++;
                        }
                        else if (rhsFunctionAsVariable == true) {
                            //printf("ERROR(%d): Cannot use function '%s' as a variable.\n", t->lineno, t->child[1]->attr.name);
                            //numErrors++; 
                        }
                        else {
                            if (opTypes->workWithArray == false && (rhsIsArray || lhsIsArray)) {
                                //operator does not work with array
                                printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->lineno, t->OpStr);
                                numErrors++;
                            }
                            else if (lhsIsArray == true && rhsIsArray == false) {
                                printf("ERROR(%d): '%s' requires both operands be arrays or not but lhs is%s an array and rhs is%s an array.\n", t->lineno, t->OpStr, "", " not");
                                numErrors++;
                            }
                            else if (lhsIsArray == false && rhsIsArray == true) {
                                printf("ERROR(%d): '%s' requires both operands be arrays or not but lhs is%s an array and rhs is%s an array.\n", t->lineno, t->OpStr, " not", "");
                                numErrors++;
                            }
                            if (opTypes->oper1Type != Undefined && opTypes->oper2Type != Undefined) {
                                //operator must be AND, OR, :>:, or :<: since the operand types are not known and not of type "Undefined"
                                if (opTypes->oper1Type != lhsType && lhsType != Undefined) {
                                    printf("ERROR(%d): '%s' requires operands of type %s but lhs is of type %s.\n", t->lineno, t->OpStr, getTypeName(opTypes->oper1Type), getTypeName(lhsType));
                                    numErrors++;
                                }
                                if (opTypes->oper2Type != rhsType && rhsType != Undefined) {
                                    printf("ERROR(%d): '%s' requires operands of type %s but rhs is of type %s.\n", t->lineno, t->OpStr, getTypeName(opTypes->oper1Type), getTypeName(rhsType));
                                    numErrors++;
                                }
                            }
                            else {
                                //operator must be of type <, >,  +=, -=, *=, /= and the types on lhs and rhs must be equal
                                if (rhsType != lhsType && (rhsType != Undefined && lhsType != Undefined)) {
                                    printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", t->lineno, t->OpStr, getTypeName(lhsType), getTypeName(rhsType));
                                    numErrors++;
                                }
                            }
                        }

                    } else {
                        lhsType = getType(t->child[0], symbolTable);
                        isUnary = true;
                        //This operator must be a unary operator
                        //Check if lhs is an array and set as used
                        if (t->child[0] != NULL) {
                            if (t->child[0]->nodekind == ExpK) {
                                if (t->child[0]->kind.ExpK == IdK) {
                                    //check if lhs is an unindexed array
                                    //set variable as used
                                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->attr.name))) != NULL) {
                                        if (temp->kind.DeclK == FuncDeclK) {
                                            lhsFunctionAsVariable = true;
                                        }
                                        temp->isUsed = true;
                                        if (temp->isArray == true) {
                                            lhsIsArray = true;
                                        }
                                    }
                                } else if (t->child[0]->kind.ExpK == IdArrK) {
                                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->child[0]->attr.name))) != NULL) {
                                    temp->isUsed = true;
                                    }

                                } else if (t->child[0]->kind.ExpK == ConstantK) {
                                    if (t->child[0]->isArray == true) {
                                        lhsIsArray = true;
                                    }
                                }
                            }  
                        }
                        //set this operators return type
                        t->expType = opTypes->returnType;
                        //begin error checking for unary operator
                        if (lhsFunctionAsVariable == true) {
                                //printf("ERROR(%d): Cannot use function '%s' as a variable.\n", t->lineno, t->child[0]->attr.name);
                                //numErrors++;
                        }
                        else if (opTypes->workWithArray == false){
                            //operator does not work with array
                            if (lhsIsArray == true) {
                                printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->lineno, t->OpStr);
                                numErrors++;
                            }
                        }
                        else if(t->attr.op == SIZEOF) {
                            if (lhsIsArray != true &&lhsType != Undefined){
                                printf("ERROR(%d): The operation '%s' only works with arrays.\n", t->lineno, t->OpStr);
                                numErrors++;
                            }

                        }
                        if(opTypes->oper1Type != lhsType && lhsType != Undefined && opTypes->oper1Type != Undefined) {
                            printf("ERROR(%d): Unary '%s' requires an operand of type %s but was given type %s.\n", t->lineno, t->OpStr, getTypeName(opTypes->oper1Type), getTypeName(lhsType));
                            numErrors++;
                        }
                    }
                
                }
                break;
            }
            default: 
            {
                printf("ERROR\n");
            
            }
        }
        
        treeTraverse(t->child[0], symbolTable, currentFuncDecl);
        treeTraverse(t->child[1], symbolTable, currentFuncDecl);
        treeTraverse(t->child[2], symbolTable, currentFuncDecl);

        //turn warnings back on
        if (t->nodekind == ExpK) {
            if (turnWarningsOn == true && t->kind.ExpK == IdArrK) {
                turnOnInitializedWarnings(t->child[1], symbolTable);
                turnWarningsOn = false;
            }
            if (turnWarningsOn2 == true) {
                turnOnInitializedWarnings(t->child[0], symbolTable);
            }
        }
        if (exitScope == true)  {
            symbolTable->applyToAll(checkIfUsed);
            symbolTable->leave();
        }
        if (t->nodekind == StmtK) {
            if (t->kind.StmtK == WhileK) {
                loopLevel--;
            }
            else if (t->kind.StmtK == ForK) {
                loopLevel--;
            }
        }
        if (isFuncDecl == true) {
            if (t->expType != Void) {
                if (t->hasReturnStmt == false) {
                    printf("WARNING(%d): Expecting to return %s but function '%s' has no return statement.\n", t->lineno, strcat(strdup("type "), getTypeName(t->expType)), t->attr.name);
                    numWarnings++;
                }
            }
        }
        if (badVarInit == true) {
            t->isUsed = false;
        }
        treeTraverse(t->sibling, symbolTable, currentFuncDecl);
    }
}
bool checkConstantExpression(TreeNode* t) 
{
    if (t != NULL) {
        if (t->kind.ExpK == ConstantK) {
            return true;
        }
        else if (t->kind.ExpK == OpK) {
            if (t->attr.op == CHSIGN || t->attr.op == SIZEOF || t->attr.op == NOT) {
                return checkConstantExpression(t->child[0]);
            }
            else {
                return (checkConstantExpression(t->child[0]) && checkConstantExpression(t->child[1]));
            }
        }
    }
    return false;
}
bool rhsConstainsUninitLhs(TreeNode* lhs, TreeNode* rhs, SymbolTable* symbolTable)
{
    std::string s;
    TreeNode* temp;
    if (rhs != NULL) {
        if (rhs->kind.ExpK == IdK) {
            if ((temp = (TreeNode*)symbolTable->lookup(s.assign(rhs->attr.name))) != NULL) {
                if (strcmp(lhs->attr.name, rhs->attr.name) == 0) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        else if (rhs->kind.ExpK == ConstantK) {
            return false;
        }
        else if (rhs->kind.ExpK == AssignK) {
            return (rhsConstainsUninitLhs(lhs, rhs->child[0], symbolTable) && rhsConstainsUninitLhs(lhs, rhs->child[1], symbolTable));
        }
        else {
            return (rhsConstainsUninitLhs(lhs, rhs->child[0], symbolTable) || rhsConstainsUninitLhs(lhs, rhs->child[1], symbolTable));
        }

    }
    return false;

}
void checkIfUsed(std::string s, void* t) {
    TreeNode* tNode = (TreeNode*) t;
    if (tNode->isUsed == false) {
        if (tNode->kind.DeclK == VarDeclK) {
            printf("WARNING(%d): The variable '%s' seems not to be used.\n", tNode->lineno, tNode->attr.name);
            tNode->isUsed = true;
            numWarnings++;
        }
        else if (tNode->kind.DeclK == FuncDeclK) {
            if (strcmp(tNode->attr.name, "main") != 0) {
                printf("WARNING(%d): The function '%s' seems not to be used.\n", tNode->lineno, tNode->attr.name);
                tNode->isUsed = true;
                numWarnings++;
            }

        }
        else if (tNode->kind.DeclK == ParmK) {
            printf("WARNING(%d): The parameter '%s' seems not to be used.\n", tNode->lineno, tNode->attr.name);
            tNode->isUsed = true;
            numWarnings++;
        }
    }

}
//Gets the type of a node.
ExpType getType(TreeNode *t, SymbolTable *symTable)
{
    operatorTypes* opType = NULL;
    TreeNode* temp = t;
    std::string s;
    if (t->kind.ExpK == OpK || t->kind.ExpK == AssignK) {
        if (t->attr.op == int('=')) {
            if (t->child[0] != NULL) {
                return getType(t->child[0], symTable);
            }
        }
        else {
            opType = getOperatorTypes(t->attr.op);
            return opType->returnType;
        }
    }
    else if (t->kind.ExpK == ConstantK) {
        return (t->expType);
    }
    else if (t->kind.ExpK == IdK) {
        if ((temp = (TreeNode*)symTable->lookup(s.assign(t->attr.name))) != NULL) {
            return (temp->expType);
        }
        else {
            return Undefined;
        }
    }
    else if (t->kind.ExpK == IdArrK) {
        while (temp->kind.ExpK == IdArrK) {
            temp = temp->child[0];
        }
        if ((temp = (TreeNode*)symTable->lookup(s.assign(temp->attr.name))) != NULL) {
            return (temp->expType);
        }
        else {
            return Undefined; 
        }
    }
    else if (t->kind.ExpK == CallK) {
        if ((temp = (TreeNode*)symTable->lookup(s.assign(temp->attr.name))) != NULL) {
            return (temp->expType);
        }
    }
    return Undefined;
}
//Creates a struct that holds operand types and return types for a given operator. This struct may not necessarily be complete, depending on the operator
//Any values set to an undefined type will need to be changed later. Returns struct *.
struct operatorTypes* getOperatorTypes(OpKind op) 
{
    operatorTypes* opTypes = new operatorTypes;
    if (op == ADDASS || op == SUBASS || op == MULASS || op == ADDASS || op == DIVASS || op == MAX || op == MIN || op == int('*') || op == int('/') || op == int('+') || op == int('-') || op == int('%')) {
        opTypes->oper1Type = Integer;
        opTypes->oper2Type = Integer;
        opTypes->returnType = Integer;
        opTypes->arrayOnly = false;
        opTypes->workWithArray = false;
        opTypes->lhsRhsSame = true;
        opTypes->isBinary = true;
    }
    else if (op == int ('=')) {
        opTypes->oper1Type = Undefined;
        opTypes->oper2Type = Undefined;
        opTypes->returnType = Undefined;
        opTypes->arrayOnly = false;
        opTypes->workWithArray = true;
        opTypes->lhsRhsSame = true;
        opTypes->isBinary = true;
    }
    else if (op == EQ || op == NEQ || op == LEQ || op == GEQ || op == int('<') || op == int('>')) {
        opTypes->oper1Type = Undefined;
        opTypes->oper2Type = Undefined;
        opTypes->returnType = Boolean;
        opTypes->arrayOnly = false;
        opTypes->workWithArray = true;
        opTypes->lhsRhsSame = true;
        opTypes->isBinary = true;
    }
    else if (op == DEC || op == INC || op == NOT || op == SIZEOF || op == CHSIGN || op == int('?')) {
        opTypes->oper2Type = Undefined;
        opTypes->oper1Type = Undefined;
        opTypes->arrayOnly = false;
        opTypes->workWithArray = false;
        if(op != NOT) {
            opTypes->returnType = Integer;
            if (op == SIZEOF) {
                opTypes->oper1Type = Undefined;
                opTypes->workWithArray = true;
                opTypes->arrayOnly = true;
            }
            else {
                opTypes->oper1Type = Integer;
            }
        }
        else {
            //operator is NOT
            opTypes->returnType = Boolean;
            opTypes->oper1Type = Boolean;
        }
        //This is how we can distinguish unary operators from binary. All binary ops require both sides to be the same
        opTypes->lhsRhsSame = false;
        opTypes->isBinary = false;
    }
    else if (op == AND || op == OR) {
        opTypes->oper1Type = Boolean;
        opTypes->oper2Type = Boolean;
        opTypes->returnType = Boolean;
        opTypes->arrayOnly = false;
        opTypes->workWithArray = false;
        opTypes->lhsRhsSame = true;
        opTypes->isBinary = true;
    }
    else {
        printf("There was a problem in getOperatorTypes()\n");
    }
    return opTypes;
}

void turnOffInitializedWarnings(TreeNode *t, SymbolTable* symbolTable)
{
    TreeNode* temp = NULL;
    std::string s;
    if (t != NULL) {
        if (t->nodekind == ExpK) {
            if (t->kind.ExpK == IdK) {
                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->attr.name))) != NULL) {
                    temp->printInitializedWarning = false;
                }
            }
        }
        turnOffInitializedWarnings(t->child[0], symbolTable);
        turnOffInitializedWarnings(t->child[1], symbolTable);
        turnOffInitializedWarnings(t->child[2], symbolTable);
    }
}
void turnOnInitializedWarnings(TreeNode *t, SymbolTable* symbolTable)
{
    TreeNode* temp = NULL;
    std::string s;
    if (t != NULL) {
        if (t->nodekind == ExpK) {
            if (t->kind.ExpK == IdK) {
                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->attr.name))) != NULL) {
                    temp->printInitializedWarning = true ;
                }
            }
        }
        turnOnInitializedWarnings(t->child[0], symbolTable);
        turnOnInitializedWarnings(t->child[1], symbolTable);
        turnOnInitializedWarnings(t->child[2], symbolTable);
    }
}