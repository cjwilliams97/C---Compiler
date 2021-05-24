#include "codeGeneration.h"
#include "emitcode.h"
#include "c-.tab.h"
#include "tree.h"
#include <string.h>
#include <string>
#include <stack>
#include <iostream>
#include "symbolTable.h"
#include "semantic.h"
using namespace std;
extern TreeNode* prototypeTreeRoot;
TreeNode* temp;
TreeNode* temp2;
TreeNode* argTemp;
extern int foffset;
extern int goffset;
extern bool ignoreNextCompound;
int RETURNOFFSET = 0;
int OFPOFF = 0;
int TOFF = 0;
int paramNum = 1;
FILE* code;
int endOfGlobals;
std::stack<int> myLoopStack; //stack of loop locations for break statements
extern std::stack<std::string> scopeStack; //stack of scope names for name mangling local static variables
SymbolTable* globalSymTab;
void generateCode(char* inFile, char* outFileName, TreeNode* syntaxTree, SymbolTable* symbolTable)
{
    code = fopen(outFileName, "w");
    endOfGlobals = goffset;
    globalSymTab = symbolTable;
    emitComment((char*)"C- compiler version C-S21");
    emitComment((char*)"Built: Apr 22, 2021");
    emitComment((char*)"Author: Connor Williams");
    emitComment((char*)"File compiled:", inFile);
    emitComment((char*)"");
    emitSkip(1);
    IO_traverse(prototypeTreeRoot, symbolTable);
    codeGenerationTraverse(syntaxTree, symbolTable);

    generatePrologue(symbolTable);
}

