/*
* Connor Williams
* 2/4/2021
* tree.h
*/
#ifndef TREE_H
#define TREE_H
#define MAXCHILDREN 3
#include "scanType.h"

typedef enum {DeclK, StmtK, ExpK} NodeKind;
typedef enum {VarDeclK, FuncDeclK, ParmK,} DeclKind;
typedef enum {CompoundK, IfK, WhileK, ForK, ReturnK, BreakK, RangeK} StmtKind;
typedef enum {AssignK, OpK, IdK, IdArrK, ConstantK, CallK,} ExpKind;
typedef enum {Void, Integer, Boolean, Char, String} ExpType;
typedef int OpKind;
struct TreeNode
{
    // connectivity in the tree
    struct TreeNode *child[MAXCHILDREN];    // children of the node
    struct TreeNode *sibling;               // siblings for the node

    // what kind of node
    int lineno;                             // linenum relevant to this node
    NodeKind nodekind;                      // type of node
    union                                   // subtype of type
    {
	    DeclKind DeclK;                     // used when DeclK
	    StmtKind StmtK;                     // used when StmtK
	    ExpKind ExpK;                       // used when ExpK
    } kind;
    
    // extra properties about the node depending on type of the node
    union                                   // relevant data to type -> attr
    {
        OpKind op;                          // type of token (same as in bison)
	    int value;                          // used when an integer constant or boolean
        unsigned char cvalue;               // used when a character
	    char *string;                       // used when a string constant
	    char *name;                         // used when IdK
    } attr;                                 
    bool isArray;                           // is this an array
    bool isStatic;                          // is staticly allocated?
    ExpType expType;		                // used when ExpK for type checking
    char *OpStr;                            // value of the operator as a string


    // even more semantic stuff will go here in later assignments.
};

TokenData *changeTokenType(TokenData *token);
TreeNode *setSibling(TreeNode *target, TreeNode *sibling);
TreeNode *setNodeType(ExpType type, TreeNode *t, bool isStatic);
TreeNode *createNewNode();
TreeNode *newDeclNode(DeclKind kind, ExpType type, TokenData *id, TreeNode *c1, TreeNode *c2, TreeNode *c3, bool isArray);
TreeNode *newStmtNode(StmtKind kind, TokenData *beginStmt, TokenData *id, TreeNode *c1, TreeNode *c2, TreeNode *c3);
TreeNode *newExpNode(ExpKind kind, TokenData *Op, TreeNode *c1, TreeNode *c2, TreeNode *c3);
void printTree(TreeNode *t, int level, int childNo, int siblingNo);
void printThisNode(TreeNode *t);
char* getTypeName(ExpType type);
char* getBoolVal(int boolVal);
char* getOpKind(OpKind op);
#endif