* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/a09.c-
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
 40:    LDA  3,0(0)	Load variable (address) x
 41:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 42:    LDC  3,88(6)	Load char constant 
* TOFF inc: -3
 43:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:     ST  3,0(5)	Store variable x
* EXPRESSION
 46:    LDA  3,-2(1)	Load variable (address) y
 47:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 48:    LDC  3,89(6)	Load char constant 
* TOFF inc: -3
 49:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 50:     LD  4,0(5)	Load left variable into ac1 (value) 
 51:     ST  3,0(5)	Store variable y
* EXPRESSION
* CALL outputc
 52:     ST  1,-3(1)	Store fp in ghost frame for outputc
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 53:     LD  3,0(0)	Load variable (value) x
 54:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end outputc
 55:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 56:    LDA  3,1(7)	Return address in ac 
 57:    JMP  7,-30(7)	CALL outputc
 58:    LDA  3,0(2)	Save the result in ac 
* Call end outputc
* TOFF set: -3
* EXPRESSION
* CALL outnl
 59:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 60:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 61:    LDA  3,1(7)	Return address in ac 
 62:    JMP  7,-29(7)	CALL outnl
 63:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* EXPRESSION
* CALL outputc
 64:     ST  1,-3(1)	Store fp in ghost frame for outputc
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 65:     LD  3,-2(1)	Load variable (value) y
 66:     ST  3,-5(1)	Push parameter 
* TOFF dec: -6
* Param end outputc
 67:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 68:    LDA  3,1(7)	Return address in ac 
 69:    JMP  7,-42(7)	CALL outputc
 70:    LDA  3,0(2)	Save the result in ac 
* Call end outputc
* TOFF set: -3
* EXPRESSION
* CALL outnl
 71:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 72:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 73:    LDA  3,1(7)	Return address in ac 
 74:    JMP  7,-41(7)	CALL outnl
 75:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 76:    LDC  2,0(6)	Set return value to 0 
 77:     LD  3,-1(1)	Load return address 
 78:     LD  1,0(1)	Adjust fp 
 79:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,79(7)	Jump to init [backpatch] 
* INIT
 80:    LDA  1,-1(0)	set first frame at end of globals 
 81:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 82:    LDA  3,1(7)	Return address in ac 
 83:    JMP  7,-45(7)	Jump to main 
 84:   HALT  0,0,0	DONE! 
* END INIT
