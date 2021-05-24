* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/c0d.c-
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
* EXPRESSION
 40:    LDA  3,-2(1)	Load variable (address) x
 41:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 42:    LDC  3,753(6)	Load integer constant 
* TOFF inc: -5
 43:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:     ST  3,0(5)	Store variable x
* EXPRESSION
 46:    LDA  3,-3(1)	Load variable (address) y
 47:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 48:    LDC  3,444(6)	Load integer constant 
* TOFF inc: -5
 49:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 50:     LD  4,0(5)	Load left variable into ac1 (value) 
 51:     ST  3,0(5)	Store variable y
* EXPRESSION
 52:    LDA  3,-4(1)	Load variable (address) z
 53:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 54:    LDC  3,931(6)	Load integer constant 
* TOFF inc: -5
 55:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 56:     LD  4,0(5)	Load left variable into ac1 (value) 
 57:     ST  3,0(5)	Store variable z
* EXPRESSION
* CALL output
 58:     ST  1,-5(1)	Store fp in ghost frame for output
* TOFF dec: -6
* TOFF dec: -7
* Param 1
* EXPRESSION
 59:    LDA  3,-4(1)	Load variable (address) z
 60:     ST  3,-7(1)	Push left side (store variable address in frame) 
* TOFF dec: -8
* EXPRESSION
 61:    LDA  3,-2(1)	Load variable (address) x
 62:     ST  3,-8(1)	Push left side (store variable address in frame) 
* TOFF dec: -9
 63:     LD  3,-3(1)	Load variable (value) y
* TOFF inc: -8
 64:     LD  5,-8(1)	Pop left into ac2 (variable address) 
 65:     LD  4,0(5)	Load left variable into ac1 (value) 
 66:    SUB  3,4,3	op -= 
 67:     ST  3,0(5)	Store variable x
* TOFF inc: -7
 68:     LD  5,-7(1)	Pop left into ac2 (variable address) 
 69:     LD  4,0(5)	Load left variable into ac1 (value) 
 70:    SUB  3,4,3	op -= 
 71:     ST  3,0(5)	Store variable z
 72:     ST  3,-7(1)	Push parameter 
* TOFF dec: -8
* Param end output
 73:    LDA  1,-5(1)	Ghost frame becomes new active frame 
 74:    LDA  3,1(7)	Return address in ac 
 75:    JMP  7,-70(7)	CALL output
 76:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -5
* EXPRESSION
* CALL outnl
 77:     ST  1,-5(1)	Store fp in ghost frame for outnl
* TOFF dec: -6
* TOFF dec: -7
* Param end outnl
 78:    LDA  1,-5(1)	Ghost frame becomes new active frame 
 79:    LDA  3,1(7)	Return address in ac 
 80:    JMP  7,-47(7)	CALL outnl
 81:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -5
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 82:    LDC  2,0(6)	Set return value to 0 
 83:     LD  3,-1(1)	Load return address 
 84:     LD  1,0(1)	Adjust fp 
 85:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,85(7)	Jump to init [backpatch] 
* INIT
 86:    LDA  1,0(0)	set first frame at end of globals 
 87:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 88:    LDA  3,1(7)	Return address in ac 
 89:    JMP  7,-51(7)	Jump to main 
 90:   HALT  0,0,0	DONE! 
* END INIT
