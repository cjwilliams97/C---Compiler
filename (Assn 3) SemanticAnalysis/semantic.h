#include "symbolTable.h"
#include "tree.h"

struct operatorTypes {
    ExpType oper1Type;
    ExpType oper2Type;
    ExpType returnType;
    bool arrayOnly;
    bool workWithArray;
    bool lhsRhsSame;
    bool isBinary;
};

void semanticAnalysis(struct TreeNode *syntaxTree, SymbolTable *symbolTable);
void treeTraverse(struct TreeNode* t, SymbolTable *SymbolTable, bool typingOn);
struct operatorTypes* getOperatorTypes(OpKind op); //get this operators operand types and return type (if possible)
ExpType getChildType(TreeNode *t, SymbolTable *symbolTable); //get this node
void checkIfUsed(std::string s, void* t);
void turnOffInitializedWarnings(TreeNode* t, SymbolTable* symbolTable);
void turnOnInitializedWarnings(TreeNode* t, SymbolTable* symbolTable);