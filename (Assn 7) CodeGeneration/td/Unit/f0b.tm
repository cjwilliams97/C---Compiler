* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: f0b.c-
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
* EXPRESSION
* CALL output
 40:     ST  1,-2(1)	Store fp in ghost frame for outputs 
* TOFF dec: -3
* TOFF dec: -4
* Param 1
 41:     LD  3,-1(0)	Load variable (value) z
 42:     ST  3,-4(1)	Push parameter 
* TOFF dec: -5
* Param end output
 43:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 44:    LDA  3,1(7)	Return address in ac 
 45:    JMP  7,-40(7)	CALL output
 46:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -2
* EXPRESSION
 47:    LDA  3,-1(0)	Load variable (address) z
 48:     ST  3,-2(1)	Push left side (store variable address in frame) 
* TOFF dec: -3
 49:    LDC  3,99(6)	Load integer constant 
* TOFF inc: -2
 50:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 51:     LD  4,0(5)	Load left variable into ac1 (value) 
 52:     ST  3,0(5)	Store variable z
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 53:    LDC  2,0(6)	Set return value to 0 
 54:     LD  3,-1(1)	Load return address 
 55:     LD  1,0(1)	Adjust fp 
 56:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION cat
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
 57:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -2
* Compound Body
* Compound body
* EXPRESSION
 58:    LDA  3,-1(0)	Load variable (address) z
 59:     ST  3,-2(1)	Push left side (store variable address in frame) 
* TOFF dec: -3
 60:    LDC  3,1001(6)	Load integer constant 
* TOFF inc: -2
 61:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 62:     LD  4,0(5)	Load left variable into ac1 (value) 
 63:     ST  3,0(5)	Store variable z
* EXPRESSION
* CALL cat
 64:     ST  1,-2(1)	Store fp in ghost frame for outputs 
* TOFF dec: -3
* TOFF dec: -4
* Param end cat
 65:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 66:    LDA  3,1(7)	Return address in ac 
 67:    JMP  7,-29(7)	CALL cat
 68:    LDA  3,0(2)	Save the result in ac 
* Call end cat
* TOFF set: -2
* EXPRESSION
* CALL output
 69:     ST  1,-2(1)	Store fp in ghost frame for outputs 
* TOFF dec: -3
* TOFF dec: -4
* Param 1
 70:     LD  3,-1(0)	Load variable (value) z
 71:     ST  3,-4(1)	Push parameter 
* TOFF dec: -5
* Param end output
 72:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 73:    LDA  3,1(7)	Return address in ac 
 74:    JMP  7,-69(7)	CALL output
 75:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -2
* EXPRESSION
* CALL outnl
 76:     ST  1,-2(1)	Store fp in ghost frame for outputs 
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
 77:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 78:    LDA  3,1(7)	Return address in ac 
 79:    JMP  7,-46(7)	CALL outnl
 80:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -2
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 81:    LDC  2,0(6)	Set return value to 0 
 82:     LD  3,-1(1)	Load return address 
 83:     LD  1,0(1)	Adjust fp 
 84:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,84(7)	Jump to init [backpatch] 
* INIT
 85:    LDA  1,-2(0)	set first frame at end of globals 
 86:     ST  1,0(0)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 87:    LDA  3,1(7)	Return address in ac 
 88:    JMP  7,-32(7)	Jump to main 
 89:   HALT  0,0,0	DONE! 
* END INIT
