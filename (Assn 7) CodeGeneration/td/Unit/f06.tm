* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/f06.c-
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
* TOFF set -2
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -2
* Compound Body
* Compound body
* RETURN
 40:    LDC  3,1(6)	Load Boolean constant 
 41:    LDA  2,0(3)	Copy result to return register 
 42:     LD  3,-1(1)	Load return address 
 43:     LD  1,0(1)	Adjust fp 
 44:    JMP  7,0(3)	Return 
* TOFF set: 0
* END COMPOUND
* Add standard closing in case there is no return statement
 45:    LDC  2,0(6)	Set return value to 0 
 46:     LD  3,-1(1)	Load return address 
 47:     LD  1,0(1)	Adjust fp 
 48:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION cat
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
 49:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -3
* Compound Body
* Compound body
* EXPRESSION
 50:    LDA  3,-2(1)	Load variable (address) x
 51:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
* EXPRESSION
* EXPRESSION
* CALL cat
 52:     ST  1,-4(1)	Store fp in ghost frame for cat
* TOFF dec: -5
* TOFF dec: -6
* Param end cat
 53:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 54:    LDA  3,1(7)	Return address in ac 
 55:    JMP  7,-17(7)	CALL cat
* Call end cat
* TOFF set: -4
 56:     ST  2,-4(1)	Push left side (store return value in temp loc in frame) 
* TOFF dec: -5
 57:    LDC  3,0(6)	Load Boolean constant 
* TOFF inc: -4
 58:     LD  4,-4(1)	Pop left into ac1 (const value) 
 59:    AND  3,4,3	Op AND 
* TOFF inc: -3
 60:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 61:     LD  4,0(5)	Load left variable into ac1 (value) 
 62:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL outputb
 63:     ST  1,-3(1)	Store fp in ghost frame for outputb
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 64:     LD  3,-2(1)	Load variable (value) x
 65:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end outputb
 66:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 67:    LDA  3,1(7)	Return address in ac 
 68:    JMP  7,-52(7)	CALL outputb
* Call end outputb
* TOFF set: -3
 69:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
 70:    LDA  3,-2(1)	Load variable (address) x
 71:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
* EXPRESSION
* EXPRESSION
* CALL cat
 72:     ST  1,-4(1)	Store fp in ghost frame for cat
* TOFF dec: -5
* TOFF dec: -6
* Param end cat
 73:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 74:    LDA  3,1(7)	Return address in ac 
 75:    JMP  7,-37(7)	CALL cat
* Call end cat
* TOFF set: -4
 76:     ST  2,-4(1)	Push left side (store return value in temp loc in frame) 
* TOFF dec: -5
 77:    LDC  3,0(6)	Load Boolean constant 
* TOFF inc: -4
 78:     LD  4,-4(1)	Pop left into ac1 (const value) 
 79:     OR  3,4,3	Op OR 
* TOFF inc: -3
 80:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 81:     LD  4,0(5)	Load left variable into ac1 (value) 
 82:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL outputb
 83:     ST  1,-3(1)	Store fp in ghost frame for outputb
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 84:     LD  3,-2(1)	Load variable (value) x
 85:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end outputb
 86:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 87:    LDA  3,1(7)	Return address in ac 
 88:    JMP  7,-72(7)	CALL outputb
* Call end outputb
* TOFF set: -3
 89:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
 90:    LDA  3,-2(1)	Load variable (address) x
 91:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
* EXPRESSION
* EXPRESSION
* CALL cat
 92:     ST  1,-4(1)	Store fp in ghost frame for cat
* TOFF dec: -5
* TOFF dec: -6
* Param end cat
 93:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 94:    LDA  3,1(7)	Return address in ac 
 95:    JMP  7,-57(7)	CALL cat
* Call end cat
* TOFF set: -4
 96:    LDA  3,0(2)	Save the result in ac 
 97:    LDC  4,1(6)	Load 1 
 98:    XOR  3,3,4	Op XOR to get logical not 
* TOFF inc: -3
 99:     LD  5,-3(1)	Pop left into ac2 (variable address) 
100:     LD  4,0(5)	Load left variable into ac1 (value) 
101:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL outputb
102:     ST  1,-3(1)	Store fp in ghost frame for outputb
* TOFF dec: -4
* TOFF dec: -5
* Param 1
103:     LD  3,-2(1)	Load variable (value) x
104:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end outputb
105:    LDA  1,-3(1)	Ghost frame becomes new active frame 
106:    LDA  3,1(7)	Return address in ac 
107:    JMP  7,-91(7)	CALL outputb
* Call end outputb
* TOFF set: -3
108:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
109:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
110:    LDA  1,-3(1)	Ghost frame becomes new active frame 
111:    LDA  3,1(7)	Return address in ac 
112:    JMP  7,-79(7)	CALL outnl
* Call end outnl
* TOFF set: -3
113:    LDA  3,0(2)	Save the result in ac 
* TOFF set: 0
* END COMPOUND
* Add standard closing in case there is no return statement
114:    LDC  2,0(6)	Set return value to 0 
115:     LD  3,-1(1)	Load return address 
116:     LD  1,0(1)	Adjust fp 
117:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,117(7)	Jump to init [backpatch] 
* INIT
118:    LDA  1,0(0)	set first frame at end of globals 
119:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
120:    LDA  3,1(7)	Return address in ac 
121:    JMP  7,-73(7)	Jump to main 
122:   HALT  0,0,0	DONE! 
* END INIT
