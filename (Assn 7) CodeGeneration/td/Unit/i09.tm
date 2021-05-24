* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: td/i09.c-
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
 40:    LDC  3,4(6)	Load integer constant 
 41:     ST  3,-4(1)	Push left side 
* TOFF dec: -5
 42:    LDC  3,5(6)	Load integer constant 
* TOFF inc: -4
 43:     LD  4,-4(1)	Pop left into ac1 
 44:    MUL  3,4,3	Op * 
 45:     ST  3,-4(1)	Push left side 
* TOFF dec: -5
 46:    LDC  3,3(6)	Load integer constant 
 47:     ST  3,-5(1)	Push left side 
* TOFF dec: -6
 48:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -5
 49:     LD  4,-5(1)	Pop left into ac1 
 50:    MUL  3,4,3	Op * 
* TOFF inc: -4
 51:     LD  4,-4(1)	Pop left into ac1 
 52:    ADD  3,4,3	Op + 
 53:     ST  3,-2(1)	Store variable kk
 54:    LDC  3,46(6)	Load integer constant 
 55:     ST  3,-4(1)	Push left side 
* TOFF dec: -5
* TOFF inc: -4
 56:     LD  4,-4(1)	Pop left into ac1 
 57:     ST  3,-3(1)	Store variable ll
* CALL output
 58:     ST  1,-4(1)	Store fp in ghost frame for outputs 
* TOFF dec: -5
* TOFF dec: -6
* Param 1
 59:     LD  3,-2(1)	Load variable kk
 60:     ST  3,-6(1)	Push parameter 
* Param end output
 61:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 62:    LDA  3,1(7)	Return address in ac 
 63:    JMP  7,-58(7)	CALL output
 64:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -4
* TOFF set: -4
* END COMPOUND
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 65:    LDC  2,0(6)	Set return value to 0 
 66:     LD  3,-1(1)	Load return address 
 67:     LD  1,0(1)	Adjust fp 
 68:    JMP  7,0(7)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,68(7)	Jump to init [backpatch] 
* INIT
 69:    LDA  1,0(0)	set first frame at end of globals 
 70:     ST  1,0(0)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 71:    LDA  3,1(7)	Return address in ac 
 72:    JMP  7,-34(7)	Jump to main 
 73:   HALT  0,0,0	DONE! 
* END INIT
