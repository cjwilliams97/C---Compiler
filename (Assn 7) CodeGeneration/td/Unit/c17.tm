* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/c17.c-
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
* Compound body
* EXPRESSION
 40:    LDC  3,5(6)	Load integer constant 
 41:    LDA  4,-1(0)	Load address of base of array x
 42:    SUB  3,4,3	compute location from index 
 43:     ST  3,-2(1)	Push left side (store variable address in frame) x
* TOFF dec: -3
 44:    LDC  3,333(6)	Load integer constant 
* TOFF inc: -2
 45:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 46:     LD  4,0(5)	Load left variable into ac1 (value) 
 47:     ST  3,0(5)	Store variable x
* EXPRESSION
 48:    LDC  3,7(6)	Load integer constant 
 49:    LDA  4,-9(0)	Load address of base of array y
 50:    SUB  3,4,3	compute location from index 
 51:     ST  3,-2(1)	Push left side (store variable address in frame) y
* TOFF dec: -3
 52:    LDC  3,444(6)	Load integer constant 
* TOFF inc: -2
 53:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 54:     LD  4,0(5)	Load left variable into ac1 (value) 
 55:     ST  3,0(5)	Store variable y
* EXPRESSION
 56:    LDC  3,5(6)	Load integer constant 
 57:    LDA  4,-1(0)	Load address of base of array x
 58:    SUB  3,4,3	compute location from index 
 59:     ST  3,-2(1)	Push left side (store variable address in frame) x
* TOFF dec: -3
 60:    LDC  3,7(6)	Load integer constant 
 61:    LDA  4,-9(0)	Load address of base of array y
 62:    SUB  3,4,3	compute location from index 
 63:     LD  3,0(3)	Load array element 
* TOFF inc: -2
 64:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 65:     LD  4,0(5)	Load left variable into ac1 (value) 
 66:    ADD  3,3,4	op += 
 67:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
 68:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
 69:    LDC  3,5(6)	Load integer constant 
 70:    LDA  4,-1(0)	Load address of base of array x
 71:    SUB  3,4,3	compute location from index 
 72:     LD  3,0(3)	Load array element 
 73:     ST  3,-4(1)	Push parameter x
* TOFF dec: -5
* Param end output
 74:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 75:    LDA  3,1(7)	Return address in ac 
 76:    JMP  7,-71(7)	CALL output
 77:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -2
* EXPRESSION
 78:    LDC  3,7(6)	Load integer constant 
 79:    LDA  4,-9(0)	Load address of base of array y
 80:    SUB  3,4,3	compute location from index 
 81:     ST  3,-2(1)	Push left side (store variable address in frame) y
* TOFF dec: -3
 82:    LDC  3,5(6)	Load integer constant 
 83:    LDA  4,-1(0)	Load address of base of array x
 84:    SUB  3,4,3	compute location from index 
 85:     LD  3,0(3)	Load array element 
* TOFF inc: -2
 86:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 87:     LD  4,0(5)	Load left variable into ac1 (value) 
 88:    SUB  3,4,3	op -= 
 89:     ST  3,0(5)	Store variable y
* EXPRESSION
* CALL output
 90:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
 91:    LDC  3,7(6)	Load integer constant 
 92:    LDA  4,-9(0)	Load address of base of array y
 93:    SUB  3,4,3	compute location from index 
 94:     LD  3,0(3)	Load array element 
 95:     ST  3,-4(1)	Push parameter y
* TOFF dec: -5
* Param end output
 96:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 97:    LDA  3,1(7)	Return address in ac 
 98:    JMP  7,-93(7)	CALL output
 99:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -2
* EXPRESSION
* CALL outnl
100:     ST  1,-2(1)	Store fp in ghost frame for outnl
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
101:    LDA  1,-2(1)	Ghost frame becomes new active frame 
102:    LDA  3,1(7)	Return address in ac 
103:    JMP  7,-70(7)	CALL outnl
104:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -2
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
105:    LDC  2,0(6)	Set return value to 0 
106:     LD  3,-1(1)	Load return address 
107:     LD  1,0(1)	Adjust fp 
108:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,108(7)	Jump to init [backpatch] 
* INIT
109:    LDA  1,-18(0)	set first frame at end of globals 
110:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
111:    LDC  3,7(6)	load size of array x
112:     ST  3,0(0)	save size of array x
113:    LDC  3,9(6)	load size of array y
114:     ST  3,-8(0)	save size of array y
* END INIT GLOBALS AND STATICS
115:    LDA  3,1(7)	Return address in ac 
116:    JMP  7,-78(7)	Jump to main 
117:   HALT  0,0,0	DONE! 
* END INIT
