* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/e03.c-
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
* BREAK
 61:    JMP  7,-9(7)	break 
* EXPRESSION
 62:    LDA  3,-2(1)	Load variable (address) x
 63:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
* EXPRESSION
 64:    LDA  3,-2(1)	Load variable (address) x
 65:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 66:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -4
 67:     LD  5,-4(1)	Pop left into ac2 (address) 
 68:     LD  4,0(5)	Load left variable into ac1 (value) 
 69:    ADD  3,4,3	Op + 
* TOFF inc: -3
 70:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 71:     LD  4,0(5)	Load left variable into ac1 (value) 
 72:     ST  3,0(5)	Store variable x
* TOFF set: -3
* END COMPOUND
 73:    JMP  7,-28(7)	go to beginning of loop 
 53:    JMP  7,20(7)	Jump past loop [backpatch] 
* END WHILE
* EXPRESSION
 74:    LDA  3,-2(1)	Load variable (address) x
 75:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 76:    LDC  3,30(6)	Load integer constant 
* TOFF inc: -3
 77:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 78:     LD  4,0(5)	Load left variable into ac1 (value) 
 79:     ST  3,0(5)	Store variable x
* WHILE
* EXPRESSION
 80:    LDA  3,-2(1)	Load variable (address) x
 81:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 82:    LDC  3,10(6)	Load integer constant 
* TOFF inc: -3
 83:     LD  5,-3(1)	Pop left into ac2 (address) 
 84:     LD  4,0(5)	Load left variable into ac1 (value) 
 85:    TLT  3,4,3	Op < 
 86:    JNZ  3,1(7)	Jump to while part 
* DO
* Compound body
* EXPRESSION
* CALL output
 88:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 89:     LD  3,-2(1)	Load variable (value) x
 90:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end output
 91:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 92:    LDA  3,1(7)	Return address in ac 
 93:    JMP  7,-88(7)	CALL output
 94:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* BREAK
 95:    JMP  7,-9(7)	break 
* EXPRESSION
 96:    LDA  3,-2(1)	Load variable (address) x
 97:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
* EXPRESSION
 98:    LDA  3,-2(1)	Load variable (address) x
 99:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
100:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -4
101:     LD  5,-4(1)	Pop left into ac2 (address) 
102:     LD  4,0(5)	Load left variable into ac1 (value) 
103:    ADD  3,4,3	Op + 
* TOFF inc: -3
104:     LD  5,-3(1)	Pop left into ac2 (variable address) 
105:     LD  4,0(5)	Load left variable into ac1 (value) 
106:     ST  3,0(5)	Store variable x
* TOFF set: -3
* END COMPOUND
107:    JMP  7,-28(7)	go to beginning of loop 
 87:    JMP  7,20(7)	Jump past loop [backpatch] 
* END WHILE
* TOFF set: 0
* END COMPOUND
* Add standard closing in case there is no return statement
108:    LDC  2,0(6)	Set return value to 0 
109:     LD  3,-1(1)	Load return address 
110:     LD  1,0(1)	Adjust fp 
111:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,111(7)	Jump to init [backpatch] 
* INIT
112:    LDA  1,0(0)	set first frame at end of globals 
113:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
114:    LDA  3,1(7)	Return address in ac 
115:    JMP  7,-77(7)	Jump to main 
116:   HALT  0,0,0	DONE! 
* END INIT
