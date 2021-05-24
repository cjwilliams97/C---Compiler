* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/k04.c-
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
* Compound body
* FOR
 40:    LDC  3,300(6)	Load integer constant 
 41:     ST  3,-5(1)	save starting value in index variable 
 42:    LDC  3,313(6)	Load integer constant 
 43:     ST  3,-6(1)	save stop value 
 44:    LDC  3,2(6)	Load integer constant 
 45:     ST  3,-7(1)	save step value 
 46:     LD  4,-5(1)	loop index 
 47:     LD  5,-6(1)	stop value 
 48:     LD  3,-7(1)	step value 
 49:    SLT  3,4,5	Op < 
 50:    JNZ  3,1(7)	Jump to loop body 
* COMPOUND
* TOFF set: -10
* Compound body
* EXPRESSION
 52:    LDA  3,-8(1)	Load variable (address) x
 53:     ST  3,-10(1)	Push left side (store variable address in frame) 
* TOFF dec: -11
 54:     LD  3,-5(1)	Load variable (value) i
* TOFF inc: -10
 55:     LD  5,-10(1)	Pop left into ac2 (variable address) 
 56:     LD  4,0(5)	Load left variable into ac1 (value) 
 57:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
 58:     ST  1,-10(1)	Store fp in ghost frame for output
* TOFF dec: -11
* TOFF dec: -12
* Param 1
 59:     LD  3,-8(1)	Load variable (value) x
 60:     ST  3,-12(1)	Push parameter 
* TOFF dec: -13
* Param end output
 61:    LDA  1,-10(1)	Ghost frame becomes new active frame 
 62:    LDA  3,1(7)	Return address in ac 
 63:    JMP  7,-58(7)	CALL output
* Call end output
* TOFF set: -10
 64:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
 65:     ST  1,-10(1)	Store fp in ghost frame for outnl
* TOFF dec: -11
* TOFF dec: -12
* Param end outnl
 66:    LDA  1,-10(1)	Ghost frame becomes new active frame 
 67:    LDA  3,1(7)	Return address in ac 
 68:    JMP  7,-35(7)	CALL outnl
* Call end outnl
* TOFF set: -10
 69:    LDA  3,0(2)	Save the result in ac 
* TOFF set: -5
* END COMPOUND
* TOFF set: -8
* Bottom of loop increment and jump
 70:     LD  3,-5(1)	load index 
 71:     LD  5,-7(1)	load step 
 72:    ADD  3,3,5	increment 
 73:     ST  3,-5(1)	store back to index 
 74:    JMP  7,-29(7)	go to beginning of loop 
 51:    JMP  7,23(7)	Jump past loop [backpatch] 
* End FOR
* TOFF set: -5
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 75:    LDC  2,0(6)	Set return value to 0 
 76:     LD  3,-1(1)	Load return address 
 77:     LD  1,0(1)	Adjust fp 
 78:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,78(7)	Jump to init [backpatch] 
* INIT
 79:    LDA  1,0(0)	set first frame at end of globals 
 80:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 81:    LDA  3,1(7)	Return address in ac 
 82:    JMP  7,-44(7)	Jump to main 
 83:   HALT  0,0,0	DONE! 
* END INIT
