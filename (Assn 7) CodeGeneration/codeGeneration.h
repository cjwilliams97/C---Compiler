#include "symbolTable.h"
#include "tree.h"
#include <stack>

void generateCode(char* inFile, char* outFileName,TreeNode* syntaxTree, SymbolTable* symbolTable);
void codeGenerationTraverse(TreeNode* syntaxTree, SymbolTable* symbolTable);
void IO_traverse(TreeNode* t, SymbolTable* SymbolTable);
void generatePrologue(SymbolTable* symbolTable);
int getStmtSize(TreeNode* t);
void initGlobalsAndStatics(std::string s, void* t);
void globalsStaticsTraverse(TreeNode* t);