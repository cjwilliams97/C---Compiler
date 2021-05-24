* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/e02.c-
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION input
  1:     ST  3,-1(1)	Store return address 
  2:     IN  2,2,2	Grab int input 
  3:     LD  3,-1(1)	Load return address 
  4:     LD  1,0(1)	Adjust fp 
  5:    JMP  7,0(3)	Return 
* END FUNCTION input
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION output
  6:     ST  3,-1(1)	Store return address 
  7:     LD  3,-2(1)	Load parameter 
  8:    OUT  3,3,3	Output int 
  9:     LD  3,-1(1)	Load return address 
 10:     LD  1,0(1)	Adjust fp 
 11:    JMP  7,0(3)	Return 
* END FUNCTION output
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputb
 12:     ST  3,-1(1)	Store return address 
 13:    INB  2,2,2	Grab bool input 
 14:     LD  3,-1(1)	Load return address 
 15:     LD  1,0(1)	Adjust fp 
 16:    JMP  7,0(3)	Return 
* END FUNCTION inputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputb
 17:     ST  3,-1(1)	Store return address 
 18:     LD  3,-2(1)	Load parameter 
 19:   OUTB  3,3,3	Output int 
 20:     LD  3,-1(1)	Load return address 
 21:     LD  1,0(1)	Adjust fp 
 22:    JMP  7,0(3)	Return 
* END FUNCTION outputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputc
 23:     ST  3,-1(1)	Store return address 
 24:    INC  2,2,2	Grab char input 
 25:     LD  3,-1(1)	Load return address 
 26:     LD  1,0(1)	Adjust fp 
 27:    JMP  7,0(3)	Return 
* END FUNCTION inputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputc
 28:     ST  3,-1(1)	Store return address 
 29:     LD  3,-2(1)	Load parameter 
 30:   OUTC  3,3,3	Output int 
 31:     LD  3,-1(1)	Load return address 
 32:     LD  1,0(1)	Adjust fp 
 33:    JMP  7,0(3)	Return 
* END FUNCTION outputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outnl
 34:     ST  3,-1(1)	Store return address 
 35:  OUTNL  3,3,3	Output a newLine 
 36:     LD  3,-1(1)	Load return address 
 37:     LD  1,0(1)	Adjust fp 
 38:    JMP  7,0(3)	Return 
* END FUNCTION outnl
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -3
* Compound Body
* Compound body
* EXPRESSION
 40:    LDA  3,-2(1)	Load variable (address) x
 41:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 42:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -3
 43:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:     ST  3,0(5)	Store variable x
* WHILE
* EXPRESSION
 46:    LDA  3,-2(1)	Load variable (address) x
 47:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 48:    LDC  3,10(6)	Load integer constant 
* TOFF inc: -3
 49:     LD  5,-3(1)	Pop left into ac2 (address) 
 50:     LD  4,0(5)	Load left variable into ac1 (value) 
 51:    TLT  3,4,3	Op < 
 52:    JNZ  3,1(7)	Jump to while part 
* DO
* Compound body
* EXPRESSION
* CALL output
 54:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 55:     LD  3,-2(1)	Load variable (value) x
 56:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end output
 57:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 58:    LDA  3,1(7)	Return address in ac 
 59:    JMP  7,-54(7)	CALL output
 60:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* EXPRESSION
 61:    LDA  3,-2(1)	Load variable (address) x
 62:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
* EXPRESSION
 63:    LDA  3,-2(1)	Load variable (address) x
 64:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 65:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -4
 66:     LD  5,-4(1)	Pop left into ac2 (address) 
 67:     LD  4,0(5)	Load left variable into ac1 (value) 
 68:    ADD  3,4,3	Op + 
* TOFF inc: -3
 69:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 70:     LD  4,0(5)	Load left variable into ac1 (value) 
 71:     ST  3,0(5)	Store variable x
* TOFF set: -3
* END COMPOUND
 72:    JMP  7,-27(7)	go to beginning of loop 
 53:    JMP  7,19(7)	Jump past loop [backpatch] 
* END WHILE
* EXPRESSION
 73:    LDA  3,-2(1)	Load variable (address) x
 74:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 75:    LDC  3,30(6)	Load integer constant 
* TOFF inc: -3
 76:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 77:     LD  4,0(5)	Load left variable into ac1 (value) 
 78:     ST  3,0(5)	Store variable x
* WHILE
* EXPRESSION
 79:    LDA  3,-2(1)	Load variable (address) x
 80:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 81:    LDC  3,10(6)	Load integer constant 
* TOFF inc: -3
 82:     LD  5,-3(1)	Pop left into ac2 (address) 
 83:     LD  4,0(5)	Load left variable into ac1 (value) 
 84:    TLT  3,4,3	Op < 
 85:    JNZ  3,1(7)	Jump to while part 
* DO
* Compound body
* EXPRESSION
* CALL output
 87:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 88:     LD  3,-2(1)	Load variable (value) x
 89:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end output
 90:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 91:    LDA  3,1(7)	Return address in ac 
 92:    JMP  7,-87(7)	CALL output
 93:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* EXPRESSION
 94:    LDA  3,-2(1)	Load variable (address) x
 95:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
* EXPRESSION
 96:    LDA  3,-2(1)	Load variable (address) x
 97:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 98:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -4
 99:     LD  5,-4(1)	Pop left into ac2 (address) 
100:     LD  4,0(5)	Load left variable into ac1 (value) 
101:    ADD  3,4,3	Op + 
* TOFF inc: -3
102:     LD  5,-3(1)	Pop left into ac2 (variable address) 
103:     LD  4,0(5)	Load left variable into ac1 (value) 
104:     ST  3,0(5)	Store variable x
* TOFF set: -3
* END COMPOUND
105:    JMP  7,-27(7)	go to beginning of loop 
 86:    JMP  7,19(7)	Jump past loop [backpatch] 
* END WHILE
* TOFF set: 0
* END COMPOUND
* Add standard closing in case there is no return statement
106:    LDC  2,0(6)	Set return value to 0 
107:     LD  3,-1(1)	Load return address 
108:     LD  1,0(1)	Adjust fp 
109:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,109(7)	Jump to init [backpatch] 
* INIT
110:    LDA  1,0(0)	set first frame at end of globals 
111:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
112:    LDA  3,1(7)	Return address in ac 
113:    JMP  7,-75(7)	Jump to main 
114:   HALT  0,0,0	DONE! 
* END INIT
