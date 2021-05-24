* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: td/t00.c-
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION output
  1:     ST  3,-1(1)	Store return address 
  2:     LD  3,-2(1)	Load parameter 
  3:    OUT  3,3,3	Output int 
  4:    LDC  2,0(6)	Set return to 0 
  5:     LD  3,-1(1)	Load return address 
  6:     LD  1,0(1)	Adjust fp 
  7:    JMP  7,0(3)	Return 
* END FUNCTION output
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputb
 16:     ST  3,-1(1)	Store return address 
 17:     LD  3,-2(1)	Load parameter 
 18:   OUTB  3,3,3	Output int 
 19:    LDC  2,0(6)	Set return to 0 
 20:     LD  3,-1(1)	Load return address 
 21:     LD  1,0(1)	Adjust fp 
 22:    JMP  7,0(3)	Return 
* END FUNCTION outputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputc
 31:     ST  3,-1(1)	Store return address 
 32:     LD  3,-2(1)	Load parameter 
 33:   OUTC  3,3,3	Output int 
 34:    LDC  2,0(6)	Set return to 0 
 35:     LD  3,-1(1)	Load return address 
 36:     LD  1,0(1)	Adjust fp 
 37:    JMP  7,0(3)	Return 
* END FUNCTION outputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION input
 46:     ST  3,-1(1)	Store return address 
 47:     IN  2,2,2	Grab int input 
 48:     LD  3,-1(1)	Load return address 
 49:     LD  1,0(1)	Adjust fp 
 50:    JMP  7,0(3)	Return 
* END FUNCTION input
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputb
 55:     ST  3,-1(1)	Store return address 
 56:    INB  2,2,2	Grab bool input 
 57:     LD  3,-1(1)	Load return address 
 58:     LD  1,0(1)	Adjust fp 
 59:    JMP  7,0(3)	Return 
* END FUNCTION inputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputc
 64:     ST  3,-1(1)	Store return address 
 65:    INC  2,2,2	Grab char input 
 66:     LD  3,-1(1)	Load return address 
 67:     LD  1,0(1)	Adjust fp 
 68:    JMP  7,0(3)	Return 
* END FUNCTION inputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outnl
 73:     ST  3,-1(1)	Store return address 
 74:  OUTNL  3,3,3	Output a newLine 
 75:     LD  3,-1(1)	Load return address 
 76:     LD  1,0(1)	Adjust fp 
 77:    JMP  7,0(3)	Return 
* END FUNCTION outnl
* 
  0:    JMP  7,81(7)	Jump to init [backpatch] 
* INIT
 82:    LDA  1,0(0)	set first frame at end of globals 
 83:     ST  1,0(0)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 84:    LDA  3,1(7)	Return address in ac 
 85:    JMP  7,0(7)	Jump to main 
 86:   HALT  0,0,0	DONE! 
* END INIT
