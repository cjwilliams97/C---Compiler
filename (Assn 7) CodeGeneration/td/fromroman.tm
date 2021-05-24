* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: fromroman.c-
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
* FUNCTION getstring
* TOFF set -3
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -4
* Compound Body
* Compound body
* EXPRESSION
 40:    LDA  3,-3(1)	Load variable (address) i
 41:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
* EXPRESSION
 42:    LDC  3,1(6)	Load integer constant 
 43:    NEG  3,3,3	Op unary - 
* TOFF inc: -4
 44:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 45:     LD  4,0(5)	Load left variable into ac1 (value) 
 46:     ST  3,0(5)	Store variable i
* WHILE
 47:    LDC  3,1(6)	Load Boolean constant 
 48:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
 50:    LDA  3,-4(1)	Load variable (address) c
 51:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
* CALL inputc
 52:     ST  1,-6(1)	Store fp in ghost frame for inputc
* TOFF dec: -7
* TOFF dec: -8
* Param end inputc
 53:    LDA  1,-6(1)	Ghost frame becomes new active frame 
 54:    LDA  3,1(7)	Return address in ac 
 55:    JMP  7,-33(7)	CALL inputc
* Call end inputc
* TOFF set: -6
 56:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -5
 57:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 58:     LD  4,0(5)	Load left variable into ac1 (value) 
 59:     ST  3,0(5)	Store variable c
* IF
* EXPRESSION
 60:    LDA  3,-3(1)	Load variable (address) i
 61:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
 62:     LD  3,-2(1)	Load address of base of array s
 63:     LD  3,1,3	Load array size 
* TOFF inc: -5
 64:     LD  5,-5(1)	Pop left into ac2 (address) 
 65:     LD  4,0(5)	Load left variable into ac1 (value) 
 66:    TLT  3,4,3	Op < 
* THEN
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
 68:    LDA  3,-3(1)	Load variable (address) i
 69:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* TOFF inc: -5
 70:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 71:     LD  4,0(5)	Load left variable into ac1 (value) 
 72:    LDA  3,1(4)	increment value of x. Result in ac 
 73:     ST  3,0(5)	Store variable i
* EXPRESSION
 74:     LD  3,-3(1)	Load variable (value) i
 75:     LD  4,-2(1)	Load address of base of array s
 76:    SUB  3,4,3	compute location from index 
 77:     ST  3,-5(1)	Push left side (store variable address in frame) s
* TOFF dec: -6
 78:     LD  3,-4(1)	Load variable (value) c
* TOFF inc: -5
 79:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 80:     LD  4,0(5)	Load left variable into ac1 (value) 
 81:     ST  3,0(5)	Store variable s
* TOFF set: -5
* END COMPOUND
 67:    JZR  3,14(7)	Jump around the THEN if false [backpatch] 
* IF
* EXPRESSION
 82:    LDA  3,-4(1)	Load variable (address) c
 83:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 84:    LDC  3,10(6)	Load char constant 
* TOFF inc: -5
 85:     LD  5,-5(1)	Pop left into ac2 (address) 
 86:     LD  4,0(5)	Load left variable into ac1 (value) 
 87:    TEQ  3,4,3	Op == 
* THEN
* BREAK
 89:    JMP  7,-41(7)	break 
 88:    JZR  3,1(7)	Jump around the THEN if false [backpatch] 
* TOFF set: -4
* END COMPOUND
 90:    JMP  7,-44(7)	go to beginning of loop 
 49:    JMP  7,41(7)	Jump past loop [backpatch] 
* END WHILE
* RETURN
 91:     LD  3,-3(1)	Load variable (value) i
 92:    LDA  2,0(3)	Copy result to return register 
 93:     LD  3,-1(1)	Load return address 
 94:     LD  1,0(1)	Adjust fp 
 95:    JMP  7,0(3)	Return 
