# C-Compiler
A C- compiler for the TinyMachine

**Compile**
Enter any of the assignment directories use make to compile the compiler. The output file will be called "c-"

**Testing**
the td directory contains all test data for the compiler at that stage. To test the compiler, invoke the C- compiler with the file name as its argument. [Ex. ./c- testProgram.c-]. The TinyMachine directory contains the TinyMachine VM. To test a compiled file on it, invoke the tm program with the file name as it's argument. [Ex. tm testProgram.tm].

**Compiler Options**
The c- compiler has several options. Use -p to print the parse tree generated during compilation (assignment 2+). -P will print the parse tree generated with additional typing information (assignment 3+). -M will print the parse tree generated with typing information and memory address calculations (assignment 6+). Using -d will print debugging information. 

