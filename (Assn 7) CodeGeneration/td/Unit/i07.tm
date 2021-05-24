* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: td/i07.c-
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
* TOFF set: -5
* Compound Body
* CALL outputb
 40:     ST  1,-5(1)	Store fp in ghost frame for outputs 
* TOFF dec: -6
* TOFF dec: -7
* Param 1
 41:     LD  3,-2(1)	Load variable ba
 42:     ST  3,-7(1)	Push parameter 
* Param end outputb
 43:    LDA  1,-5(1)	Ghost frame becomes new active frame 
 44:    LDA  3,1(7)	Return address in ac 
 45:    JMP  7,-29(7)	CALL outputb
 46:    LDA  3,0(2)	Save the result in ac 
* Call end outputb
* TOFF set: -5
* CALL outputb
 47:     ST  1,-5(1)	Store fp in ghost frame for outputs 
* TOFF dec: -6
* TOFF dec: -7
* Param 1
 48:     LD  3,-3(1)	Load variable bb
 49:     ST  3,-7(1)	Push parameter 
* Param end outputb
 50:    LDA  1,-5(1)	Ghost frame becomes new active frame 
 51:    LDA  3,1(7)	Return address in ac 
 52:    JMP  7,-36(7)	CALL outputb
 53:    LDA  3,0(2)	Save the result in ac 
* Call end outputb
* TOFF set: -5
* CALL outputb
 54:     ST  1,-5(1)	Store fp in ghost frame for outputs 
* TOFF dec: -6
* TOFF dec: -7
* Param 1
 55:     LD  3,-4(1)	Load variable bc
 56:     ST  3,-7(1)	Push parameter 
* Param end outputb
 57:    LDA  1,-5(1)	Ghost frame becomes new active frame 
 58:    LDA  3,1(7)	Return address in ac 
 59:    JMP  7,-43(7)	CALL outputb
 60:    LDA  3,0(2)	Save the result in ac 
* Call end outputb
* TOFF set: -5
* TOFF set: -5
* END COMPOUND
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 61:    LDC  2,0(6)	Set return value to 0 
 62:     LD  3,-1(1)	Load return address 
 63:     LD  1,0(1)	Adjust fp 
 64:    JMP  7,0(7)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,64(7)	Jump to init [backpatch] 
* INIT
 65:    LDA  1,0(0)	set first frame at end of globals 
 66:     ST  1,0(0)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 67:    LDA  3,1(7)	Return address in ac 
 68:    JMP  7,-30(7)	Jump to main 
 69:   HALT  0,0,0	DONE! 
* END INIT
