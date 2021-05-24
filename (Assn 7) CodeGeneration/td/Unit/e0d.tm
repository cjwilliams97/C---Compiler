* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/e0d.c-
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
* TOFF set: -4
* Compound Body
* Compound body
* EXPRESSION
 40:    LDA  3,-2(1)	Load variable (address) x
 41:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 42:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -4
 43:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:     ST  3,0(5)	Store variable x
* WHILE
* EXPRESSION
 46:    LDA  3,-2(1)	Load variable (address) x
 47:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 48:    LDC  3,6(6)	Load integer constant 
* TOFF inc: -4
 49:     LD  5,-4(1)	Pop left into ac2 (address) 
 50:     LD  4,0(5)	Load left variable into ac1 (value) 
 51:    TLT  3,4,3	Op < 
 52:    JNZ  3,1(7)	Jump to while part 
* DO
* Compound body
* EXPRESSION
 54:    LDA  3,-3(1)	Load variable (address) y
 55:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 56:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -4
 57:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 58:     LD  4,0(5)	Load left variable into ac1 (value) 
 59:     ST  3,0(5)	Store variable y
* WHILE
* EXPRESSION
 60:    LDA  3,-3(1)	Load variable (address) y
 61:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 62:    LDC  3,6(6)	Load integer constant 
* TOFF inc: -4
 63:     LD  5,-4(1)	Pop left into ac2 (address) 
 64:     LD  4,0(5)	Load left variable into ac1 (value) 
 65:    TLT  3,4,3	Op < 
 66:    JNZ  3,1(7)	Jump to while part 
* DO
* Compound body
* EXPRESSION
* CALL output
 68:     ST  1,-4(1)	Store fp in ghost frame for output
* TOFF dec: -5
* TOFF dec: -6
* Param 1
 69:     LD  3,-3(1)	Load variable (value) y
 70:     ST  3,-6(1)	Push parameter 
* TOFF dec: -7
* Param end output
 71:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 72:    LDA  3,1(7)	Return address in ac 
 73:    JMP  7,-68(7)	CALL output
 74:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -4
* IF
* EXPRESSION
 75:    LDA  3,-3(1)	Load variable (address) y
 76:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 77:    LDC  3,4(6)	Load integer constant 
* TOFF inc: -4
 78:     LD  5,-4(1)	Pop left into ac2 (address) 
 79:     LD  4,0(5)	Load left variable into ac1 (value) 
 80:    TEQ  3,4,3	Op == 
* THEN
* BREAK
 82:    JMP  7,-16(7)	break 
 81:    JZR  3,1(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
 83:    LDA  3,-3(1)	Load variable (address) y
 84:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
* EXPRESSION
 85:    LDA  3,-3(1)	Load variable (address) y
 86:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 87:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -5
 88:     LD  5,-5(1)	Pop left into ac2 (address) 
 89:     LD  4,0(5)	Load left variable into ac1 (value) 
 90:    ADD  3,4,3	Op + 
* TOFF inc: -4
 91:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 92:     LD  4,0(5)	Load left variable into ac1 (value) 
 93:     ST  3,0(5)	Store variable y
* TOFF set: -4
* END COMPOUND
 94:    JMP  7,-35(7)	go to beginning of loop 
 67:    JMP  7,27(7)	Jump past loop [backpatch] 
* END WHILE
* EXPRESSION
* CALL output
 95:     ST  1,-4(1)	Store fp in ghost frame for output
* TOFF dec: -5
* TOFF dec: -6
* Param 1
 96:     LD  3,-2(1)	Load variable (value) x
 97:     ST  3,-6(1)	Push parameter 
* TOFF dec: -7
* Param end output
 98:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 99:    LDA  3,1(7)	Return address in ac 
100:    JMP  7,-95(7)	CALL output
101:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -4
* IF
* EXPRESSION
102:    LDA  3,-2(1)	Load variable (address) x
103:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
104:    LDC  3,4(6)	Load integer constant 
* TOFF inc: -4
105:     LD  5,-4(1)	Pop left into ac2 (address) 
106:     LD  4,0(5)	Load left variable into ac1 (value) 
107:    TEQ  3,4,3	Op == 
* THEN
* BREAK
109:    JMP  7,-57(7)	break 
108:    JZR  3,1(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
110:    LDA  3,-2(1)	Load variable (address) x
111:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
* EXPRESSION
112:    LDA  3,-2(1)	Load variable (address) x
113:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
114:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -5
115:     LD  5,-5(1)	Pop left into ac2 (address) 
116:     LD  4,0(5)	Load left variable into ac1 (value) 
117:    ADD  3,4,3	Op + 
* TOFF inc: -4
118:     LD  5,-4(1)	Pop left into ac2 (variable address) 
119:     LD  4,0(5)	Load left variable into ac1 (value) 
120:     ST  3,0(5)	Store variable x
* TOFF set: -4
* END COMPOUND
121:    JMP  7,-76(7)	go to beginning of loop 
 53:    JMP  7,68(7)	Jump past loop [backpatch] 
* END WHILE
* TOFF set: 0
* END COMPOUND
* Add standard closing in case there is no return statement
122:    LDC  2,0(6)	Set return value to 0 
123:     LD  3,-1(1)	Load return address 
124:     LD  1,0(1)	Adjust fp 
125:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,125(7)	Jump to init [backpatch] 
* INIT
126:    LDA  1,0(0)	set first frame at end of globals 
127:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
128:    LDA  3,1(7)	Return address in ac 
129:    JMP  7,-91(7)	Jump to main 
130:   HALT  0,0,0	DONE! 
* END INIT
