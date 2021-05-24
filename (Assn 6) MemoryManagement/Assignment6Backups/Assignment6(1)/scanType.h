#ifndef SCANTYPE_H
#define SCANTYPE_H
struct TokenData {
    int tokenclass;  // token class
    int linenum;     // what line did this token occur on?
    char *tokenstr;
    int numValue; // the value of the number as an INT!
    char *processedStr;
};

#endif
