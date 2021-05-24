* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/c0e.c-
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
 42:    LDC  3,1023(6)	Load integer constant 
* TOFF inc: -3
 43:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
 46:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
* EXPRESSION
 47:    LDA  3,-2(1)	Load variable (address) x
 48:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* TOFF inc: -5
 49:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 50:     LD  4,0(5)	Load left variable into ac1 (value) 
 51:    LDA  3,1(4)	increment value of x. Result in ac 
 52:     ST  3,0(5)	Store variable x
 53:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end output
 54:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 55:    LDA  3,1(7)	Return address in ac 
 56:    JMP  7,-51(7)	CALL output
 57:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* EXPRESSION
* CALL outnl
 58:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 59:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 60:    LDA  3,1(7)	Return address in ac 
 61:    JMP  7,-28(7)	CALL outnl
 62:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* EXPRESSION
* CALL output
 63:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 64:     LD  3,-2(1)	Load variable (value) x
 65:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end output
 66:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 67:    LDA  3,1(7)	Return address in ac 
 68:    JMP  7,-63(7)	CALL output
 69:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* EXPRESSION
* CALL outnl
 70:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 71:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 72:    LDA  3,1(7)	Return address in ac 
 73:    JMP  7,-40(7)	CALL outnl
 74:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* EXPRESSION
* CALL output
 75:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
* EXPRESSION
 76:    LDA  3,-2(1)	Load variable (address) x
 77:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* TOFF inc: -5
 78:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 79:     LD  4,0(5)	Load left variable into ac1 (value) 
 80:    LDA  3,-1,4	decrement value of x. Result in ac 
 81:     ST  3,0(5)	Store variable x
 82:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end output
 83:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 84:    LDA  3,1(7)	Return address in ac 
 85:    JMP  7,-80(7)	CALL output
 86:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* EXPRESSION
* CALL outnl
 87:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 88:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 89:    LDA  3,1(7)	Return address in ac 
 90:    JMP  7,-57(7)	CALL outnl
 91:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* EXPRESSION
* CALL output
 92:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 93:     LD  3,-2(1)	Load variable (value) x
 94:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end output
 95:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 96:    LDA  3,1(7)	Return address in ac 
 97:    JMP  7,-92(7)	CALL output
 98:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* EXPRESSION
* CALL outnl
 99:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
100:    LDA  1,-3(1)	Ghost frame becomes new active frame 
101:    LDA  3,1(7)	Return address in ac 
102:    JMP  7,-69(7)	CALL outnl
103:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
104:    LDC  2,0(6)	Set return value to 0 
105:     LD  3,-1(1)	Load return address 
106:     LD  1,0(1)	Adjust fp 
107:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,107(7)	Jump to init [backpatch] 
* INIT
108:    LDA  1,0(0)	set first frame at end of globals 
109:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
110:    LDA  3,1(7)	Return address in ac 
111:    JMP  7,-73(7)	Jump to main 
112:   HALT  0,0,0	DONE! 
* END INIT
