* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/g0e.c-
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
* TOFF set -3
 39:     ST  3,-1(1)	Store return address 
* IF
* EXPRESSION
 40:    LDA  3,-2(1)	Load variable (address) x
 41:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 42:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -3
 43:     LD  5,-3(1)	Pop left into ac2 (address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:    TGT  3,4,3	Op > 
* THEN
* RETURN
* EXPRESSION
 47:    LDA  3,-2(1)	Load variable (address) x
 48:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 49:     LD  3,-2(1)	Load variable (value) x
* TOFF inc: -3
 50:     LD  5,-3(1)	Pop left into ac2 (address) 
 51:     LD  4,0(5)	Load left variable into ac1 (value) 
 52:    ADD  3,4,3	Op + 
 53:    LDA  2,0(3)	Copy result to return register 
 54:     LD  3,-1(1)	Load return address 
 55:     LD  1,0(1)	Adjust fp 
 56:    JMP  7,0(3)	Return 
 46:    JZR  3,11(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
 58:    LDA  3,-2(1)	Load variable (address) x
 59:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 60:     LD  3,-2(1)	Load variable (value) x
* TOFF inc: -3
 61:     LD  5,-3(1)	Pop left into ac2 (address) 
 62:     LD  4,0(5)	Load left variable into ac1 (value) 
 63:    MUL  3,4,3	Op * 
 57:    JMP  7,6(7)	Jump around the ELSE [backpatch] 
* Add standard closing in case there is no return statement
 64:    LDC  2,0(6)	Set return value to 0 
 65:     LD  3,-1(1)	Load return address 
 66:     LD  1,0(1)	Adjust fp 
 67:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION cat
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
 68:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -2
* Compound Body
* Compound body
* EXPRESSION
* CALL output
 69:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
* EXPRESSION
* CALL cat
 70:     ST  1,-4(1)	Store fp in ghost frame for cat
* TOFF dec: -5
* TOFF dec: -6
* Param 1
 71:    LDC  3,88(6)	Load integer constant 
 72:     ST  3,-6(1)	Push parameter 88
* TOFF dec: -7
* Param end cat
 73:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 74:    LDA  3,1(7)	Return address in ac 
 75:    JMP  7,-37(7)	CALL cat
* Call end cat
* TOFF set: -4
 76:    LDA  3,0(2)	Save the result in ac 
 77:     ST  3,-4(1)	Push parameter cat
* TOFF dec: -5
* Param end output
 78:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 79:    LDA  3,1(7)	Return address in ac 
 80:    JMP  7,-75(7)	CALL output
* Call end output
* TOFF set: -2
 81:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL output
 82:     ST  1,-2(1)	Store fp in ghost frame for output
* TOFF dec: -3
* TOFF dec: -4
* Param 1
* EXPRESSION
* CALL cat
 83:     ST  1,-4(1)	Store fp in ghost frame for cat
* TOFF dec: -5
* TOFF dec: -6
* Param 1
* EXPRESSION
 84:    LDC  3,17(6)	Load integer constant 
 85:    NEG  3,3,3	Op unary - 
 86:     ST  3,-6(1)	Push parameter (operation result) 
* TOFF dec: -7
* Param end cat
 87:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 88:    LDA  3,1(7)	Return address in ac 
 89:    JMP  7,-51(7)	CALL cat
* Call end cat
* TOFF set: -4
 90:    LDA  3,0(2)	Save the result in ac 
 91:     ST  3,-4(1)	Push parameter cat
* TOFF dec: -5
* Param end output
 92:    LDA  1,-2(1)	Ghost frame becomes new active frame 
 93:    LDA  3,1(7)	Return address in ac 
 94:    JMP  7,-89(7)	CALL output
* Call end output
* TOFF set: -2
 95:    LDA  3,0(2)	Save the result in ac 
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
 96:    LDC  2,0(6)	Set return value to 0 
 97:     LD  3,-1(1)	Load return address 
 98:     LD  1,0(1)	Adjust fp 
 99:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,99(7)	Jump to init [backpatch] 
* INIT
100:    LDA  1,0(0)	set first frame at end of globals 
101:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
102:    LDA  3,1(7)	Return address in ac 
103:    JMP  7,-36(7)	Jump to main 
104:   HALT  0,0,0	DONE! 
* END INIT
