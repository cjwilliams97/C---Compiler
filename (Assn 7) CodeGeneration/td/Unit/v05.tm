* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: td/v05.c-
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
* FUNCTION outputs
* TOFF set -3
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -4
* Compound Body
* CALL outputc
 40:     ST  1,-5(1)	Store fp in ghost frame for outputs 
* TOFF dec: -6
* TOFF dec: -7
* Param 1
* END COMPOUND
* END COMPOUND
* Add standard closing in case there is no return statement
 41:    LDC  2,0(6)	Set return value to 0 
 42:     LD  3,-1(1)	Load return address 
 43:     LD  1,0(1)	Adjust fp 
 44:    JMP  7,0(7)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION outputs
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
 45:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -39
* Compound Body
* CALL outputs
 46:     ST  1,-39(1)	Store fp in ghost frame for outputs 
* TOFF dec: -40
* TOFF dec: -41
* Param 1
* CALL outnl
 47:     ST  1,-41(1)	Store fp in ghost frame for outputs 
* TOFF dec: -42
* TOFF dec: -43
* CALL outputs
 48:     ST  1,-43(1)	Store fp in ghost frame for outputs 
* TOFF dec: -44
* TOFF dec: -45
* Param 1
* CALL outnl
 49:     ST  1,-45(1)	Store fp in ghost frame for outputs 
* TOFF dec: -46
* TOFF dec: -47
* CALL outnl
 50:     ST  1,-47(1)	Store fp in ghost frame for outputs 
* TOFF dec: -48
* TOFF dec: -49
* CALL outputs
 51:     ST  1,-49(1)	Store fp in ghost frame for outputs 
* TOFF dec: -50
* TOFF dec: -51
* Param 1
* CALL outnl
 52:     ST  1,-51(1)	Store fp in ghost frame for outputs 
* TOFF dec: -52
* TOFF dec: -53
* CALL outputs
 53:     ST  1,-53(1)	Store fp in ghost frame for outputs 
* TOFF dec: -54
* TOFF dec: -55
* Param 1
* CALL outnl
 54:     ST  1,-55(1)	Store fp in ghost frame for outputs 
* TOFF dec: -56
* TOFF dec: -57
* CALL outnl
 55:     ST  1,-57(1)	Store fp in ghost frame for outputs 
* TOFF dec: -58
* TOFF dec: -59
* CALL outputs
 56:     ST  1,-59(1)	Store fp in ghost frame for outputs 
* TOFF dec: -60
* TOFF dec: -61
* Param 1
* CALL outnl
 57:     ST  1,-61(1)	Store fp in ghost frame for outputs 
* TOFF dec: -62
* TOFF dec: -63
* CALL outputs
 58:     ST  1,-63(1)	Store fp in ghost frame for outputs 
* TOFF dec: -64
* TOFF dec: -65
* Param 1
* CALL outnl
 59:     ST  1,-65(1)	Store fp in ghost frame for outputs 
* TOFF dec: -66
* TOFF dec: -67
* CALL outnl
 60:     ST  1,-67(1)	Store fp in ghost frame for outputs 
* TOFF dec: -68
* TOFF dec: -69
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
 65:    LDA  1,-34(0)	set first frame at end of globals 
 66:     ST  1,0(0)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 67:    LDA  3,1(7)	Return address in ac 
 68:    JMP  7,-24(7)	Jump to main 
 69:   HALT  0,0,0	DONE! 
* END INIT
