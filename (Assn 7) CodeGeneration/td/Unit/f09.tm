* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/f09.c-
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
 40:    LDC  3,93(6)	Load integer constant 
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
* TOFF set: -2
* Compound Body
* Compound body
* EXPRESSION
* CALL output
 50:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
* EXPRESSION
* EXPRESSION
* CALL cat
 51:     ST  1,-4(1)	Store fp in ghost frame for cat
* TOFF dec: -5
* TOFF dec: -6
* Param end cat
 52:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 53:    LDA  3,1(7)	Return address in ac 
 54:    JMP  7,-16(7)	CALL cat
* Call end cat
* TOFF set: -4
 55:     ST  2,-4(1)	Push left side (store return value in temp loc in frame) 
* TOFF dec: -5
* EXPRESSION
* CALL cat
 56:     ST  1,-5(1)	Store fp in ghost frame for cat
* TOFF dec: -6
* TOFF dec: -7
* Param end cat
 57:    LDA  1,-5(1)	Ghost frame becomes new active frame 
 58:    LDA  3,1(7)	Return address in ac 
 59:    JMP  7,-21(7)	CALL cat
* Call end cat
* TOFF set: -5
 60:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -4
 61:     LD  4,-4(1)	Pop left into ac1 (const value) 
 62:    ADD  3,4,3	Op + 
 63:     ST  3,-4(1)	Push parameter (operation result) 
* TOFF dec: -5
* Param end output
 64:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 65:    LDA  3,1(7)	Return address in ac 
 66:    JMP  7,-61(7)	CALL output
* Call end output
* TOFF set: -2
 67:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
 68:     ST  1,-2(1)	Store fp in ghost frame for outnl
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
 69:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 70:    LDA  3,1(7)	Return address in ac 
 71:    JMP  7,-38(7)	CALL outnl
* Call end outnl
* TOFF set: -2
 72:    LDA  3,0(2)	Save the result in ac 
* TOFF set: 0
* END COMPOUND
* Add standard closing in case there is no return statement
 73:    LDC  2,0(6)	Set return value to 0 
 74:     LD  3,-1(1)	Load return address 
 75:     LD  1,0(1)	Adjust fp 
 76:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,76(7)	Jump to init [backpatch] 
* INIT
 77:    LDA  1,0(0)	set first frame at end of globals 
 78:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 79:    LDA  3,1(7)	Return address in ac 
 80:    JMP  7,-32(7)	Jump to main 
 81:   HALT  0,0,0	DONE! 
* END INIT
