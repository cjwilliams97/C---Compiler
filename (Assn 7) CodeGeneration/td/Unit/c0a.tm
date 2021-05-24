* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/c0a.c-
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
* TOFF set: -2
* Compound Body
* Compound body
* EXPRESSION
 40:    LDA  3,0(0)	Load variable (address) x
 41:     ST  3,-2(1)	Push left side (store variable address in frame) 
* TOFF dec: -3
 42:    LDC  3,753(6)	Load integer constant 
* TOFF inc: -2
 43:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:     ST  3,0(5)	Store variable x
* EXPRESSION
 46:    LDA  3,-1(0)	Load variable (address) y
 47:     ST  3,-2(1)	Push left side (store variable address in frame) 
* TOFF dec: -3
 48:    LDC  3,444(6)	Load integer constant 
* TOFF inc: -2
 49:     LD  5,-2(1)	Pop left into ac2 (variable address) 
 50:     LD  4,0(5)	Load left variable into ac1 (value) 
 51:     ST  3,0(5)	Store variable y
* EXPRESSION
* CALL output
 52:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
* EXPRESSION
 53:    LDA  3,0(0)	Load variable (address) x
 54:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 55:     LD  3,-1(0)	Load variable (value) y
* TOFF inc: -4
 56:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 57:     LD  4,0(5)	Load left variable into ac1 (value) 
 58:    ADD  3,3(4)	op += 
 59:     ST  3,0(5)	Store variable x
 60:     ST  3,-4(1)	Push parameter 
* TOFF dec: -5
* Param end output
 61:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 62:    LDA  3,1(7)	Return address in ac 
 63:    JMP  7,-58(7)	CALL output
 64:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -2
* EXPRESSION
* CALL output
 65:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
* EXPRESSION
 66:    LDA  3,-1(0)	Load variable (address) y
 67:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
 68:     LD  3,0(0)	Load variable (value) x
* TOFF inc: -4
 69:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 70:     LD  4,0(5)	Load left variable into ac1 (value) 
 71:    SUB  3,3(4)	op -= 
 72:     ST  3,0(5)	Store variable y
 73:     ST  3,-4(1)	Push parameter 
* TOFF dec: -5
* Param end output
 74:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 75:    LDA  3,1(7)	Return address in ac 
 76:    JMP  7,-71(7)	CALL output
 77:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -2
* EXPRESSION
* CALL outnl
 78:     ST  1,-2(1)	Store fp in ghost frame for outnl
* TOFF dec: -3
* TOFF dec: -4
* Param end outnl
 79:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 80:    LDA  3,1(7)	Return address in ac 
 81:    JMP  7,-48(7)	CALL outnl
 82:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -2
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 83:    LDC  2,0(6)	Set return value to 0 
 84:     LD  3,-1(1)	Load return address 
 85:     LD  1,0(1)	Adjust fp 
 86:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,86(7)	Jump to init [backpatch] 
* INIT
 87:    LDA  1,-2(0)	set first frame at end of globals 
 88:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
 89:    LDA  3,1(7)	Return address in ac 
 90:    JMP  7,-52(7)	Jump to main 
 91:   HALT  0,0,0	DONE! 
* END INIT