* TOFF set: -3
* END COMPOUND
* Add standard closing in case there is no return statement
 96:    LDC  2,0(6)	Set return value to 0 
 97:     LD  3,-1(1)	Load return address 
 98:     LD  1,0(1)	Adjust fp 
 99:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION getstring
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION putstring
* TOFF set -4
100:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
101:    LDA  3,-4(1)	Load variable (address) i
102:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
103:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -5
104:     LD  5,-5(1)	Pop left into ac2 (variable address) 
105:     LD  4,0(5)	Load left variable into ac1 (value) 
106:     ST  3,0(5)	Store variable i
* WHILE
* EXPRESSION
107:    LDA  3,-4(1)	Load variable (address) i
108:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
109:     LD  3,-2(1)	Load variable (value) len
* TOFF inc: -5
110:     LD  5,-5(1)	Pop left into ac2 (address) 
111:     LD  4,0(5)	Load left variable into ac1 (value) 
112:    TLT  3,4,3	Op < 
113:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
* CALL outputc
115:     ST  1,-5(1)	Store fp in ghost frame for outputc
* TOFF dec: -6
* TOFF dec: -7
* Param 1
116:     LD  3,-4(1)	Load variable (value) i
117:     LD  4,-3(1)	Load address of base of array s
118:    SUB  3,4,3	compute location from index 
119:     LD  3,0(3)	Load array element 
120:     ST  3,-7(1)	Push parameter s
* TOFF dec: -8
* Param end outputc
121:    LDA  1,-5(1)	Ghost frame becomes new active frame 
122:    LDA  3,1(7)	Return address in ac 
123:    JMP  7,-96(7)	CALL outputc
* Call end outputc
* TOFF set: -5
124:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
125:    LDA  3,-4(1)	Load variable (address) i
126:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* TOFF inc: -5
127:     LD  5,-5(1)	Pop left into ac2 (variable address) 
128:     LD  4,0(5)	Load left variable into ac1 (value) 
129:    LDA  3,1(4)	increment value of x. Result in ac 
130:     ST  3,0(5)	Store variable i
* TOFF set: -5
* END COMPOUND
131:    JMP  7,-25(7)	go to beginning of loop 
114:    JMP  7,17(7)	Jump past loop [backpatch] 
* END WHILE
* TOFF set: -4
* END COMPOUND
* Add standard closing in case there is no return statement
132:    LDC  2,0(6)	Set return value to 0 
133:     LD  3,-1(1)	Load return address 
134:     LD  1,0(1)	Adjust fp 
135:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION putstring
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION charvalue
* TOFF set -3
136:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -3
* Compound Body
* Compound body
* IF
* EXPRESSION
137:    LDA  3,-2(1)	Load variable (address) c
138:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
139:    LDC  3,73(6)	Load char constant 
* TOFF inc: -3
140:     LD  5,-3(1)	Pop left into ac2 (address) 
141:     LD  4,0(5)	Load left variable into ac1 (value) 
142:    TEQ  3,4,3	Op == 
* THEN
* RETURN
144:    LDC  3,1(6)	Load integer constant 
145:    LDA  2,0(3)	Copy result to return register 
146:     LD  3,-1(1)	Load return address 
147:     LD  1,0(1)	Adjust fp 
148:    JMP  7,0(3)	Return 
143:    JZR  3,6(7)	Jump around the THEN if false [backpatch] 
* ELSE
* IF
* EXPRESSION
150:    LDA  3,-2(1)	Load variable (address) c
151:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
152:    LDC  3,86(6)	Load char constant 
* TOFF inc: -3
153:     LD  5,-3(1)	Pop left into ac2 (address) 
154:     LD  4,0(5)	Load left variable into ac1 (value) 
155:    TEQ  3,4,3	Op == 
* THEN
* RETURN
157:    LDC  3,5(6)	Load integer constant 
158:    LDA  2,0(3)	Copy result to return register 
159:     LD  3,-1(1)	Load return address 
160:     LD  1,0(1)	Adjust fp 
161:    JMP  7,0(3)	Return 
156:    JZR  3,6(7)	Jump around the THEN if false [backpatch] 
* ELSE
* IF
* EXPRESSION
163:    LDA  3,-2(1)	Load variable (address) c
164:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
165:    LDC  3,88(6)	Load char constant 
* TOFF inc: -3
166:     LD  5,-3(1)	Pop left into ac2 (address) 
167:     LD  4,0(5)	Load left variable into ac1 (value) 
168:    TEQ  3,4,3	Op == 
* THEN
* RETURN
170:    LDC  3,10(6)	Load integer constant 
171:    LDA  2,0(3)	Copy result to return register 
172:     LD  3,-1(1)	Load return address 
173:     LD  1,0(1)	Adjust fp 
174:    JMP  7,0(3)	Return 
169:    JZR  3,6(7)	Jump around the THEN if false [backpatch] 
* ELSE
* IF
* EXPRESSION
176:    LDA  3,-2(1)	Load variable (address) c
177:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
178:    LDC  3,76(6)	Load char constant 
* TOFF inc: -3
179:     LD  5,-3(1)	Pop left into ac2 (address) 
180:     LD  4,0(5)	Load left variable into ac1 (value) 
181:    TEQ  3,4,3	Op == 
* THEN
* RETURN
183:    LDC  3,50(6)	Load integer constant 
184:    LDA  2,0(3)	Copy result to return register 
185:     LD  3,-1(1)	Load return address 
186:     LD  1,0(1)	Adjust fp 
187:    JMP  7,0(3)	Return 
182:    JZR  3,6(7)	Jump around the THEN if false [backpatch] 
* ELSE
* IF
* EXPRESSION
189:    LDA  3,-2(1)	Load variable (address) c
190:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
191:    LDC  3,67(6)	Load char constant 
* TOFF inc: -3
192:     LD  5,-3(1)	Pop left into ac2 (address) 
193:     LD  4,0(5)	Load left variable into ac1 (value) 
194:    TEQ  3,4,3	Op == 
* THEN
* RETURN
196:    LDC  3,100(6)	Load integer constant 
197:    LDA  2,0(3)	Copy result to return register 
198:     LD  3,-1(1)	Load return address 
199:     LD  1,0(1)	Adjust fp 
200:    JMP  7,0(3)	Return 
195:    JZR  3,6(7)	Jump around the THEN if false [backpatch] 
* ELSE
* IF
* EXPRESSION
202:    LDA  3,-2(1)	Load variable (address) c
203:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
204:    LDC  3,68(6)	Load char constant 
* TOFF inc: -3
205:     LD  5,-3(1)	Pop left into ac2 (address) 
206:     LD  4,0(5)	Load left variable into ac1 (value) 
207:    TEQ  3,4,3	Op == 
* THEN
* RETURN
209:    LDC  3,500(6)	Load integer constant 
210:    LDA  2,0(3)	Copy result to return register 
211:     LD  3,-1(1)	Load return address 
212:     LD  1,0(1)	Adjust fp 
213:    JMP  7,0(3)	Return 
208:    JZR  3,6(7)	Jump around the THEN if false [backpatch] 
* ELSE
* IF
* EXPRESSION
215:    LDA  3,-2(1)	Load variable (address) c
216:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
217:    LDC  3,77(6)	Load char constant 
* TOFF inc: -3
218:     LD  5,-3(1)	Pop left into ac2 (address) 
219:     LD  4,0(5)	Load left variable into ac1 (value) 
220:    TEQ  3,4,3	Op == 
* THEN
* RETURN
222:    LDC  3,1000(6)	Load integer constant 
223:    LDA  2,0(3)	Copy result to return register 
224:     LD  3,-1(1)	Load return address 
225:     LD  1,0(1)	Adjust fp 
226:    JMP  7,0(3)	Return 
221:    JZR  3,6(7)	Jump around the THEN if false [backpatch] 
* ELSE
* RETURN
228:    LDC  3,0(6)	Load integer constant 
229:    LDA  2,0(3)	Copy result to return register 
230:     LD  3,-1(1)	Load return address 
231:     LD  1,0(1)	Adjust fp 
232:    JMP  7,0(3)	Return 
227:    JMP  7,5(7)	Jump around the ELSE [backpatch] 
214:    JMP  7,18(7)	Jump around the ELSE [backpatch] 
201:    JMP  7,31(7)	Jump around the ELSE [backpatch] 
188:    JMP  7,44(7)	Jump around the ELSE [backpatch] 
175:    JMP  7,57(7)	Jump around the ELSE [backpatch] 
162:    JMP  7,70(7)	Jump around the ELSE [backpatch] 
149:    JMP  7,83(7)	Jump around the ELSE [backpatch] 
* TOFF set: -3
* END COMPOUND
* Add standard closing in case there is no return statement
233:    LDC  2,0(6)	Set return value to 0 
234:     LD  3,-1(1)	Load return address 
235:     LD  1,0(1)	Adjust fp 
236:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION charvalue
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION roman2arabic
* TOFF set -4
237:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -6
* Compound Body
* Compound body
* EXPRESSION
238:    LDA  3,-5(1)	Load variable (address) sum
239:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
240:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -6
241:     LD  5,-6(1)	Pop left into ac2 (variable address) 
242:     LD  4,0(5)	Load left variable into ac1 (value) 
243:     ST  3,0(5)	Store variable sum
* EXPRESSION
244:    LDA  3,-4(1)	Load variable (address) i
245:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
246:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -6
247:     LD  5,-6(1)	Pop left into ac2 (variable address) 
248:     LD  4,0(5)	Load left variable into ac1 (value) 
249:     ST  3,0(5)	Store variable i
* WHILE
* EXPRESSION
250:    LDA  3,-4(1)	Load variable (address) i
251:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
* EXPRESSION
252:    LDA  3,-2(1)	Load variable (address) len
253:     ST  3,-7(1)	Push left side (store variable address in frame) 
* TOFF dec: -8
254:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -7
255:     LD  5,-7(1)	Pop left into ac2 (address) 
256:     LD  4,0(5)	Load left variable into ac1 (value) 
257:    SUB  3,4,3	Op - 
* TOFF inc: -6
258:     LD  5,-6(1)	Pop left into ac2 (address) 
259:     LD  4,0(5)	Load left variable into ac1 (value) 
260:    TLT  3,4,3	Op < 
261:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -6
* Compound Body
* Compound body
* IF
* EXPRESSION
* EXPRESSION
* CALL charvalue
263:     ST  1,-6(1)	Store fp in ghost frame for charvalue
* TOFF dec: -7
* TOFF dec: -8
* Param 1
264:     LD  3,-4(1)	Load variable (value) i
265:     LD  4,-3(1)	Load address of base of array roman
266:    SUB  3,4,3	compute location from index 
267:     LD  3,0(3)	Load array element 
268:     ST  3,-8(1)	Push parameter roman
* TOFF dec: -9
* Param end charvalue
269:    LDA  1,-6(1)	Ghost frame becomes new active frame 
270:    LDA  3,1(7)	Return address in ac 
271:    JMP  7,-136(7)	CALL charvalue
* Call end charvalue
* TOFF set: -6
272:     ST  2,-6(1)	Push left side (store return value in temp loc in frame) 
* TOFF dec: -7
* EXPRESSION
* CALL charvalue
273:     ST  1,-7(1)	Store fp in ghost frame for charvalue
* TOFF dec: -8
* TOFF dec: -9
* Param 1
* EXPRESSION
274:    LDA  3,-4(1)	Load variable (address) i
275:     ST  3,-9(1)	Push left side (store variable address in frame) 
* TOFF dec: -10
276:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -9
277:     LD  5,-9(1)	Pop left into ac2 (address) 
278:     LD  4,0(5)	Load left variable into ac1 (value) 
279:    ADD  3,4,3	Op + 
280:     LD  4,-3(1)	Load address of base of array roman
281:    SUB  3,4,3	compute location from index 
282:     LD  3,0(3)	Load array element 
283:     ST  3,-9(1)	Push parameter roman
* TOFF dec: -10
* Param end charvalue
284:    LDA  1,-7(1)	Ghost frame becomes new active frame 
285:    LDA  3,1(7)	Return address in ac 
286:    JMP  7,-151(7)	CALL charvalue
* Call end charvalue
* TOFF set: -7
287:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -6
288:     LD  4,-6(1)	Pop left into ac1 (const value) 
289:    TLT  3,4,3	Op < 
* THEN
* EXPRESSION
291:    LDA  3,-5(1)	Load variable (address) sum
292:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
* EXPRESSION
* CALL charvalue
293:     ST  1,-7(1)	Store fp in ghost frame for charvalue
* TOFF dec: -8
* TOFF dec: -9
* Param 1
294:     LD  3,-4(1)	Load variable (value) i
295:     LD  4,-3(1)	Load address of base of array roman
296:    SUB  3,4,3	compute location from index 
297:     LD  3,0(3)	Load array element 
298:     ST  3,-9(1)	Push parameter roman
* TOFF dec: -10
* Param end charvalue
299:    LDA  1,-7(1)	Ghost frame becomes new active frame 
300:    LDA  3,1(7)	Return address in ac 
301:    JMP  7,-166(7)	CALL charvalue
* Call end charvalue
* TOFF set: -7
302:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -6
303:     LD  5,-6(1)	Pop left into ac2 (variable address) 
304:     LD  4,0(5)	Load left variable into ac1 (value) 
305:    SUB  3,4,3	op -= 
306:     ST  3,0(5)	Store variable sum
290:    JZR  3,17(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
308:    LDA  3,-5(1)	Load variable (address) sum
309:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
* EXPRESSION
* CALL charvalue
310:     ST  1,-7(1)	Store fp in ghost frame for charvalue
* TOFF dec: -8
* TOFF dec: -9
* Param 1
311:     LD  3,-4(1)	Load variable (value) i
312:     LD  4,-3(1)	Load address of base of array roman
313:    SUB  3,4,3	compute location from index 
314:     LD  3,0(3)	Load array element 
315:     ST  3,-9(1)	Push parameter roman
* TOFF dec: -10
* Param end charvalue
316:    LDA  1,-7(1)	Ghost frame becomes new active frame 
317:    LDA  3,1(7)	Return address in ac 
318:    JMP  7,-183(7)	CALL charvalue
* Call end charvalue
* TOFF set: -7
319:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -6
320:     LD  5,-6(1)	Pop left into ac2 (variable address) 
321:     LD  4,0(5)	Load left variable into ac1 (value) 
322:    ADD  3,4,3	op += 
323:     ST  3,0(5)	Store variable sum
307:    JMP  7,16(7)	Jump around the ELSE [backpatch] 
* EXPRESSION
324:    LDA  3,-4(1)	Load variable (address) i
325:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
* TOFF inc: -6
326:     LD  5,-6(1)	Pop left into ac2 (variable address) 
327:     LD  4,0(5)	Load left variable into ac1 (value) 
328:    LDA  3,1(4)	increment value of x. Result in ac 
329:     ST  3,0(5)	Store variable i
* TOFF set: -6
* END COMPOUND
330:    JMP  7,-81(7)	go to beginning of loop 
262:    JMP  7,68(7)	Jump past loop [backpatch] 
* END WHILE
* EXPRESSION
331:    LDA  3,-5(1)	Load variable (address) sum
332:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
* EXPRESSION
* CALL charvalue
333:     ST  1,-7(1)	Store fp in ghost frame for charvalue
* TOFF dec: -8
* TOFF dec: -9
* Param 1
* EXPRESSION
334:    LDA  3,-2(1)	Load variable (address) len
335:     ST  3,-9(1)	Push left side (store variable address in frame) 
* TOFF dec: -10
336:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -9
337:     LD  5,-9(1)	Pop left into ac2 (address) 
338:     LD  4,0(5)	Load left variable into ac1 (value) 
339:    SUB  3,4,3	Op - 
340:     LD  4,-3(1)	Load address of base of array roman
341:    SUB  3,4,3	compute location from index 
342:     LD  3,0(3)	Load array element 
343:     ST  3,-9(1)	Push parameter roman
* TOFF dec: -10
* Param end charvalue
344:    LDA  1,-7(1)	Ghost frame becomes new active frame 
345:    LDA  3,1(7)	Return address in ac 
346:    JMP  7,-211(7)	CALL charvalue
* Call end charvalue
* TOFF set: -7
347:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -6
348:     LD  5,-6(1)	Pop left into ac2 (variable address) 
349:     LD  4,0(5)	Load left variable into ac1 (value) 
350:    ADD  3,4,3	op += 
351:     ST  3,0(5)	Store variable sum
* RETURN
352:     LD  3,-5(1)	Load variable (value) sum
353:    LDA  2,0(3)	Copy result to return register 
354:     LD  3,-1(1)	Load return address 
355:     LD  1,0(1)	Adjust fp 
356:    JMP  7,0(3)	Return 
* TOFF set: -4
* END COMPOUND
* Add standard closing in case there is no return statement
357:    LDC  2,0(6)	Set return value to 0 
358:     LD  3,-1(1)	Load return address 
359:     LD  1,0(1)	Adjust fp 
360:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION roman2arabic
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
361:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -54
* Compound Body
362:    LDC  3,50(6)	load size of array s
363:     ST  3,-2(1)	save size of array s
* Compound body
* WHILE
364:    LDC  3,1(6)	Load Boolean constant 
365:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -54
* Compound Body
* Compound body
* EXPRESSION
367:    LDA  3,-53(1)	Load variable (address) len
368:     ST  3,-54(1)	Push left side (store variable address in frame) 
* TOFF dec: -55
* EXPRESSION
* CALL getstring
369:     ST  1,-55(1)	Store fp in ghost frame for getstring
* TOFF dec: -56
* TOFF dec: -57
* Param 1
370:    LDA  3,-3(1)	Load address of base of array s
371:     ST  3,-57(1)	Push parameter 
* TOFF dec: -58
* Param end getstring
372:    LDA  1,-55(1)	Ghost frame becomes new active frame 
373:    LDA  3,1(7)	Return address in ac 
374:    JMP  7,-336(7)	CALL getstring
* Call end getstring
* TOFF set: -55
375:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -54
376:     LD  5,-54(1)	Pop left into ac2 (variable address) 
377:     LD  4,0(5)	Load left variable into ac1 (value) 
378:     ST  3,0(5)	Store variable len
* IF
* EXPRESSION
379:    LDC  3,0(6)	Load integer constant 
380:    LDA  4,-3(1)	Load address of base of array s
381:    SUB  3,4,3	compute location from index 
382:     ST  3,-54(1)	Push left side (store variable address in frame) s
* TOFF dec: -55
383:    LDC  3,113(6)	Load char constant 
* TOFF inc: -54
384:     LD  5,-54(1)	Pop left into ac2 (address) 
385:     LD  4,0(5)	Load left variable into ac1 (value) 
386:    TEQ  3,4,3	Op == 
* THEN
* BREAK
388:    JMP  7,-23(7)	break 
387:    JZR  3,1(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
* CALL putstring
389:     ST  1,-54(1)	Store fp in ghost frame for putstring
* TOFF dec: -55
* TOFF dec: -56
* Param 1
390:     LD  3,-53(1)	Load variable (value) len
391:     ST  3,-56(1)	Push parameter 
* TOFF dec: -57
* Param 2
392:    LDA  3,-3(1)	Load address of base of array s
393:     ST  3,-57(1)	Push parameter 
* TOFF dec: -58
* Param end putstring
394:    LDA  1,-54(1)	Ghost frame becomes new active frame 
395:    LDA  3,1(7)	Return address in ac 
396:    JMP  7,-297(7)	CALL putstring
* Call end putstring
* TOFF set: -54
397:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
398:     ST  1,-54(1)	Store fp in ghost frame for outnl
* TOFF dec: -55
* TOFF dec: -56
* Param end outnl
399:    LDA  1,-54(1)	Ghost frame becomes new active frame 
400:    LDA  3,1(7)	Return address in ac 
401:    JMP  7,-368(7)	CALL outnl
* Call end outnl
* TOFF set: -54
402:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL output
403:     ST  1,-54(1)	Store fp in ghost frame for output
* TOFF dec: -55
* TOFF dec: -56
* Param 1
* EXPRESSION
* CALL roman2arabic
404:     ST  1,-56(1)	Store fp in ghost frame for roman2arabic
* TOFF dec: -57
* TOFF dec: -58
* Param 1
405:     LD  3,-53(1)	Load variable (value) len
406:     ST  3,-58(1)	Push parameter 
* TOFF dec: -59
* Param 2
407:    LDA  3,-3(1)	Load address of base of array s
408:     ST  3,-59(1)	Push parameter 
* TOFF dec: -60
* Param end roman2arabic
409:    LDA  1,-56(1)	Ghost frame becomes new active frame 
410:    LDA  3,1(7)	Return address in ac 
411:    JMP  7,-175(7)	CALL roman2arabic
* Call end roman2arabic
* TOFF set: -56
412:    LDA  3,0(2)	Save the result in ac 
413:     ST  3,-56(1)	Push parameter roman2arabic
* TOFF dec: -57
* Param end output
414:    LDA  1,-54(1)	Ghost frame becomes new active frame 
415:    LDA  3,1(7)	Return address in ac 
416:    JMP  7,-411(7)	CALL output
* Call end output
* TOFF set: -54
417:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
* CALL outnl
418:     ST  1,-54(1)	Store fp in ghost frame for outnl
* TOFF dec: -55
* TOFF dec: -56
* Param end outnl
419:    LDA  1,-54(1)	Ghost frame becomes new active frame 
420:    LDA  3,1(7)	Return address in ac 
421:    JMP  7,-388(7)	CALL outnl
* Call end outnl
* TOFF set: -54
422:    LDA  3,0(2)	Save the result in ac 
* TOFF set: -54
* END COMPOUND
423:    JMP  7,-60(7)	go to beginning of loop 
366:    JMP  7,57(7)	Jump past loop [backpatch] 
* END WHILE
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
424:    LDC  2,0(6)	Set return value to 0 
425:     LD  3,-1(1)	Load return address 
426:     LD  1,0(1)	Adjust fp 
427:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,427(7)	Jump to init [backpatch] 
* INIT
428:    LDA  1,0(0)	set first frame at end of globals 
429:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
430:    LDA  3,1(7)	Return address in ac 
431:    JMP  7,-71(7)	Jump to main 
432:   HALT  0,0,0	DONE! 
* END INIT
