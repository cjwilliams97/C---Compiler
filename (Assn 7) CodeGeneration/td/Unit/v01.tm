* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: td/v01.c-
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION output
  0:     ST  3,-1(1)	Store return address 
  1:     LD  3,-2(1)	Load parameter 
  2:    OUT  3,3,3	Output int 
  3:    LDC  2,0(6)	Set return to 0 
  4:     LD  3,-1(1)	Load return address 
  5:     LD  1,0(1)	Adjust fp 
  6:    JMP  7,0(3)	Return 
* END FUNCTION output
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputb
  7:     ST  3,-1(1)	Store return address 
  8:     LD  3,-2(1)	Load parameter 
  9:   OUTB  3,3,3	Output int 
 10:    LDC  2,0(6)	Set return to 0 
 11:     LD  3,-1(1)	Load return address 
 12:     LD  1,0(1)	Adjust fp 
 13:    JMP  7,0(3)	Return 
* END FUNCTION outputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outputc
 14:     ST  3,-1(1)	Store return address 
 15:     LD  3,-2(1)	Load parameter 
 16:   OUTC  3,3,3	Output int 
 17:    LDC  2,0(6)	Set return to 0 
 18:     LD  3,-1(1)	Load return address 
 19:     LD  1,0(1)	Adjust fp 
 20:    JMP  7,0(3)	Return 
* END FUNCTION outputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION input
 21:     ST  3,-1(1)	Store return address 
 22:     IN  2,2,2	Grab int input 
 23:     LD  3,-1(1)	Load return address 
 24:     LD  1,0(1)	Adjust fp 
 25:    JMP  7,0(3)	Return 
* END FUNCTION input
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputb
 26:     ST  3,-1(1)	Store return address 
 27:    INB  2,2,2	Grab bool input 
 28:     LD  3,-1(1)	Load return address 
 29:     LD  1,0(1)	Adjust fp 
 30:    JMP  7,0(3)	Return 
* END FUNCTION inputb
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION inputc
 31:     ST  3,-1(1)	Store return address 
 32:    INC  2,2,2	Grab char input 
 33:     LD  3,-1(1)	Load return address 
 34:     LD  1,0(1)	Adjust fp 
 35:    JMP  7,0(3)	Return 
* END FUNCTION inputc
* 
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION outnl
 36:     ST  3,-1(1)	Store return address 
 37:  OUTNL  3,3,3	Output a newLine 
 38:     LD  3,-1(1)	Load return address 
 39:     LD  1,0(1)	Adjust fp 
 40:    JMP  7,0(3)	Return 
* END FUNCTION outnl
* 
