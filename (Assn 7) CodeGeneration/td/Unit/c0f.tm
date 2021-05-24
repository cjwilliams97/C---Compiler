* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/c0f.c-
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
* TOFF set: -2
* Compound Body
 40:    LDC  3,7(6)	load size of array x
 41:     ST  3,-2(1)	save size of array x
* Compound body
* EXPRESSION
 42:    LDC  3,3(6)	Load integer constant 
 43:    LDA  4,-3(1)	Load address of base of array x
 44:    SUB  3,4,3	compute location from index 
 45:     ST  3,-2(1)	Push left side (store variable address in frame) x
* TOFF dec: -3
 46:    LDC  3,1023(6)	Load integer constant 
* TOFF inc: -2
 47:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 48:     LD  4,0(5)	Load left variable into ac1 (value) 
 49:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
 50:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
* EXPRESSION
 51:    LDC  3,3(6)	Load integer constant 
 52:    LDA  4,-3(1)	Load address of base of array x
 53:    SUB  3,4,3	compute location from index 
 54:     ST  3,-4(1)	Push left side (store variable address in frame) x
* TOFF dec: -5
* TOFF inc: -4
 55:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 56:     LD  4,0(5)	Load left variable into ac1 (value) 
 57:    LDA  3,1(4)	increment value of x. Result in ac 
 58:     ST  3,0(5)	Store variable x
 59:     ST  3,-4(1)	Push parameter 
* TOFF dec: -5
* Param end output
 60:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 61:    LDA  3,1(7)	Return address in ac 
 62:    JMP  7,-57(7)	CALL output
* Call end output
* TOFF set: -2
 63:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
 64:     ST  1,-2(1)	Store fp in ghost frame for outnl
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
 65:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 66:    LDA  3,1(7)	Return address in ac 
 67:    JMP  7,-34(7)	CALL outnl
* Call end outnl
* TOFF set: -2
 68:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL output
 69:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
 70:    LDC  3,3(6)	Load integer constant 
 71:    LDA  4,-3(1)	Load address of base of array x
 72:    SUB  3,4,3	compute location from index 
 73:     LD  3,0(3)	Load array element 
 74:     ST  3,-4(1)	Push parameter x
* TOFF dec: -5
* Param end output
 75:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 76:    LDA  3,1(7)	Return address in ac 
 77:    JMP  7,-72(7)	CALL output
* Call end output
* TOFF set: -2
 78:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
 79:     ST  1,-2(1)	Store fp in ghost frame for outnl
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
 80:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 81:    LDA  3,1(7)	Return address in ac 
 82:    JMP  7,-49(7)	CALL outnl
* Call end outnl
* TOFF set: -2
 83:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL output
 84:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
* EXPRESSION
 85:    LDC  3,3(6)	Load integer constant 
 86:    LDA  4,-3(1)	Load address of base of array x
 87:    SUB  3,4,3	compute location from index 
 88:     ST  3,-4(1)	Push left side (store variable address in frame) x
* TOFF dec: -5
* TOFF inc: -4
 89:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 90:     LD  4,0(5)	Load left variable into ac1 (value) 
 91:    LDA  3,-1,4	decrement value of x. Result in ac 
 92:     ST  3,0(5)	Store variable x
 93:     ST  3,-4(1)	Push parameter 
* TOFF dec: -5
* Param end output
 94:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 95:    LDA  3,1(7)	Return address in ac 
 96:    JMP  7,-91(7)	CALL output
* Call end output
* TOFF set: -2
 97:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
 98:     ST  1,-2(1)	Store fp in ghost frame for outnl
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
 99:    LDA  1,-2(1)	Ghost frame becomes new active frame 
100:    LDA  3,1(7)	Return address in ac 
101:    JMP  7,-68(7)	CALL outnl
* Call end outnl
* TOFF set: -2
102:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL output
103:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
104:    LDC  3,3(6)	Load integer constant 
105:    LDA  4,-3(1)	Load address of base of array x
106:    SUB  3,4,3	compute location from index 
107:     LD  3,0(3)	Load array element 
108:     ST  3,-4(1)	Push parameter x
* TOFF dec: -5
* Param end output
109:    LDA  1,-2(1)	Ghost frame becomes new active frame 
110:    LDA  3,1(7)	Return address in ac 
111:    JMP  7,-106(7)	CALL output
* Call end output
* TOFF set: -2
112:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
113:     ST  1,-2(1)	Store fp in ghost frame for outnl
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
114:    LDA  1,-2(1)	Ghost frame becomes new active frame 
115:    LDA  3,1(7)	Return address in ac 
116:    JMP  7,-83(7)	CALL outnl
* Call end outnl
* TOFF set: -2
117:    LDA  3,0(2)	Save the result in ac 
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
118:    LDC  2,0(6)	Set return value to 0 
119:     LD  3,-1(1)	Load return address 
120:     LD  1,0(1)	Adjust fp 
121:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,121(7)	Jump to init [backpatch] 
* INIT
122:    LDA  1,0(0)	set first frame at end of globals 
123:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
124:    LDA  3,1(7)	Return address in ac 
125:    JMP  7,-87(7)	Jump to main 
126:   HALT  0,0,0	DONE! 
* END INIT
