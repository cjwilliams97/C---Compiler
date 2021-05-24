* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/h04.c-
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
* FUNCTION cat
* TOFF set -3
 39:     ST  3,-1(1)	Store return address 
* Compound body
* EXPRESSION
* CALL output
 40:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 41:    LDC  3,3(6)	Load integer constant 
 42:     LD  4,-2(1)	Load address of base of array x
 43:    SUB  3,4,3	compute location from index 
 44:     LD  3,0(3)	Load array element 
 45:     ST  3,-5(1)	Push parameter x
* TOFF dec: -6
* Param end output
 46:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 47:    LDA  3,1(7)	Return address in ac 
 48:    JMP  7,-43(7)	CALL output
* Call end output
* TOFF set: -3
 49:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
 50:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 51:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 52:    LDA  3,1(7)	Return address in ac 
 53:    JMP  7,-20(7)	CALL outnl
* Call end outnl
* TOFF set: -3
 54:    LDA  3,0(2)	Save the result in ac 
* IF
* EXPRESSION
 55:    LDC  3,3(6)	Load integer constant 
 56:     LD  4,-2(1)	Load address of base of array x
 57:    SUB  3,4,3	compute location from index 
 58:     ST  3,-3(1)	Push left side (store variable address in frame) x
* TOFF dec: -4
 59:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -3
 60:     LD  5,-3(1)	Pop left into ac2 (address) 
 61:     LD  4,0(5)	Load left variable into ac1 (value) 
 62:    TGT  3,4,3	Op > 
* THEN
* COMPOUND
* TOFF set: -3
* Compound Body
* Compound body
* EXPRESSION
 64:    LDC  3,3(6)	Load integer constant 
 65:     LD  4,-2(1)	Load address of base of array x
 66:    SUB  3,4,3	compute location from index 
 67:     ST  3,-3(1)	Push left side (store variable address in frame) x
* TOFF dec: -4
* EXPRESSION
 68:    LDC  3,3(6)	Load integer constant 
 69:     LD  4,-2(1)	Load address of base of array x
 70:    SUB  3,4,3	compute location from index 
 71:     ST  3,-4(1)	Push left side (store variable address in frame) x
* TOFF dec: -5
 72:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -4
 73:     LD  5,-4(1)	Pop left into ac2 (address) 
 74:     LD  4,0(5)	Load left variable into ac1 (value) 
 75:    SUB  3,4,3	Op - 
* TOFF inc: -3
 76:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 77:     LD  4,0(5)	Load left variable into ac1 (value) 
 78:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL cat
 79:     ST  1,-3(1)	Store fp in ghost frame for cat
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 80:     LD  3,-2(1)	Load address of base of array x
 81:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end cat
 82:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 83:    LDA  3,1(7)	Return address in ac 
 84:    JMP  7,-46(7)	CALL cat
* Call end cat
* TOFF set: -3
 85:    LDA  3,0(2)	Save the result in ac 
* TOFF set: -3
* END COMPOUND
 63:    JZR  3,22(7)	Jump around the THEN if false [backpatch] 
* RETURN
* No return value. Return 0
 86:    LDC  2,0(6)	Set return value to 0 
 87:     LD  3,-1(1)	Load return address 
 88:     LD  1,0(1)	Adjust fp 
 89:    JMP  7,0(3)	Return 
* TOFF set: -3
* END COMPOUND
* Add standard closing in case there is no return statement
 90:    LDC  2,0(6)	Set return value to 0 
 91:     LD  3,-1(1)	Load return address 
 92:     LD  1,0(1)	Adjust fp 
 93:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION cat
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
 94:     ST  3,-1(1)	Store return address 
* Compound body
* EXPRESSION
 95:    LDC  3,3(6)	Load integer constant 
 96:    LDA  4,-1(0)	Load address of base of array x
 97:    SUB  3,4,3	compute location from index 
 98:     ST  3,-2(1)	Push left side (store variable address in frame) x
* TOFF dec: -3
 99:    LDC  3,12(6)	Load integer constant 
* TOFF inc: -2
100:     LD  5,-2(1)	Pop left into ac2 (variable address) 
101:     LD  4,0(5)	Load left variable into ac1 (value) 
102:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL cat
103:     ST  1,-2(1)	Store fp in ghost frame for cat
* TOFF dec: -3
* TOFF dec: -4
* Param 1
104:    LDA  3,-1(0)	Load address of base of array x
105:     ST  3,-4(1)	Push parameter 
* TOFF dec: -5
* Param end cat
106:    LDA  1,-2(1)	Ghost frame becomes new active frame 
107:    LDA  3,1(7)	Return address in ac 
108:    JMP  7,-70(7)	CALL cat
* Call end cat
* TOFF set: -2
109:    LDA  3,0(2)	Save the result in ac 
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
110:    LDC  2,0(6)	Set return value to 0 
111:     LD  3,-1(1)	Load return address 
112:     LD  1,0(1)	Adjust fp 
113:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,113(7)	Jump to init [backpatch] 
* INIT
114:    LDA  1,-19(0)	set first frame at end of globals 
115:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
116:    LDC  3,18(6)	load size of array x
117:     ST  3,0(0)	save size of array x
* END INIT GLOBALS AND STATICS
118:    LDA  3,1(7)	Return address in ac 
119:    JMP  7,-26(7)	Jump to main 
120:   HALT  0,0,0	DONE! 
* END INIT
