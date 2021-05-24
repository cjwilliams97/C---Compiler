* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: factor.c-
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
* FUNCTION sqrt
* TOFF set -3
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* IF
* EXPRESSION
 40:    LDA  3,-2(1)	Load variable (address) x
 41:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 42:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -5
 43:     LD  5,-5(1)	Pop left into ac2 (address) 
 44:     LD  4,0(5)	Load left variable into ac1 (value) 
 45:    TEQ  3,4,3	Op == 
* THEN
* RETURN
 47:    LDC  3,1(6)	Load integer constant 
 48:    LDA  2,0(3)	Copy result to return register 
 49:     LD  3,-1(1)	Load return address 
 50:     LD  1,0(1)	Adjust fp 
 51:    JMP  7,0(3)	Return 
 46:    JZR  3,5(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
 52:    LDA  3,-3(1)	Load variable (address) guess
 53:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
 54:    LDA  3,-2(1)	Load variable (address) x
 55:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
 56:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -6
 57:     LD  5,-6(1)	Pop left into ac2 (address) 
 58:     LD  4,0(5)	Load left variable into ac1 (value) 
 59:    DIV  3,4,3	Op / 
* TOFF inc: -5
 60:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 61:     LD  4,0(5)	Load left variable into ac1 (value) 
 62:     ST  3,0(5)	Store variable guess
* EXPRESSION
 63:    LDA  3,-4(1)	Load variable (address) newguess
 64:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
* EXPRESSION
* EXPRESSION
 65:    LDA  3,-2(1)	Load variable (address) x
 66:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
 67:     LD  3,-3(1)	Load variable (value) guess
* TOFF inc: -6
 68:     LD  5,-6(1)	Pop left into ac2 (address) 
 69:     LD  4,0(5)	Load left variable into ac1 (value) 
 70:    DIV  3,4,3	Op / 
 71:     ST  3,-6(1)	Push operation result 
* TOFF dec: -7
 72:     LD  3,-3(1)	Load variable (value) guess
* TOFF inc: -6
 73:     LD  4,-6(1)	Pop left into ac1 (const value) 
 74:    ADD  3,4,3	Op + 
 75:     ST  3,-6(1)	Push operation result 
* TOFF dec: -7
 76:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -6
 77:     LD  4,-6(1)	Pop left into ac1 (const value) 
 78:    DIV  3,4,3	Op / 
* TOFF inc: -5
 79:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 80:     LD  4,0(5)	Load left variable into ac1 (value) 
 81:     ST  3,0(5)	Store variable newguess
* WHILE
* EXPRESSION
* EXPRESSION
 82:    LDA  3,-3(1)	Load variable (address) guess
 83:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 84:     LD  3,-4(1)	Load variable (value) newguess
* TOFF inc: -5
 85:     LD  5,-5(1)	Pop left into ac2 (address) 
 86:     LD  4,0(5)	Load left variable into ac1 (value) 
 87:    SUB  3,4,3	Op - 
 88:     ST  3,-5(1)	Push operation result 
* TOFF dec: -6
 89:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -5
 90:     LD  4,-5(1)	Pop left into ac1 (const value) 
 91:    TGT  3,4,3	Op > 
 92:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
 94:    LDA  3,-3(1)	Load variable (address) guess
 95:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
 96:     LD  3,-4(1)	Load variable (value) newguess
* TOFF inc: -5
 97:     LD  5,-5(1)	Pop left into ac2 (variable address) 
 98:     LD  4,0(5)	Load left variable into ac1 (value) 
 99:     ST  3,0(5)	Store variable guess
* EXPRESSION
100:    LDA  3,-4(1)	Load variable (address) newguess
101:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
* EXPRESSION
* EXPRESSION
102:    LDA  3,-2(1)	Load variable (address) x
103:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
104:     LD  3,-3(1)	Load variable (value) guess
* TOFF inc: -6
105:     LD  5,-6(1)	Pop left into ac2 (address) 
106:     LD  4,0(5)	Load left variable into ac1 (value) 
107:    DIV  3,4,3	Op / 
108:     ST  3,-6(1)	Push operation result 
* TOFF dec: -7
109:     LD  3,-3(1)	Load variable (value) guess
* TOFF inc: -6
110:     LD  4,-6(1)	Pop left into ac1 (const value) 
111:    ADD  3,4,3	Op + 
112:     ST  3,-6(1)	Push operation result 
* TOFF dec: -7
113:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -6
114:     LD  4,-6(1)	Pop left into ac1 (const value) 
115:    DIV  3,4,3	Op / 
* TOFF inc: -5
116:     LD  5,-5(1)	Pop left into ac2 (variable address) 
117:     LD  4,0(5)	Load left variable into ac1 (value) 
118:     ST  3,0(5)	Store variable newguess
* TOFF set: -5
* END COMPOUND
119:    JMP  7,-38(7)	go to beginning of loop 
 93:    JMP  7,26(7)	Jump past loop [backpatch] 
* END WHILE
* IF
* EXPRESSION
* EXPRESSION
120:    LDA  3,-4(1)	Load variable (address) newguess
121:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
122:     LD  3,-4(1)	Load variable (value) newguess
* TOFF inc: -5
123:     LD  5,-5(1)	Pop left into ac2 (address) 
124:     LD  4,0(5)	Load left variable into ac1 (value) 
125:    MUL  3,4,3	Op * 
126:     ST  3,-5(1)	Push operation result 
* TOFF dec: -6
127:     LD  3,-2(1)	Load variable (value) x
* TOFF inc: -5
128:     LD  4,-5(1)	Pop left into ac1 (const value) 
129:    TGT  3,4,3	Op > 
* THEN
* EXPRESSION
131:    LDA  3,-4(1)	Load variable (address) newguess
132:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
133:    LDA  3,-4(1)	Load variable (address) newguess
134:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
135:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -6
136:     LD  5,-6(1)	Pop left into ac2 (address) 
137:     LD  4,0(5)	Load left variable into ac1 (value) 
138:    SUB  3,4,3	Op - 
* TOFF inc: -5
139:     LD  5,-5(1)	Pop left into ac2 (variable address) 
140:     LD  4,0(5)	Load left variable into ac1 (value) 
141:     ST  3,0(5)	Store variable newguess
130:    JZR  3,11(7)	Jump around the THEN if false [backpatch] 
* RETURN
142:     LD  3,-4(1)	Load variable (value) newguess
143:    LDA  2,0(3)	Copy result to return register 
144:     LD  3,-1(1)	Load return address 
145:     LD  1,0(1)	Adjust fp 
146:    JMP  7,0(3)	Return 
* TOFF set: -3
* END COMPOUND
* Add standard closing in case there is no return statement
147:    LDC  2,0(6)	Set return value to 0 
148:     LD  3,-1(1)	Load return address 
149:     LD  1,0(1)	Adjust fp 
150:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION sqrt
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
151:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -4
* Compound Body
* Compound body
* WHILE
* EXPRESSION
* EXPRESSION
152:    LDA  3,-2(1)	Load variable (address) n
153:     ST  3,-4(1)	Push left side (store variable address in frame) 
* TOFF dec: -5
* EXPRESSION
* CALL input
154:     ST  1,-5(1)	Store fp in ghost frame for input
* TOFF dec: -6
* TOFF dec: -7
* Param end input
155:    LDA  1,-5(1)	Ghost frame becomes new active frame 
156:    LDA  3,1(7)	Return address in ac 
157:    JMP  7,-157(7)	CALL input
* Call end input
* TOFF set: -5
158:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -4
159:     LD  5,-4(1)	Pop left into ac2 (variable address) 
160:     LD  4,0(5)	Load left variable into ac1 (value) 
161:     ST  3,0(5)	Store variable n
162:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -3
163:     LD  4,-3(1)	Pop left into ac1 (const value) 
164:    TGT  3,4,3	Op > 
165:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
167:    LDA  3,-4(1)	Load variable (address) limit
168:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
* CALL sqrt
169:     ST  1,-6(1)	Store fp in ghost frame for sqrt
* TOFF dec: -7
* TOFF dec: -8
* Param 1
170:     LD  3,-2(1)	Load variable (value) n
171:     ST  3,-8(1)	Push parameter 
* TOFF dec: -9
* Param end sqrt
172:    LDA  1,-6(1)	Ghost frame becomes new active frame 
173:    LDA  3,1(7)	Return address in ac 
174:    JMP  7,-136(7)	CALL sqrt
* Call end sqrt
* TOFF set: -6
175:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -5
176:     LD  5,-5(1)	Pop left into ac2 (variable address) 
177:     LD  4,0(5)	Load left variable into ac1 (value) 
178:     ST  3,0(5)	Store variable limit
* WHILE
* EXPRESSION
* EXPRESSION
179:    LDA  3,-2(1)	Load variable (address) n
180:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
181:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -5
182:     LD  5,-5(1)	Pop left into ac2 (address) 
183:     LD  4,0(5)	Load left variable into ac1 (value) 
184:    MOD  3,4,3	Op % 
185:     ST  3,-5(1)	Push operation result 
* TOFF dec: -6
186:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -5
187:     LD  4,-5(1)	Pop left into ac1 (const value) 
188:    TEQ  3,4,3	Op == 
189:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
* CALL output
191:     ST  1,-5(1)	Store fp in ghost frame for output
* TOFF dec: -6
* TOFF dec: -7
* Param 1
192:    LDC  3,2(6)	Load integer constant 
193:     ST  3,-7(1)	Push parameter 2
* TOFF dec: -8
* Param end output
194:    LDA  1,-5(1)	Ghost frame becomes new active frame 
195:    LDA  3,1(7)	Return address in ac 
196:    JMP  7,-191(7)	CALL output
* Call end output
* TOFF set: -5
197:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
198:    LDA  3,-2(1)	Load variable (address) n
199:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
200:    LDA  3,-2(1)	Load variable (address) n
201:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
202:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -6
203:     LD  5,-6(1)	Pop left into ac2 (address) 
204:     LD  4,0(5)	Load left variable into ac1 (value) 
205:    DIV  3,4,3	Op / 
* TOFF inc: -5
206:     LD  5,-5(1)	Pop left into ac2 (variable address) 
207:     LD  4,0(5)	Load left variable into ac1 (value) 
208:     ST  3,0(5)	Store variable n
* TOFF set: -5
* END COMPOUND
209:    JMP  7,-31(7)	go to beginning of loop 
190:    JMP  7,19(7)	Jump past loop [backpatch] 
* END WHILE
* EXPRESSION
210:    LDA  3,-3(1)	Load variable (address) i
211:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
212:    LDC  3,3(6)	Load integer constant 
* TOFF inc: -5
213:     LD  5,-5(1)	Pop left into ac2 (variable address) 
214:     LD  4,0(5)	Load left variable into ac1 (value) 
215:     ST  3,0(5)	Store variable i
* WHILE
* EXPRESSION
216:    LDA  3,-3(1)	Load variable (address) i
217:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
218:     LD  3,-4(1)	Load variable (value) limit
* TOFF inc: -5
219:     LD  5,-5(1)	Pop left into ac2 (address) 
220:     LD  4,0(5)	Load left variable into ac1 (value) 
221:    TLE  3,4,3	Op <= 
222:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* WHILE
* EXPRESSION
* EXPRESSION
224:    LDA  3,-2(1)	Load variable (address) n
225:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
226:     LD  3,-3(1)	Load variable (value) i
* TOFF inc: -5
227:     LD  5,-5(1)	Pop left into ac2 (address) 
228:     LD  4,0(5)	Load left variable into ac1 (value) 
229:    MOD  3,4,3	Op % 
230:     ST  3,-5(1)	Push operation result 
* TOFF dec: -6
231:    LDC  3,0(6)	Load integer constant 
* TOFF inc: -5
232:     LD  4,-5(1)	Pop left into ac1 (const value) 
233:    TEQ  3,4,3	Op == 
234:    JNZ  3,1(7)	Jump to while part 
* DO
* COMPOUND
* TOFF set: -5
* Compound Body
* Compound body
* EXPRESSION
* CALL output
236:     ST  1,-5(1)	Store fp in ghost frame for output
* TOFF dec: -6
* TOFF dec: -7
* Param 1
237:     LD  3,-3(1)	Load variable (value) i
238:     ST  3,-7(1)	Push parameter 
* TOFF dec: -8
* Param end output
239:    LDA  1,-5(1)	Ghost frame becomes new active frame 
240:    LDA  3,1(7)	Return address in ac 
241:    JMP  7,-236(7)	CALL output
* Call end output
* TOFF set: -5
242:    LDA  3,0(2)	Save the result in ac 
* EXPRESSION
243:    LDA  3,-2(1)	Load variable (address) n
244:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
245:    LDA  3,-2(1)	Load variable (address) n
246:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
247:     LD  3,-3(1)	Load variable (value) i
* TOFF inc: -6
248:     LD  5,-6(1)	Pop left into ac2 (address) 
249:     LD  4,0(5)	Load left variable into ac1 (value) 
250:    DIV  3,4,3	Op / 
* TOFF inc: -5
251:     LD  5,-5(1)	Pop left into ac2 (variable address) 
252:     LD  4,0(5)	Load left variable into ac1 (value) 
253:     ST  3,0(5)	Store variable n
* EXPRESSION
254:    LDA  3,-4(1)	Load variable (address) limit
255:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
* CALL sqrt
256:     ST  1,-6(1)	Store fp in ghost frame for sqrt
* TOFF dec: -7
* TOFF dec: -8
* Param 1
257:     LD  3,-2(1)	Load variable (value) n
258:     ST  3,-8(1)	Push parameter 
* TOFF dec: -9
* Param end sqrt
259:    LDA  1,-6(1)	Ghost frame becomes new active frame 
260:    LDA  3,1(7)	Return address in ac 
261:    JMP  7,-223(7)	CALL sqrt
* Call end sqrt
* TOFF set: -6
262:    LDA  3,0(2)	Save the result in ac 
* TOFF inc: -5
263:     LD  5,-5(1)	Pop left into ac2 (variable address) 
264:     LD  4,0(5)	Load left variable into ac1 (value) 
265:     ST  3,0(5)	Store variable limit
* TOFF set: -5
* END COMPOUND
266:    JMP  7,-43(7)	go to beginning of loop 
235:    JMP  7,31(7)	Jump past loop [backpatch] 
* END WHILE
* EXPRESSION
267:    LDA  3,-3(1)	Load variable (address) i
268:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
* EXPRESSION
269:    LDA  3,-3(1)	Load variable (address) i
270:     ST  3,-6(1)	Push left side (store variable address in frame) 
* TOFF dec: -7
271:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -6
272:     LD  5,-6(1)	Pop left into ac2 (address) 
273:     LD  4,0(5)	Load left variable into ac1 (value) 
274:    ADD  3,4,3	Op + 
* TOFF inc: -5
275:     LD  5,-5(1)	Pop left into ac2 (variable address) 
276:     LD  4,0(5)	Load left variable into ac1 (value) 
277:     ST  3,0(5)	Store variable i
* TOFF set: -5
* END COMPOUND
278:    JMP  7,-63(7)	go to beginning of loop 
223:    JMP  7,55(7)	Jump past loop [backpatch] 
* END WHILE
* IF
* EXPRESSION
279:    LDA  3,-2(1)	Load variable (address) n
280:     ST  3,-5(1)	Push left side (store variable address in frame) 
* TOFF dec: -6
281:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -5
282:     LD  5,-5(1)	Pop left into ac2 (address) 
283:     LD  4,0(5)	Load left variable into ac1 (value) 
284:    TGT  3,4,3	Op > 
* THEN
* EXPRESSION
* CALL output
286:     ST  1,-5(1)	Store fp in ghost frame for output
* TOFF dec: -6
* TOFF dec: -7
* Param 1
287:     LD  3,-2(1)	Load variable (value) n
288:     ST  3,-7(1)	Push parameter 
* TOFF dec: -8
* Param end output
289:    LDA  1,-5(1)	Ghost frame becomes new active frame 
290:    LDA  3,1(7)	Return address in ac 
291:    JMP  7,-286(7)	CALL output
* Call end output
* TOFF set: -5
292:    LDA  3,0(2)	Save the result in ac 
285:    JZR  3,7(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
* CALL outnl
293:     ST  1,-5(1)	Store fp in ghost frame for outnl
* TOFF dec: -6
* TOFF dec: -7
* Param end outnl
294:    LDA  1,-5(1)	Ghost frame becomes new active frame 
295:    LDA  3,1(7)	Return address in ac 
296:    JMP  7,-263(7)	CALL outnl
* Call end outnl
* TOFF set: -5
297:    LDA  3,0(2)	Save the result in ac 
* TOFF set: -3
* END COMPOUND
298:    JMP  7,-147(7)	go to beginning of loop 
166:    JMP  7,132(7)	Jump past loop [backpatch] 
* END WHILE
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
299:    LDC  2,0(6)	Set return value to 0 
300:     LD  3,-1(1)	Load return address 
301:     LD  1,0(1)	Adjust fp 
302:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,302(7)	Jump to init [backpatch] 
* INIT
303:    LDA  1,0(0)	set first frame at end of globals 
304:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
305:    LDA  3,1(7)	Return address in ac 
306:    JMP  7,-156(7)	Jump to main 
307:   HALT  0,0,0	DONE! 
* END INIT