void IO_traverse(TreeNode* t, SymbolTable* symbolTable)
{
    RETURNOFFSET = -1;
    OFPOFF = 0;
    if (t != NULL) {
        if (t->nodekind == DeclK) {
            if (t->kind.DeclK == FuncDeclK) {
                //initial code for function call
                emitComment((char*)"** ** ** ** ** ** ** ** ** ** ** **");
                emitComment((char*)"FUNCTION", t->attr.name);
                temp = (TreeNode*)symbolTable->lookup(t->attr.name);
                temp->memLoc = get_emitLoc();
                emitRM((char*)"ST", AC, RETURNOFFSET, FP, (char*)"Store return address");
                //function body code
                if (strcmp(t->attr.name, "input") == 0) {
                    emitRO((char*)"IN", RT, RT, RT, (char*)"Grab int input");
                } else if (strcmp(t->attr.name, "output") == 0) {
                    emitRM((char*)"LD", AC, -2, FP, (char*)"Load parameter");
                    emitRO((char*)"OUT", AC, AC, AC, (char*)"Output int");
                } else if (strcmp(t->attr.name, "inputb") == 0) {
                    emitRO((char*)"INB", RT, RT, RT, (char*)"Grab bool input");
                } else if (strcmp(t->attr.name, "outputb") == 0) {
                    emitRM((char*)"LD", AC, -2, FP, (char*)"Load parameter");
                    emitRO((char*)"OUTB", AC, AC, AC, (char*)"Output int");
                } else if (strcmp(t->attr.name, "inputc") == 0) {
                    emitRO((char*)"INC", RT, RT, RT, (char*)"Grab char input");
                } else if (strcmp(t->attr.name, "outputc") == 0) {
                    emitRM((char*)"LD", AC, -2, FP, (char*)"Load parameter");
                    emitRO((char*)"OUTC", AC, AC, AC, (char*)"Output int");
                } else if (strcmp(t->attr.name, "outnl") == 0) {
                    emitRO((char*)"OUTNL", AC, AC, AC, (char*)"Output a newLine");
                }
                else {
                    emitComment((char*)"ERROR(LINKER): No support for special function");
                }
                //return code for IO function
                emitRM((char*)"LD", AC, RETURNOFFSET, FP, (char*)"Load return address");
                emitRM((char*)"LD", FP, OFPOFF, FP, (char*)"Adjust fp");
                emitGoto(0, AC, (char*)"Return");

                emitComment((char*)"END FUNCTION", t->attr.name);
                emitComment((char*)"");
            }
        }
        IO_traverse(t->sibling, symbolTable);
    }
    else {
       // printf("is null\n");
    }
}
void codeGenerationTraverse(TreeNode* t, SymbolTable* symbolTable)
{
    std::string s;
    bool exitScope = false;
    struct TreeNode* temp = NULL;
    int backpatchLoc;
    s.assign("globalScope");
    if (t != NULL) {
        //code
        switch (t->nodekind) {
            case DeclK:
            {
                if (t->kind.DeclK == ParmK || t->kind.DeclK == VarDeclK) {
                    //set memory type and assign memory location
                    if (t->kind.DeclK == VarDeclK) //node is variable declaration
                    {
                        if (t->isArray == true) { //variable declaration is an array
                            if (t->nodeMemType == LocalStatic) {
                                //local static
                                //allocate in global memory (goffset)
                                symbolTable->insert(t->attr.name, (TreeNode*) t);
                            }
                            else if (t->nodeMemType == Local) {
                                //allocate in local memory (foffset)
                                symbolTable->insert(t->attr.name, (TreeNode*) t);
                                emitRM((char*)"LDC", AC, t->size - 1, AC3, (char*)"load size of array", t->attr.name);
                                emitRM((char*)"ST", AC, t->offset + 1, FP, (char*)"save size of array", t->attr.name);
                            }
                            else {
                                codeGenerationTraverse(t->sibling, symbolTable);
                                return;
                            }
                        }
                        else { //variable declaration is not an array
                            if (t->nodeMemType == LocalStatic){
                                //local static
                                //allocate in global memory (goffset)
                                //symbolTable->insertGlobal(t->attr.name, (TreeNode*) t);
                                symbolTable->insert(t->attr.name, (TreeNode*) t);
                            }
                            else if (t->nodeMemType == Local) {
                                symbolTable->insert(t->attr.name, (TreeNode*) t);
                                //allocate in local memory (foffset)
                            }
                            else {
                                codeGenerationTraverse(t->sibling, symbolTable);
                                return;
                            }
                        }
                    }
                    else {
                        //node is a parameter
                        symbolTable->insert(t->attr.name, (TreeNode*) t);
                        //allocate in local memory (foffset)
                        foffset -= t->size;
                    }
                }
                else if (t->kind.DeclK == FuncDeclK) {
                    temp = (TreeNode*)symbolTable->lookup(t->attr.name);
                    temp->memLoc = get_emitLoc();
                    foffset = -2;
                    TOFF = temp->size;
                    s = to_string(TOFF);
                    emitComment((char*)"** ** ** ** ** ** ** ** ** ** ** **");
                    emitComment((char*)"FUNCTION", t->attr.name);
                    emitComment((char*)"TOFF set", (char*)s.c_str());
                    emitRM((char*)"ST", AC, -1, FP, (char*)"Store return address");
                    if (t->child[1] != NULL) {
                        if(t->child[1]->kind.StmtK != CompoundK) {
                            //statement that follows will be a single statement
                            //we have to create the scope now to allow parameters to be added to the function's scope
                            s.assign(t->attr.name);
                            s = s + "FuncScope";
                            symbolTable->enter(s);
                            scopeStack.push(s);
                        }
                        else {
                            //This is a function's main compound statement
                            //we have to create the scope now to allow parameters to be added to the function's scope
                            t->savedOffset = TOFF;
                            TOFF = t->child[1]->size;
                            s = to_string(TOFF);
                            emitComment((char*)"COMPOUND");
                            emitComment((char*)"TOFF set:", (char*)s.c_str());
                            emitComment((char*)"Compound Body");
                            s.assign(t->attr.name);
                            s = s + "FuncScope(Compound)";
                            symbolTable->enter(s);
                            scopeStack.push(s);
                            //Need to know the prev definition was a function so we dont create two compound stmt scopes
                            ignoreNextCompound = true;
                            //mem allocation
                        }
                        exitScope = true;
                    }
                    else {
                        //No statements follow, but still create a scope to add Parms to
                        s.assign(t->attr.name);
                        s = s + "FuncScope";
                        symbolTable->enter(s);
                        scopeStack.push(s);
                        exitScope = true;
                    }        
                }
                break;
            }
            case StmtK:
            {
                if (t->kind.StmtK == CompoundK) {
                    if (ignoreNextCompound == true) {
 
                        //Dont need to create a compound scope because it was already created before this point.
                        ignoreNextCompound = false;
                    }
                    else {
                        //allocate memory for compound statement
                        t->savedOffset = TOFF;
                        TOFF = t->size;
                        s = to_string(TOFF);
                        emitComment((char*)"COMPOUND");
                        emitComment((char*)"TOFF set:", (char*)s.c_str());
                        emitComment((char*)"Compound Body");
                        s = to_string(t->lineno);
                        s = s + "CompoundScope";
                        symbolTable->enter(s);
                        scopeStack.push(s);
                        exitScope = true;
                    }
                    
                }
                else if (t->kind.StmtK == IfK) {
                    emitComment((char*)"IF");
                }
                else if (t->kind.StmtK == ForK) {
                    emitComment((char*)"FOR");
                    if (t->child[2] != NULL) {
                        if (t->child[2]->nodekind == StmtK) {
                            if(t->child[2]->kind.StmtK != CompoundK) {
                                t->savedOffset = TOFF;
                                s = to_string(t->lineno);
                                s = s + "ForScope";
                                symbolTable->enter(s);
                                scopeStack.push(s);
                                exitScope = true;
                                //allocate memory for "for" statement
                            }
                            else {
                                t->savedOffset = TOFF;
                                t->child[2]->savedOffset = TOFF;
                                s = to_string(t->lineno);
                                s = s + "ForScope(Compound)";
                                symbolTable->enter(s);
                                scopeStack.push(s);
                                ignoreNextCompound = true;
                                exitScope = true;
                                //allocate memory for "for" statement
                            }
                        }
                        else {
                                t->savedOffset = TOFF;
                                s = to_string(t->lineno);
                                s = s + "ForScope";
                                symbolTable->enter(s);
                                scopeStack.push(s);
                                exitScope = true;
                                //allocate memory for "for" statement
                        }
                    }
                    else {
                        //allocate memory for "for" statement
                        t->savedOffset = TOFF;
                        s = to_string(t->lineno);
                        s = s + "ForScope";
                        symbolTable->enter(s);
                        scopeStack.push(s);
                        exitScope = true;
                    }
                }
                else if (t->kind.StmtK == WhileK) {
                    emitComment((char*)"WHILE");
                    t->memLoc = emitWhereAmI();
                    if (t->child[0] != NULL) {
                        
                    }
                }
                else if (t->kind.StmtK == ReturnK) {
                    emitComment((char*)"RETURN");

                    if (t->child[0] == NULL) {
                    emitComment((char*)"No return value. Return 0");
                    emitRM((char*)"LDC", RT, 0, AC3, (char*)"Set return value to 0");
                    emitRM((char*)"LD", AC, -1, FP, (char*)"Load return address");
                    emitRM((char*)"LD", FP, 0, FP, (char*)"Adjust fp");
                    emitGoto(0, AC, (char*)"Return");
                    }
                } else if (t->kind.StmtK == BreakK) {
                    emitComment((char*)"BREAK");
                    emitGotoAbs(myLoopStack.top() , (char*)"break");
                } else if (t->kind.StmtK == RangeK) {
                    for (int i = 0; i < 3; i++) {
                        if (t->child[i] != NULL) {
                            if(t->child[i]->kind.ExpK == IdK) {
                                if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[i]->attr.name))) != NULL) {

                                }   
                            }
                        }
                    }
                }
                break;
            }
            case ExpK:
            {
                if (t->isCallArg) {
                    s = to_string(paramNum); 
                    emitComment((char*)"Param", (char*)s.c_str());
                    paramNum++;
                }
                if (t->kind.ExpK == CallK) {
                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->attr.name))) != NULL) {
                        t->savedParamNum = paramNum;
                        paramNum = 1;
                        t->savedOffset = TOFF;
                        t->offset = TOFF;
                        //t->offset = TOFF;
                        emitComment((char*)"EXPRESSION");
                        emitComment((char*)"CALL", t->attr.name);
                        emitRM((char*)"ST", FP, TOFF, FP, (char*)"Store fp in ghost frame for", (char*)t->attr.name);
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                        temp2 = t->child[0];
                    }
                }
                else if (t->kind.ExpK == IdK) {
                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->attr.name))) != NULL) {
                        if (temp->nodeMemType == Local || temp->nodeMemType == Parameter) {
                            //variable is a local variable
                            if (temp->isArray == false) { //id isnt an array
                                if (t->isCallArg) {
                                    emitRM((char*)"LD", AC, temp->offset, FP, (char*)"Load variable (value)", t->attr.name);
                                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter");
                                    TOFF--;
                                    s = to_string(TOFF);
                                    emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                }
                                else {
                                    if (t->isLhsInExp == true) {
                                        emitRM((char*)"LDA", AC, temp->offset, FP, (char*)"Load variable (address)", t->attr.name);
                                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                        TOFF--;
                                        s = to_string(TOFF);
                                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                    }
                                    else {
                                        emitRM((char*)"LD", AC, temp->offset, FP, (char*)"Load variable (value)", t->attr.name);
                                    }
                                }
                            }
                            else {
                                //id is an array
                                if (t->isIndexed == false) {
                                    //is an unindexed array
                                    if (t->isCallArg) { //is a function call argument
                                        if (temp->nodeMemType == Parameter) {
                                            emitRM((char*)"LD", AC, temp->offset, FP, (char*)"Load address of base of array", t->attr.name);
                                        }
                                        else {
                                            emitRM((char*)"LDA", AC, temp->offset, FP, (char*)"Load address of base of array", t->attr.name);
                                        }
                                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter");
                                        TOFF--;
                                        s = to_string(TOFF);
                                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                    }
                                    else { // not a call argument
                                        if (t->isLhsInExp == true) { //is left hand side in an expression
                                            if (temp->nodeMemType == Parameter) {
                                                emitRM((char*)"LD", AC, temp->offset, FP, (char*)"Load address of base of array", t->attr.name);
                                            }
                                            else {
                                                emitRM((char*)"LDA", AC, temp->offset, FP, (char*)"Load address of base of array", t->attr.name);
                                            }
                                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                            TOFF--;
                                            s = to_string(TOFF);
                                            emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                        }
                                        else { //not left hand side in an expression
                                            if (temp->nodeMemType == Parameter) {
                                                emitRM((char*)"LD", AC, temp->offset, FP, (char*)"Load address of base of array", t->attr.name);
                                            }
                                            else {
                                                emitRM((char*)"LDA", AC, temp->offset, FP, (char*)"Load address of base of array", t->attr.name);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            if (temp->nodeMemType == LocalStatic) {
                                
                                //static variable. Visible in local scope, but the variable is allocated in global space
                                if (t->isArray == false) { //variable is not an array
                                    if (t->isCallArg) {
                                        emitRM((char*)"LD", AC, t->offset, GP, (char*)"Load variable (value)", t->attr.name);
                                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter");
                                        TOFF--;
                                        s = to_string(TOFF);
                                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                    }
                                    else {
                                        if (t->isLhsInExp == true) {
                                            emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load variable (address)", t->attr.name);
                                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                            TOFF--;
                                            s = to_string(TOFF);
                                            emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                        }
                                        else {
                                            emitRM((char*)"LD", AC, t->offset, GP, (char*)"Load variable (value)", t->attr.name);
                                        }
                                    }
                                }
                                else {
                                    // variable is an array
                                    if (t->isIndexed == false) {
                                        //variable is unindexed array
                                        if (t->isCallArg) { //is a function call argument
                                            emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter");
                                            TOFF--;
                                            s = to_string(TOFF);
                                            emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                        }
                                        else { // not a call argument
                                            if (t->isLhsInExp == true) { //is left hand side in an expression
                                                emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                                emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                                TOFF--;
                                                s = to_string(TOFF);
                                                emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                            }
                                            else { //not left hand side in an expression
                                                emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                //variable is a global
                                if (t->isArray == false) { //variable is not an array
                                    if (t->isCallArg) {
                                        emitRM((char*)"LD", AC, temp->offset, GP, (char*)"Load variable (value)", t->attr.name);
                                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter");
                                        TOFF--;
                                        s = to_string(TOFF);
                                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                    }
                                    else {
                                        if (t->isLhsInExp == true) {
                                            emitRM((char*)"LDA", AC, temp->offset, GP, (char*)"Load variable (address)", t->attr.name);
                                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                            TOFF--;
                                            s = to_string(TOFF);
                                            emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                        }
                                        else {
                                            emitRM((char*)"LD", AC, temp->offset, GP, (char*)"Load variable (value)", t->attr.name);
                                        }
                                    }
                                }
                                else {
                                    // variable is an array
                                    if (t->isIndexed == false) {
                                        //variable is unindexed array
                                        if (t->isCallArg) { //is a function call argument
                                            emitRM((char*)"LDA", AC, temp->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter");
                                            TOFF--;
                                            s = to_string(TOFF);
                                            emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                        }
                                        else { // not a call argument
                                            if (t->isLhsInExp == true) { //is left hand side in an expression
                                                emitRM((char*)"LDA", AC, temp->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                                emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                                TOFF--;
                                                s = to_string(TOFF);
                                                emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                            }
                                            else { //not left hand side in an expression
                                                emitRM((char*)"LDA", AC, temp->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else if (t->kind.ExpK == AssignK || t->kind.ExpK == OpK) {
                    emitComment((char*)"EXPRESSION");
                    if (t->child[0] != NULL) {
                        if (t->child[0]->kind.ExpK == ConstantK) {
                            if(t->child[0]->isArray == true) {
                                if (t->child[0]->expType == Char) {
                                    
                                }
                            }
                        }
                    }
                    if (t->child[1] != NULL) {
                        if (t->child[1]->kind.ExpK == ConstantK) {
                            if(t->child[1]->isArray == true) {
                                if (t->child[1]->expType == Char) {
                                   
                                }
                            }
                        }
                    }
                } else if (t->kind.ExpK == ConstantK) {
                    if (t->expType == Char) {
                        if (t->isArray == true) {
                            //is a string constant
                            emitStrLit(t->offset, t->attr.string);
                            emitRM((char*)"LDA", AC, t->offset, GP, (char*)"addr of char array (LIT)");
                            if (t->isCallArg || t->isLhsInExp) {
                                s.assign(t->attr.string);
                            }
                        }
                        else {
                            //Not a string. Single char
                            emitRM((char*)"LDC", AC, t->attr.cvalue, AC3, (char*)"Load char constant");
                            if (t->isCallArg || t->isLhsInExp) {
                                s = to_string(t->attr.cvalue);
                            }
                        }
                    }
                    else if (t->expType == Integer) {
                        emitRM((char*)"LDC", AC, t->attr.value, AC3, (char*)"Load integer constant");
                        if (t->isCallArg || t->isLhsInExp) {
                            s = to_string(t->attr.value);
                        }
                    }
                    else if (t->expType == Boolean) {
                        emitRM((char*)"LDC", AC, t->attr.value, AC3, (char*)"Load Boolean constant");
                        if (t->isCallArg || t->isLhsInExp) {
                            s = to_string(t->attr.value);  
                        }
                    }
                    if (t->isLhsInExp == true) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store const value or char str addr in temp loc in frame)", (char*)s.c_str());
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                    }
                    else if (t->isCallArg == true) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter", (char*)s.c_str());
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());    
                    }

                }
                break;
            }
            default:
            {
                printf("ERROR(SYSTEM): Invalid node type in code generation.\n");
                break;
            }
        }
        //Traverse left child (child 0)
        codeGenerationTraverse(t->child[0], symbolTable);
        switch (t->nodekind) {
            case DeclK:
            {
                break;
            }
            case StmtK:
            {
                if (t->kind.StmtK == CompoundK) {
                    emitComment((char*)"Compound body");
                }
                else if (t->kind.StmtK == IfK) {
                    t->memLoc = emitSkip(1);
                    emitComment((char*)"THEN");
                }
                else if (t->kind.StmtK == WhileK) {
                    emitRM((char*)"JNZ", AC, 1, PC, (char*)"Jump to while part");
                    t->loopStmtMemLoc = emitSkip(1);
                    myLoopStack.push(t->loopStmtMemLoc);
                    emitComment((char*)"DO");
                }
                else if (t->kind.StmtK == ReturnK) {
                    if (t->child[0] != NULL) {
                        emitRM((char*)"LDA", RT, 0, AC, (char*)"Copy result to return register");
                        emitRM((char*)"LD", AC, -1, FP, (char*)"Load return address");
                        emitRM((char*)"LD", FP, 0, FP, (char*)"Adjust fp");
                        emitGoto(0, AC, (char*)"Return");
                    }
                }
                else if (t->kind.StmtK == RangeK) {
                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"save starting value in index variable");
                    TOFF--;
                }
                else if (t->kind.StmtK == ForK) {
                    t->memLoc = emitWhereAmI();
                }
                break;
            }
            case ExpK:
            {
                if (t->kind.ExpK == CallK) {
                    emitComment((char*)"Param end", t->attr.name);
                    paramNum = t->savedParamNum;
                    emitRM((char*)"LDA", FP, t->offset, FP, (char*)"Ghost frame becomes new active frame");
                    emitRM((char*)"LDA", AC, 1, PC, (char*)"Return address in ac");
                    emitGotoAbs(temp->memLoc, (char*)"CALL", temp->attr.name);
                    emitComment((char*)"Call end", t->attr.name);
                    TOFF = t->savedOffset;
                    s = to_string(TOFF);
                    emitComment((char*)"TOFF set:", (char*)s.c_str());
                    if (t->isLhsInExp == true) {
                        emitRM((char*)"ST", RT, TOFF, FP, (char*)"Push left side (store return value in temp loc in frame)");
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                    }
                    else {
                        emitRM((char*)"LDA", AC, 0, RT, (char*)"Save the result in ac");
                    }
                    if (t->isCallArg == true) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter", t->attr.name);
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());      
                    }


                }
                break;
            }
        }
        //traverse middle child (child 1)
        codeGenerationTraverse(t->child[1], symbolTable);
        switch (t->nodekind) {
            case DeclK:
            {
                break;
            }
            case StmtK:
            {
                if (t->kind.StmtK == IfK) {
                    backpatchLoc = emitWhereAmI(); //save the current location
                    emitNewLoc(t->memLoc); //set current location to backpatch location
                    if (t->hasMatchingElse == true) {
                        //if statement has a matching else clause
                        emitRM((char*)"JZR", AC, (backpatchLoc - t->memLoc), PC, (char*)"Jump around the THEN if false [backpatch]");
                    }
                    else {
                        //if statement does not have an else clause
                        emitRM((char*)"JZR", AC, (backpatchLoc - t->memLoc - 1), PC, (char*)"Jump around the THEN if false [backpatch]");
                    }
                    emitNewLoc(backpatchLoc); //restore location
                    if (t->child[2] != NULL) {
                        t->memLoc = emitSkip(1);
                        emitComment((char*)"ELSE");
                    }
                }
                else if (t->kind.StmtK == WhileK) {
                    emitRM((char*)"JMP", PC, -(emitWhereAmI() - (t->memLoc - 1)), PC, (char*)"go to beginning of loop");
                    backpatchLoc = emitWhereAmI();
                    emitNewLoc(t->loopStmtMemLoc);
                    emitRM((char*)"JMP", PC, backpatchLoc - (emitWhereAmI() + 1), PC, (char*)"Jump past loop [backpatch]");
                    emitNewLoc(backpatchLoc);
                    emitComment((char*)"END WHILE");
                    myLoopStack.pop();
                }
                else if (t->kind.StmtK == RangeK) {
                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"save stop value");
                    TOFF--;
                }
                else if (t->kind.StmtK == ForK) {
                    emitRM((char*)"JNZ", AC, 1, PC, (char*)"Jump to loop body");
                    t->loopStmtMemLoc = emitSkip(1);
                    myLoopStack.push(t->loopStmtMemLoc);
                    if (t->child[2] != NULL) {
                        if (t->child[2]->nodekind == StmtK) {
                            if (t->child[2]->kind.StmtK == CompoundK) {
                                TOFF = t->child[2]->size;
                                s = to_string(TOFF);
                                emitComment((char*)"COMPOUND");
                                emitComment((char*)"TOFF set:", (char*)s.c_str());
                            }
                        }
                    }
                }
                break;
            }
            case ExpK:
            {
                if (t->kind.ExpK == IdArrK) {
                    if ((temp = (TreeNode*)symbolTable->lookup(s.assign(t->child[0]->attr.name))) != NULL) {
                        //this is an indexed array and it is allocated in local space
                        if (temp->nodeMemType == Local || temp->nodeMemType == Parameter) {
                            if (t->isLhsInExp) {
                                if (temp->nodeMemType == Parameter) {
                                    emitRM((char*)"LD", AC1, temp->offset, FP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                }
                                else {
                                    emitRM((char*)"LDA", AC1, temp->offset, FP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                }
                                emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                                emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)", t->child[0]->attr.name);
                                TOFF--;
                                s = to_string(TOFF);
                                emitComment((char*)"TOFF dec:", (char*)s.c_str());     
                            } 
                            else {
                                if (temp->nodeMemType == Parameter) {
                                    emitRM((char*)"LD", AC1, temp->offset, FP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                }
                                else {
                                    emitRM((char*)"LDA", AC1, temp->offset, FP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                }
                                emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                                emitRM((char*)"LD", AC, 0, AC, (char*)"Load array element");
                            }
                            if (t->isCallArg == true) {
                                emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter", t->child[0]->attr.name);
                                TOFF--;
                                s = to_string(TOFF);
                                emitComment((char*)"TOFF dec:", (char*)s.c_str());                        
                            }
                        } 
                        else {
                            //this is an indexed array that is allocated in global space
                            if (temp->nodeMemType == LocalStatic) {
                                //static array. Allocated in global space but visible in local scope. 
                                if (t->isLhsInExp) {
                                    emitRM((char*)"LDA", AC1, t->child[0]->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                    emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)", t->child[0]->attr.name);
                                    TOFF--;
                                    s = to_string(TOFF);
                                    emitComment((char*)"TOFF dec:", (char*)s.c_str());     
                                } 
                                else {
                                    emitRM((char*)"LDA", AC1, t->child[0]->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                    emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                                    emitRM((char*)"LD", AC, 0, AC, (char*)"Load array element");
                                }
                                if (t->isCallArg == true) {
                                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter", t->child[0]->attr.name);
                                    TOFF--;
                                    s = to_string(TOFF);
                                    emitComment((char*)"TOFF dec:", (char*)s.c_str());                        
                                }
                            }
                            else {
                                //array is global. nodeMemType = Global
                                if (t->isLhsInExp) {
                                    emitRM((char*)"LDA", AC1, temp->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                    emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)", t->child[0]->attr.name);
                                    TOFF--;
                                    s = to_string(TOFF);
                                    emitComment((char*)"TOFF dec:", (char*)s.c_str());     
                                } 
                                else {
                                    emitRM((char*)"LDA", AC1, temp->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                                    emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                                    emitRM((char*)"LD", AC, 0, AC, (char*)"Load array element");
                                }
                                if (t->isCallArg == true) {
                                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter", t->child[0]->attr.name);
                                    TOFF--;
                                    s = to_string(TOFF);
                                    emitComment((char*)"TOFF dec:", (char*)s.c_str());                        
                                }
                            }
                        }
                    }
                }
                break;
            }
        }
        //traverse right child (child 2)
        codeGenerationTraverse(t->child[2], symbolTable);
        switch (t->nodekind) {
            case DeclK:
            {
                if (t->kind.DeclK == FuncDeclK) {
                    emitComment((char*)"Add standard closing in case there is no return statement");
                    emitRM((char*)"LDC", RT, 0, AC3, (char*)"Set return value to 0");
                    emitRM((char*)"LD", AC, -1, FP, (char*)"Load return address");
                    emitRM((char*)"LD", FP, 0, FP, (char*)"Adjust fp");
                    emitGoto(0, AC, (char*)"Return");
                    emitComment((char*)"** ** ** ** ** ** ** ** ** ** ** **");
                    emitComment((char*)"END FUNCTION", t->attr.name);
                }
                else if (t->kind.DeclK == VarDeclK) {
                    if (t->isArray != true) {
                        //vardecl is not an array
                        if (t->child[0] != NULL) {
                            if (t->nodeMemType == Local) {
                                emitRM((char*)"ST", AC, t->offset, FP, (char*)"Store variable", t->attr.name);
                            }
                        }
                    }
                    else {
                        //vardecl is an array
                        if (t->child[0] != NULL) {
                            if (t->child[0]->isArray == true) {
                                if (t->nodeMemType == Local) {
                                    emitRM((char*)"LDA", AC1, t->offset, FP, (char*)"Load address of lhs");
                                    emitRM((char*)"LD", AC2, 1, AC, (char*)"size of rhs");
                                    emitRM((char*)"LD", AC3, 1, AC1, (char*)"size of lhs");
                                    emitRO((char*)"SWP", AC2, AC3, AC3, (char*)"pick smallest size");
                                    emitRO((char*)"MOV", AC1, AC, AC2, (char*)"array op =");
                                }
                            }
                        }
                    }
                }
                break;
            }
            case StmtK:
            {
                if (t->kind.StmtK == CompoundK) {
                    foffset = t->savedOffset;
                    TOFF = t->savedOffset;
                    s = to_string(TOFF);
                    emitComment((char*)"TOFF set:", (char*)s.c_str());
                    emitComment((char*)"END COMPOUND");
                }
                else if (t->kind.StmtK == IfK) {
                    if (t->child[2] != NULL) {
                        backPatchAJumpToHere(t->memLoc, (char*)"Jump around the ELSE [backpatch]");
                    }
                }
                else if (t->kind.StmtK == RangeK) {
                    if (t->child[2] != NULL) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"save step value");
                    }
                    else {
                        emitRM((char*)"LDC", AC, 1, AC3, (char*)"Load default step value 1");
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"save step value");
                    }
                    TOFF--;
                    emitRM((char*)"LD", AC1, TOFF + 3, FP, (char*)"loop index");
                    emitRM((char*)"LD", AC2, TOFF + 2, FP, (char*)"stop value");
                    emitRM((char*)"LD", AC, TOFF + 1, FP, (char*)"step value");
                    emitRO((char*)"SLT", AC, AC1, AC2, (char*)"Op <");
                    
                }
                else if (t->kind.StmtK == ForK) {
                    TOFF = t->savedOffset - 3;
                    s = to_string(TOFF);
                    emitComment((char*)"TOFF set:", (char*)s.c_str());
                    emitComment((char*)"Bottom of loop increment and jump");
                    emitRM((char*)"LD", AC, TOFF + 3, FP, (char*)"load index");
                    emitRM((char*)"LD", AC2, TOFF + 1, FP, (char*)"load step");
                    emitRO((char*)"ADD", AC, AC, AC2, (char*)"increment");
                    emitRM((char*)"ST", AC, TOFF + 3, FP, (char*)"store back to index");
                    emitGotoAbs(t->loopStmtMemLoc - 5, (char*)"go to beginning of loop");
                    backpatchLoc = emitWhereAmI();
                    emitNewLoc(t->loopStmtMemLoc);
                    emitRM((char*)"JMP", PC, backpatchLoc - (emitWhereAmI() + 1), PC, (char*)"Jump past loop [backpatch]");
                    emitNewLoc(backpatchLoc);
                    emitComment((char*)"End FOR");
                    myLoopStack.pop();
                    TOFF = t->savedOffset;
                    s = to_string(TOFF);
                    emitComment((char*)"TOFF set:", (char*)s.c_str());
                }
                break;
            }
            case ExpK:
            {
                if (t->kind.ExpK == OpK) {
                    if (t->child[0]->isLhsInExp == true) {
                        TOFF++;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF inc:", (char*)s.c_str());
                        if ((t->child[0]->kind.ExpK == IdK || t->child[0]->kind.ExpK == IdArrK || t->child[0]->kind.ExpK == AssignK) && t->child[0]->isLhsInExp == true) {
                    
                            emitRM((char*)"LD", AC2, TOFF, FP, (char*)"Pop left into ac2 (address)");
                            emitRM((char*)"LD", AC1, 0, AC2, (char*)"Load left variable into ac1 (value)");
                        }
                        else {
                            //operand is a constant
                            if (t->child[0]->kind.ExpK == ConstantK) {
                                if (t->child[0]->expType == String) {
                                    emitRM((char*)"LD", AC2, TOFF, FP, (char*)"Pop left into ac2 (address)");
                                    emitRM((char*)"LD", AC1, 0, AC2, (char*)"Load left variable into ac1 (value)");
                                }
                                else {
                                    emitRM((char*)"LD", AC1, TOFF, FP, (char*)"Pop left into ac1 (const value)");
                                }
                            }
                            else {
                                emitRM((char*)"LD", AC1, TOFF, FP, (char*)"Pop left into ac1 (const value)");
                            }
                        }
                        if (t->child[0]->isArray == true) {
                            emitRM((char*)"LD", AC1, TOFF, FP, (char*)"load left into AC1 (address)");
                            emitRM((char*)"LD", AC2, 1, AC, (char*)"AC2 <- |RHS|");
                            emitRM((char*)"LD", AC3, 1, AC1, (char*)"AC2 <- |LHS|");
                            emitRM((char*)"LDA", RT, 0, AC2, (char*)"R2 <- |RHS|");
                            emitRO((char*)"SWP", AC2, AC3, AC3, (char*)"pick smallest size");
                            emitRM((char*)"LD", AC3, 1, AC1, (char*)"AC3 <- |LHS|");
                            emitRO((char*)"CO", AC1, AC, AC2, (char*)"setup array compare LHS vs RHS");
                            emitRO((char*)"TNE", AC2, AC1, AC, (char*)"if not equal then test (AC1, AC)");
                            emitRO((char*)"JNZ", AC2, 2, PC, (char*)"jump not equal");
                            emitRM((char*)"LDA", AC, 0, RT, (char*)"AC1 <- |RHS|");
                            emitRM((char*)"LDA", AC1, 0, AC3, (char*)"AC <- |LHS|");
                        } 
                    }
                    if (t->attr.op == int('+')) {
                        emitRO((char*)"ADD", AC, AC1, AC, (char*)"Op +");
                    } else if (t->attr.op == int('-')) {
                        emitRO((char*)"SUB", AC, AC1, AC, (char*)"Op -");
                    } else if (t->attr.op == int('*')) {
                        emitRO((char*)"MUL", AC, AC1, AC, (char*)"Op *");
                    } else if (t->attr.op == int('/')) {
                        emitRO((char*)"DIV", AC, AC1, AC, (char*)"Op /");
                    } else if (t->attr.op == int('%')) {
                        emitRO((char*)"MOD", AC, AC1, AC, (char*)"Op %");
                    } else if (t->attr.op == int('<')) {
                        emitRO((char*)"TLT", AC, AC1, AC, (char*)"Op <");
                    } else if (t->attr.op == int('>')) {
                        emitRO((char*)"TGT", AC, AC1, AC, (char*)"Op >");
                    } else if (t->attr.op == LEQ) {
                        emitRO((char*)"TLE", AC, AC1, AC, (char*)"Op <=");
                    } else if (t->attr.op == GEQ) {
                        emitRO((char*)"TGE", AC, AC1, AC, (char*)"Op >=");
                    } else if (t->attr.op == EQ) {
                        emitRO((char*)"TEQ", AC, AC1, AC, (char*)"Op ==");
                    } else if (t->attr.op == NEQ) {
                        emitRO((char*)"TNE", AC, AC1, AC, (char*)"Op <");
                    } else if (t->attr.op == SIZEOF) {
                        emitRO((char*)"LD", AC, 1, AC, (char*)"Load array size");
                    } else if (t->attr.op == CHSIGN) {
                        emitRO((char*)"NEG", AC, AC, AC, (char*)"Op unary -");
                    } else if (t->attr.op == NOT) {
                        emitRM((char*)"LDC", AC1, 1, AC3, (char*)"Load 1");
                        emitRO((char*)"XOR", AC, AC, AC1, (char*)"Op XOR to get logical not");
                    } else if (t->attr.op == OR) {
                        emitRO((char*)"OR", AC, AC1, AC, (char*)"Op OR");
                    } else if (t->attr.op == AND) {
                        emitRO((char*)"AND", AC, AC1, AC, (char*)"Op AND");
                    } else if (t->attr.op == int('?')) {
                        emitRO((char*)"RND", AC, AC, AC3, (char*)"Op ?");
                    }
                    else if (t->attr.op == MIN) {
                        emitRO((char*)"SWP", AC, AC1, AC3, (char*)"Op :<:");
                    }
                    else if (t->attr.op == MAX) {
                        emitRO((char*)"SWP", AC1, AC, AC3, (char*)"Op :>:");

                    }
                    if (t->isLhsInExp == true) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push operation result");
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                    }
                    if (t->isCallArg) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter (operation result)");
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());   
                    }
                }
                else if (t->kind.ExpK == AssignK) {
                    TOFF++;
                    s = to_string(TOFF);
                    emitComment((char*)"TOFF inc:", (char*)s.c_str());
                    emitRM((char*)"LD", AC2, TOFF, FP, (char*)"Pop left into ac2 (variable address)");
                    emitRM((char*)"LD", AC1, 0, AC2, (char*)"Load left variable into ac1 (value)");
                    if (t->attr.op == INC) {
                        emitRM((char*)"LDA", AC, 1, AC1, (char*)"increment value of x. Result in ac");
                    }
                    else if (t->attr.op == DEC) {
                        emitRO((char*)"LDA", AC, -1, AC1, (char*)"decrement value of x. Result in ac");
                    }
                    else if (t->attr.op == ADDASS) {
                        emitRO((char*)"ADD", AC, AC1, AC, (char*)"op +=");
                    }
                    else if (t->attr.op == SUBASS) {
                        emitRO((char*)"SUB", AC, AC1, AC, (char*)"op -=");
                    }
                    else if (t->attr.op == MULASS) {
                        emitRO((char*)"MUL", AC, AC1, AC, (char*)"op *=");
                    }
                    else if (t->attr.op == DIVASS) {
                        emitRO((char*)"DIV", AC, AC1, AC, (char*)"op /=");
                    }

                    if (t->child[0]->kind.ExpK == IdK) {
                        if (t->child[0]->isArray == true) {
                            emitRM((char*)"LDA", AC1, 0, AC2, (char*)"addr of lhs");
                            emitRM((char*)"LD", AC2, 1, AC, (char*)"size of rhs");
                            emitRM((char*)"LD", AC3, 1, AC1, (char*)"size of lhs");
                            emitRO((char*)"SWP", AC2, AC3, AC3, (char*)"pick smallest size");
                            emitRO((char*)"MOV", AC1, AC, AC2, (char*)"array op =");
                        }
                        else {
                            emitRM((char*)"ST", AC, 0, AC2, (char*)"Store variable", t->child[0]->attr.name);
                        }
                    }
                    else if (t->child[0]->kind.ExpK == IdArrK) {
                        emitRM((char*)"ST", AC, 0, AC2, (char*)"Store variable", t->child[0]->child[0]->attr.name);
                    }
                    if (t->isCallArg) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter");
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                    }
                    if (t->isLhsInExp) {
                        if (t->child[0]->kind.ExpK == IdK && t->child[0]->isArray == true) {
                            emitRM((char*)"ST", AC1, TOFF, FP, (char*)"Push left side (assigned to)");
                            TOFF--;
                            s = to_string(TOFF);
                            emitComment((char*)"TOFF dec:", (char*)s.c_str());
                        }
                        else {
                            emitRM((char*)"ST", AC2, TOFF, FP, (char*)"Push left side (assigned to)");
                            TOFF--;
                            s = to_string(TOFF);
                            emitComment((char*)"TOFF dec:", (char*)s.c_str());
                        }
                    }
                }
                break;
            }
        }
        if (exitScope == true)  {
            symbolTable->leave();
            scopeStack.pop();
        }
        if (t->nodekind == StmtK) {
            if (t->kind.StmtK == ForK) {
                if (t->child[2] != NULL) {
                    if (t->child[2]->nodekind == StmtK) {
                        if (t->child[2]->kind.StmtK != CompoundK) {
                            TOFF = t->savedOffset;
                        }
                    }
                    else {
                        TOFF = t->savedOffset;
                    }
                }
                else {
                    TOFF = t->savedOffset;
                }
            }
        }
        codeGenerationTraverse(t->sibling, symbolTable);

    }
    return;
}
void generatePrologue(SymbolTable* symbolTable)
{
    backPatchAJumpToHere(0, (char*)"Jump to init [backpatch]");
    emitComment((char*)"INIT");
    emitRM((char*)"LDA", FP, endOfGlobals, GP, (char*)"set first frame at end of globals");
    emitRM((char*)"ST", FP, 0, 1, (char*)"store old fp (point to self)");
    emitComment((char*)"INIT GLOBALS AND STATICS");
    symbolTable->applyToAllGlobal(initGlobalsAndStatics);
    emitComment((char*)"END INIT GLOBALS AND STATICS");

    emitRM((char*)"LDA", AC, 1, PC, (char*)"Return address in ac");
    temp = (TreeNode*)symbolTable->lookup("main");
    emitGotoAbs(temp->memLoc, (char*)"Jump to main");
    emitRO((char*)"HALT", 0, 0, 0, (char*)"DONE!");
    emitComment((char*)"END INIT"); 
    return;
}

int getStmtSize(TreeNode* t)
{
    int mySize = 0;
    if (t != NULL) {
        if (t->nodekind == DeclK) {
            if (t->kind.DeclK == VarDeclK) {
                if (t->isArray == true) {
                    mySize = t->size;
                }
                else {
                    mySize = 1;
                }
            }
            else if (t->kind.DeclK == ParmK) {
                mySize = 1;
            }
        }
        return (mySize + getStmtSize(t->child[0]) + getStmtSize(t->child[1]) + getStmtSize(t->child[2]) + getStmtSize(t->sibling));
    }
    else {
        return 0;
    }
}
void initGlobalsAndStatics(std::string s, void* t) 
{
    TreeNode* tNode = (TreeNode*) t;
    TOFF = endOfGlobals;
    globalsStaticsTraverse(tNode);
}
void globalsStaticsTraverse(TreeNode* t)
{
    std::string s;
    struct TreeNode* temp = NULL;
    if (t != NULL) {
        //code
        switch (t->nodekind) {
            case DeclK:
            {
                if (t->kind.DeclK == VarDeclK) {
                    if (t->kind.DeclK == VarDeclK) //node is variable declaration
                    {
                        if (t->isArray == true) { //variable declaration is an array
                            if (t->nodeMemType == LocalStatic) {
                                //local static
                                //allocate in global memory (goffset)
                                emitRM((char*)"LDC", AC, t->size - 1, AC3, (char*)"load size of array", t->attr.name);
                                emitRM((char*)"ST", AC, t->offset + 1, GP, (char*)"save size of array", t->attr.name);
                            
                            }
                            else if (t->nodeMemType == Global) {
                                //allocate in global memory (goffset)
                                emitRM((char*)"LDC", AC, t->size - 1, AC3, (char*)"load size of array", t->attr.name);
                                emitRM((char*)"ST", AC, t->offset + 1, GP, (char*)"save size of array", t->attr.name);
                            }
                        }
                    }
                }
                else if (t->kind.DeclK == FuncDeclK) {
                    globalsStaticsTraverse(t->sibling);
                    return;
                }
                break;
            }
            case StmtK:
            {
                return;
                break;
            }
            case ExpK:
            {
                if (t->kind.ExpK == IdK) {
                    if (t->nodeMemType == LocalStatic) {
                        //static variable. Visible in local scope, but the variable is allocated in global space
                        if (t->isArray == false) { //variable is not an array
                            if (t->isLhsInExp == true) {
                                emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load variable (address)", t->attr.name);
                                emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                TOFF--;
                                s = to_string(TOFF);
                                emitComment((char*)"TOFF dec:", (char*)s.c_str());
                            }
                            else {
                                emitRM((char*)"LD", AC, t->offset, GP, (char*)"Load variable (value)", t->attr.name);
                            }
                        }
                        else {
                            // variable is an array
                            if (t->isIndexed == false) {
                            //variable is unindexed array
                                if (t->isLhsInExp == true) { //is left hand side in an expression
                                    emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                    TOFF--;
                                    s = to_string(TOFF);
                                    emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                }
                                else { //not left hand side in an expression
                                    emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                }
                            }
                        }
                    }
                    else if (t->nodeMemType == Global) {
                        //variable is a global
                        if (t->isArray == false) { //variable is not an array
                            if (t->isLhsInExp == true) {
                                emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load variable (address)", t->attr.name);
                                emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                TOFF--;
                                s = to_string(TOFF);
                                emitComment((char*)"TOFF dec:", (char*)s.c_str());
                            }
                            else {
                                emitRM((char*)"LD", AC, t->offset, GP, (char*)"Load variable (value)", t->attr.name);
                            }
                        }
                        else {
                            // variable is an array
                            if (t->isIndexed == false) {
                                //variable is unindexed array
                                if (t->isLhsInExp == true) { //is left hand side in an expression
                                    emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                    emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)");
                                    TOFF--;
                                    s = to_string(TOFF);
                                    emitComment((char*)"TOFF dec:", (char*)s.c_str());
                                }
                                else { //not left hand side in an expression
                                    emitRM((char*)"LDA", AC, t->offset, GP, (char*)"Load address of base of array", t->attr.name);
                                }
                            }
                        }
                    }
                }
                else if (t->kind.ExpK == AssignK || t->kind.ExpK == OpK) {
                    emitComment((char*)"EXPRESSION");
                } else if (t->kind.ExpK == ConstantK) {
                    if (t->expType == Char) {
                        if (t->isArray == true) {
                            //is a string constant
                            emitStrLit(t->offset, t->attr.string);
                            emitRM((char*)"LDA", AC, t->offset, GP, (char*)"addr of char array (LIT)");
                            if (t->isLhsInExp) {
                                s.assign(t->attr.string);
                            }
                        }
                        else {
                            //Not a string. Single char
                            emitRM((char*)"LDC", AC, t->attr.cvalue, AC3, (char*)"Load char constant");
                            if (t->isLhsInExp) {
                                s = to_string(t->attr.cvalue);
                            }
                        }
                    }
                    else if (t->expType == Integer) {
                        emitRM((char*)"LDC", AC, t->attr.value, AC3, (char*)"Load integer constant");
                        if (t->isLhsInExp) {
                            s = to_string(t->attr.value);
                        }
                    }
                    else if (t->expType == Boolean) {
                        emitRM((char*)"LDC", AC, t->attr.value, AC3, (char*)"Load Boolean constant");
                        if (t->isLhsInExp) {
                            s = to_string(t->attr.value);  
                        }
                    }
                    if (t->isLhsInExp == true) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store const value or char str addr in temp loc in frame)", (char*)s.c_str());
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                    }

                }
                break;
            }
            default:
            {
                printf("ERROR(SYSTEM): Invalid node type in code generation.\n");
                break;
            }
        }
        //Traverse left child (child 0)
        globalsStaticsTraverse(t->child[0]);
        switch (t->nodekind) {
            case DeclK:
            {
                break;
            }
            case StmtK:
            {
                break;
            }
            case ExpK:
            {
                break;
            }
        }
        //traverse middle child (child 1)
        globalsStaticsTraverse(t->child[1]);
        switch (t->nodekind) {
            case DeclK:
            {
                break;
            }
            case StmtK:
            {
                break;
            }
            case ExpK:
            {
                if (t->kind.ExpK == IdArrK) {
                    //this is an indexed array that is allocated in global space
                    if (temp->nodeMemType == LocalStatic) {
                        //static array. Allocated in global space but visible in local scope. 
                        if (t->isLhsInExp) {
                            emitRM((char*)"LDA", AC1, t->child[0]->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                            emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)", t->child[0]->attr.name);
                            TOFF--;
                            s = to_string(TOFF);
                            emitComment((char*)"TOFF dec:", (char*)s.c_str());     
                        } 
                        else {
                            emitRM((char*)"LDA", AC1, t->child[0]->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                            emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                            emitRM((char*)"LD", AC, 0, AC, (char*)"Load array element");
                        }
                        if (t->isCallArg == true) {
                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter", t->child[0]->attr.name);
                            TOFF--;
                            s = to_string(TOFF);
                            emitComment((char*)"TOFF dec:", (char*)s.c_str());                        
                        }
                    }
                    else {
                        //array is global. nodeMemType = Global
                        if (t->isLhsInExp) {
                            emitRM((char*)"LDA", AC1, temp->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                            emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push left side (store variable address in frame)", t->child[0]->attr.name);
                            TOFF--;
                            s = to_string(TOFF);
                            emitComment((char*)"TOFF dec:", (char*)s.c_str());     
                        } 
                        else {
                            emitRM((char*)"LDA", AC1, temp->offset, GP, (char*)"Load address of base of array", t->child[0]->attr.name);
                            emitRO((char*)"SUB", AC, AC1, AC, (char*)"compute location from index");
                            emitRM((char*)"LD", AC, 0, AC, (char*)"Load array element");
                        }
                        if (t->isCallArg == true) {
                            emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push parameter", t->child[0]->attr.name);
                            TOFF--;
                            s = to_string(TOFF);
                             emitComment((char*)"TOFF dec:", (char*)s.c_str());                        
                        }
                    }
                }
                break;
            }
        }
        //traverse right child (child 2)
        globalsStaticsTraverse(t->child[2]);
        switch (t->nodekind) {
            case DeclK:
            {
                if (t->kind.DeclK == VarDeclK) {
                    if (t->isArray != true) {
                        //vardecl is not an array
                        if (t->child[0] != NULL) {
                            if (t->nodeMemType == Local) {
                                emitRM((char*)"ST", AC, t->offset, FP, (char*)"Store variable", t->attr.name);
                            }
                            else {
                                emitRM((char*)"ST", AC, t->offset, GP, (char*)"Store variable", t->attr.name);
                            }
                        }
                    }
                    else {
                        //vardecl is an array
                        if (t->child[0] != NULL) {
                            if (t->child[0]->isArray == true) {
                                if (t->nodeMemType == Local) {
                                    emitRM((char*)"LDA", AC1, t->offset, FP, (char*)"Load address of lhs");
                                }
                                else {
                                    emitRM((char*)"LDA", AC1, t->offset, GP, (char*)"Load address of lhs");
                                }
                                emitRM((char*)"LD", AC2, 1, AC, (char*)"size of rhs");
                                emitRM((char*)"LD", AC3, 1, AC1, (char*)"size of lhs");
                                emitRO((char*)"SWP", AC2, AC3, AC3, (char*)"pick smallest size");
                                emitRO((char*)"MOV", AC1, AC, AC2, (char*)"array op =");
                            }
                        }
                    }
                }
                break;
            }
            case StmtK:
            {
                break;
            }
            case ExpK:
            {
                if (t->kind.ExpK == OpK) {
                    if (t->child[0]->isLhsInExp == true) {
                        TOFF++;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF inc:", (char*)s.c_str());
                        if ((t->child[0]->kind.ExpK == IdK || t->child[0]->kind.ExpK == IdArrK) && t->child[0]->isLhsInExp == true) {
                    
                            emitRM((char*)"LD", AC2, TOFF, FP, (char*)"Pop left into ac2 (address)");
                            emitRM((char*)"LD", AC1, 0, AC2, (char*)"Load left variable into ac1 (value)");
                        }
                        else {
                            //operand is a constant
                            if (t->child[0]->expType == String) {
                            emitRM((char*)"LD", AC2, TOFF, FP, (char*)"Pop left into ac2 (address)");
                            emitRM((char*)"LD", AC1, 0, AC2, (char*)"Load left variable into ac1 (value)");
                            }
                            else {
                                emitRM((char*)"LD", AC1, TOFF, FP, (char*)"Pop left into ac1 (const value)");
                            }
                        }
                    }
                    if (t->attr.op == int('+')) {
                        emitRO((char*)"ADD", AC, AC1, AC, (char*)"Op +");
                    } else if (t->attr.op == int('-')) {
                        emitRO((char*)"SUB", AC, AC1, AC, (char*)"Op -");
                    } else if (t->attr.op == int('*')) {
                        emitRO((char*)"MUL", AC, AC1, AC, (char*)"Op *");
                    } else if (t->attr.op == int('/')) {
                        emitRO((char*)"DIV", AC, AC1, AC, (char*)"Op /");
                    } else if (t->attr.op == int('%')) {
                        emitRO((char*)"MOD", AC, AC1, AC, (char*)"Op %");
                    } else if (t->attr.op == int('<')) {
                        emitRO((char*)"TLT", AC, AC1, AC, (char*)"Op <");
                    } else if (t->attr.op == int('>')) {
                        emitRO((char*)"TGT", AC, AC1, AC, (char*)"Op >");
                    } else if (t->attr.op == LEQ) {
                        emitRO((char*)"TLE", AC, AC1, AC, (char*)"Op <=");
                    } else if (t->attr.op == GEQ) {
                        emitRO((char*)"TGE", AC, AC1, AC, (char*)"Op >=");
                    } else if (t->attr.op == EQ) {
                        emitRO((char*)"TEQ", AC, AC1, AC, (char*)"Op ==");
                    } else if (t->attr.op == NEQ) {
                        emitRO((char*)"TNE", AC, AC1, AC, (char*)"Op <");
                    } else if (t->attr.op == SIZEOF) {
                        emitRO((char*)"LD", AC, 1, AC, (char*)"Load array size");
                    } else if (t->attr.op == CHSIGN) {
                        emitRO((char*)"NEG", AC, AC, AC, (char*)"Op unary -");
                    } else if (t->attr.op == NOT) {
                        emitRM((char*)"LDC", AC1, 1, AC3, (char*)"Load 1");
                        emitRO((char*)"XOR", AC, AC, AC1, (char*)"Op XOR to get logical not");
                    } else if (t->attr.op == OR) {
                        emitRO((char*)"OR", AC, AC1, AC, (char*)"Op OR");
                    } else if (t->attr.op == AND) {
                        emitRO((char*)"AND", AC, AC1, AC, (char*)"Op AND");
                    } else if (t->attr.op == int('?')) {
                        emitRO((char*)"RND", AC, AC, AC3, (char*)"Op ?");
                    }
                    if (t->isLhsInExp == true) {
                        emitRM((char*)"ST", AC, TOFF, FP, (char*)"Push operation result");
                        TOFF--;
                        s = to_string(TOFF);
                        emitComment((char*)"TOFF dec:", (char*)s.c_str());
                    }
                }
                break;
            }
        }
        globalsStaticsTraverse(t->sibling);
    }
}