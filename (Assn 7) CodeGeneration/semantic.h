/*
* Connor Williams
* 2/22/2021
* semantic.h
*/
#include "symbolTable.h"
#include "tree.h"
#include <sstream>

struct operatorTypes {
    ExpType oper1Type;
    ExpType oper2Type;
    ExpType returnType;
    bool arrayOnly;
    bool workWithArray;
    bool lhsRhsSame;
    bool isBinary;
};

template <typename T>
std::string to_string(T value)
{
	std::ostringstream os ;
	os << value ;
	return os.str() ;
}
void semanticAnalysis(struct TreeNode *syntaxTree, SymbolTable *symbolTable);
void treeTraverse(struct TreeNode* t, SymbolTable *SymbolTable, struct TreeNode* currentFuncDecl);
void prototypeTraverse(struct TreeNode *t, SymbolTable *symbolTable);
struct operatorTypes* getOperatorTypes(OpKind op); //get this operators operand types and return type (if possible)
ExpType getType(TreeNode *t, SymbolTable *symbolTable); //get this node's type
void checkIfUsed(std::string s, void* t);
void turnOffInitializedWarnings(TreeNode* t, SymbolTable* symbolTable);
void turnOnInitializedWarnings(TreeNode* t, SymbolTable* symbolTable);
bool checkConstantExpression(TreeNode* t);
bool rhsConstainsUninitLhs(TreeNode* lhs, TreeNode* rhs, SymbolTable* symboltable);