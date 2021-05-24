* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: array.c-
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
* FUNCTION get
* TOFF set -4
 39:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -4
* Compound Body
* Compound body
* EXPRESSION
* CALL output
 40:     ST  1,-4(1)	Store fp in ghost frame for output
* TOFF dec: -5
* TOFF dec: -6
* Param 1
 41:    LDC  3,0(6)	Load integer constant 
 42:     LD  4,-2(1)	Load address of base of array x
 43:    SUB  3,4,3	compute location from index 
 44:     LD  3,0(3)	Load array element 
 45:     ST  3,-6(1)	Push parameter x
* TOFF dec: -7
* Param end output
 46:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 47:    LDA  3,1(7)	Return address in ac 
 48:    JMP  7,-43(7)	CALL output
 49:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -4
* EXPRESSION
* CALL outnl
 50:     ST  1,-4(1)	Store fp in ghost frame for outnl
* TOFF dec: -5
* TOFF dec: -6
* Param end outnl
 51:    LDA  1,-4(1)	Ghost frame becomes new active frame 
 52:    LDA  3,1(7)	Return address in ac 
 53:    JMP  7,-20(7)	CALL outnl
 54:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -4
* EXPRESSION
 55:    LDC  3,1(6)	Load integer constant 
 56:     LD  4,-2(1)	Load address of base of array x
 57:    SUB  3,4,3	compute location from index 
 58:     ST  3,-4(1)	Push left side (store variable address in frame) x
* TOFF dec: -5
 59:    LDC  3,666(6)	Load integer constant 
* TOFF inc: -4
 60:     LD  5,-4(1)	Pop left into ac2 (variable address) 
 61:     LD  4,0(5)	Load left variable into ac1 (value) 
 62:     ST  3,0(5)	Store variable x
* RETURN
 63:     LD  3,-3(1)	Load variable (value) i
 64:     LD  4,-2(1)	Load address of base of array x
 65:    SUB  3,4,3	compute location from index 
 66:     LD  3,0(3)	Load array element 
 67:    LDA  2,0(3)	Copy result to return register 
 68:     LD  3,-1(1)	Load return address 
 69:     LD  1,0(1)	Adjust fp 
 70:    JMP  7,0(3)	Return 
* TOFF set: -4
* END COMPOUND
* Add standard closing in case there is no return statement
 71:    LDC  2,0(6)	Set return value to 0 
 72:     LD  3,-1(1)	Load return address 
 73:     LD  1,0(1)	Adjust fp 
 74:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION get
* ** ** ** ** ** ** ** ** ** ** ** **
* FUNCTION main
* TOFF set -2
 75:     ST  3,-1(1)	Store return address 
* COMPOUND
* TOFF set: -9
* Compound Body
 76:    LDC  3,5(6)	load size of array x
 77:     ST  3,-2(1)	save size of array x
* Compound body
* EXPRESSION
 78:    LDA  3,-8(1)	Load variable (address) dog
 79:     ST  3,-9(1)	Push left side (store variable address in frame) 
* TOFF dec: -10
 80:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -9
 81:     LD  5,-9(1)	Pop left into ac2 (variable address) 
 82:     LD  4,0(5)	Load left variable into ac1 (value) 
 83:     ST  3,0(5)	Store variable dog
* EXPRESSION
 84:    LDC  3,0(6)	Load integer constant 
 85:    LDA  4,-3(1)	Load address of base of array x
 86:    SUB  3,4,3	compute location from index 
 87:     ST  3,-9(1)	Push left side (store variable address in frame) x
* TOFF dec: -10
 88:    LDC  3,3(6)	Load integer constant 
* TOFF inc: -9
 89:     LD  5,-9(1)	Pop left into ac2 (variable address) 
 90:     LD  4,0(5)	Load left variable into ac1 (value) 
 91:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
 92:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
 93:    LDC  3,0(6)	Load integer constant 
 94:    LDA  4,-3(1)	Load address of base of array x
 95:    SUB  3,4,3	compute location from index 
 96:     LD  3,0(3)	Load array element 
 97:     ST  3,-11(1)	Push parameter x
* TOFF dec: -12
* Param end output
 98:    LDA  1,-9(1)	Ghost frame becomes new active frame 
 99:    LDA  3,1(7)	Return address in ac 
100:    JMP  7,-95(7)	CALL output
101:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
102:    LDC  3,1(6)	Load integer constant 
103:    LDA  4,-3(1)	Load address of base of array x
104:    SUB  3,4,3	compute location from index 
105:     ST  3,-9(1)	Push left side (store variable address in frame) x
* TOFF dec: -10
106:    LDC  3,0(6)	Load integer constant 
107:    LDA  4,-3(1)	Load address of base of array x
108:    SUB  3,4,3	compute location from index 
109:     LD  3,0(3)	Load array element 
* TOFF inc: -9
110:     LD  5,-9(1)	Pop left into ac2 (variable address) 
111:     LD  4,0(5)	Load left variable into ac1 (value) 
112:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
113:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
114:    LDC  3,1(6)	Load integer constant 
115:    LDA  4,-3(1)	Load address of base of array x
116:    SUB  3,4,3	compute location from index 
117:     LD  3,0(3)	Load array element 
118:     ST  3,-11(1)	Push parameter x
* TOFF dec: -12
* Param end output
119:    LDA  1,-9(1)	Ghost frame becomes new active frame 
120:    LDA  3,1(7)	Return address in ac 
121:    JMP  7,-116(7)	CALL output
122:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
123:    LDC  3,2(6)	Load integer constant 
124:    LDA  4,-3(1)	Load address of base of array x
125:    SUB  3,4,3	compute location from index 
126:     ST  3,-9(1)	Push left side (store variable address in frame) x
* TOFF dec: -10
* EXPRESSION
127:    LDC  3,1(6)	Load integer constant 
128:    LDA  4,-3(1)	Load address of base of array x
129:    SUB  3,4,3	compute location from index 
130:     ST  3,-10(1)	Push left side (store variable address in frame) x
* TOFF dec: -11
131:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -10
132:     LD  5,-10(1)	Pop left into ac2 (address) 
133:     LD  4,0(5)	Load left variable into ac1 (value) 
134:    ADD  3,4,3	Op + 
* TOFF inc: -9
135:     LD  5,-9(1)	Pop left into ac2 (variable address) 
136:     LD  4,0(5)	Load left variable into ac1 (value) 
137:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
138:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
139:    LDC  3,2(6)	Load integer constant 
140:    LDA  4,-3(1)	Load address of base of array x
141:    SUB  3,4,3	compute location from index 
142:     LD  3,0(3)	Load array element 
143:     ST  3,-11(1)	Push parameter x
* TOFF dec: -12
* Param end output
144:    LDA  1,-9(1)	Ghost frame becomes new active frame 
145:    LDA  3,1(7)	Return address in ac 
146:    JMP  7,-141(7)	CALL output
147:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
* EXPRESSION
148:    LDA  3,-8(1)	Load variable (address) dog
149:     ST  3,-9(1)	Push left side (store variable address in frame) 
* TOFF dec: -10
150:     LD  3,-8(1)	Load variable (value) dog
* TOFF inc: -9
151:     LD  5,-9(1)	Pop left into ac2 (address) 
152:     LD  4,0(5)	Load left variable into ac1 (value) 
153:    ADD  3,4,3	Op + 
154:    LDA  4,-3(1)	Load address of base of array x
155:    SUB  3,4,3	compute location from index 
156:     ST  3,-9(1)	Push left side (store variable address in frame) x
* TOFF dec: -10
157:    LDC  3,496(6)	Load integer constant 
* TOFF inc: -9
158:     LD  5,-9(1)	Pop left into ac2 (variable address) 
159:     LD  4,0(5)	Load left variable into ac1 (value) 
160:     ST  3,0(5)	Store variable x
* EXPRESSION
* CALL output
161:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
162:    LDC  3,4(6)	Load integer constant 
163:    LDA  4,-3(1)	Load address of base of array x
164:    SUB  3,4,3	compute location from index 
165:     LD  3,0(3)	Load array element 
166:     ST  3,-11(1)	Push parameter x
* TOFF dec: -12
* Param end output
167:    LDA  1,-9(1)	Ghost frame becomes new active frame 
168:    LDA  3,1(7)	Return address in ac 
169:    JMP  7,-164(7)	CALL output
170:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
* CALL outnl
171:     ST  1,-9(1)	Store fp in ghost frame for outnl
* TOFF dec: -10
* TOFF dec: -11
* Param end outnl
172:    LDA  1,-9(1)	Ghost frame becomes new active frame 
173:    LDA  3,1(7)	Return address in ac 
174:    JMP  7,-141(7)	CALL outnl
175:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -9
* EXPRESSION
176:    LDA  3,-8(1)	Load variable (address) dog
177:     ST  3,-9(1)	Push left side (store variable address in frame) 
* TOFF dec: -10
178:    LDC  3,2(6)	Load integer constant 
* TOFF inc: -9
179:     LD  5,-9(1)	Pop left into ac2 (variable address) 
180:     LD  4,0(5)	Load left variable into ac1 (value) 
181:     ST  3,0(5)	Store variable dog
* EXPRESSION
182:    LDC  3,0(6)	Load integer constant 
183:    LDA  4,-1(0)	Load address of base of array y
184:    SUB  3,4,3	compute location from index 
185:     ST  3,-9(1)	Push left side (store variable address in frame) y
* TOFF dec: -10
186:    LDC  3,3(6)	Load integer constant 
* TOFF inc: -9
187:     LD  5,-9(1)	Pop left into ac2 (variable address) 
188:     LD  4,0(5)	Load left variable into ac1 (value) 
189:     ST  3,0(5)	Store variable y
* EXPRESSION
* CALL output
190:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
191:    LDC  3,0(6)	Load integer constant 
192:    LDA  4,-1(0)	Load address of base of array y
193:    SUB  3,4,3	compute location from index 
194:     LD  3,0(3)	Load array element 
195:     ST  3,-11(1)	Push parameter y
* TOFF dec: -12
* Param end output
196:    LDA  1,-9(1)	Ghost frame becomes new active frame 
197:    LDA  3,1(7)	Return address in ac 
198:    JMP  7,-193(7)	CALL output
199:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
200:    LDC  3,1(6)	Load integer constant 
201:    LDA  4,-1(0)	Load address of base of array y
202:    SUB  3,4,3	compute location from index 
203:     ST  3,-9(1)	Push left side (store variable address in frame) y
* TOFF dec: -10
204:    LDC  3,0(6)	Load integer constant 
205:    LDA  4,-1(0)	Load address of base of array y
206:    SUB  3,4,3	compute location from index 
207:     LD  3,0(3)	Load array element 
* TOFF inc: -9
208:     LD  5,-9(1)	Pop left into ac2 (variable address) 
209:     LD  4,0(5)	Load left variable into ac1 (value) 
210:     ST  3,0(5)	Store variable y
* EXPRESSION
* CALL output
211:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
212:    LDC  3,1(6)	Load integer constant 
213:    LDA  4,-1(0)	Load address of base of array y
214:    SUB  3,4,3	compute location from index 
215:     LD  3,0(3)	Load array element 
216:     ST  3,-11(1)	Push parameter y
* TOFF dec: -12
* Param end output
217:    LDA  1,-9(1)	Ghost frame becomes new active frame 
218:    LDA  3,1(7)	Return address in ac 
219:    JMP  7,-214(7)	CALL output
220:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
221:    LDC  3,2(6)	Load integer constant 
222:    LDA  4,-1(0)	Load address of base of array y
223:    SUB  3,4,3	compute location from index 
224:     ST  3,-9(1)	Push left side (store variable address in frame) y
* TOFF dec: -10
* EXPRESSION
225:    LDC  3,1(6)	Load integer constant 
226:    LDA  4,-1(0)	Load address of base of array y
227:    SUB  3,4,3	compute location from index 
228:     ST  3,-10(1)	Push left side (store variable address in frame) y
* TOFF dec: -11
229:    LDC  3,311(6)	Load integer constant 
* TOFF inc: -10
230:     LD  5,-10(1)	Pop left into ac2 (address) 
231:     LD  4,0(5)	Load left variable into ac1 (value) 
232:    ADD  3,4,3	Op + 
* TOFF inc: -9
233:     LD  5,-9(1)	Pop left into ac2 (variable address) 
234:     LD  4,0(5)	Load left variable into ac1 (value) 
235:     ST  3,0(5)	Store variable y
* EXPRESSION
* CALL output
236:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
237:    LDC  3,2(6)	Load integer constant 
238:    LDA  4,-1(0)	Load address of base of array y
239:    SUB  3,4,3	compute location from index 
240:     LD  3,0(3)	Load array element 
241:     ST  3,-11(1)	Push parameter y
* TOFF dec: -12
* Param end output
242:    LDA  1,-9(1)	Ghost frame becomes new active frame 
243:    LDA  3,1(7)	Return address in ac 
244:    JMP  7,-239(7)	CALL output
245:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
* EXPRESSION
246:    LDA  3,-8(1)	Load variable (address) dog
247:     ST  3,-9(1)	Push left side (store variable address in frame) 
* TOFF dec: -10
248:     LD  3,-8(1)	Load variable (value) dog
* TOFF inc: -9
249:     LD  5,-9(1)	Pop left into ac2 (address) 
250:     LD  4,0(5)	Load left variable into ac1 (value) 
251:    ADD  3,4,3	Op + 
252:    LDA  4,-1(0)	Load address of base of array y
253:    SUB  3,4,3	compute location from index 
254:     ST  3,-9(1)	Push left side (store variable address in frame) y
* TOFF dec: -10
255:    LDC  3,496(6)	Load integer constant 
* TOFF inc: -9
256:     LD  5,-9(1)	Pop left into ac2 (variable address) 
257:     LD  4,0(5)	Load left variable into ac1 (value) 
258:     ST  3,0(5)	Store variable y
* EXPRESSION
* CALL output
259:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
260:    LDC  3,4(6)	Load integer constant 
261:    LDA  4,-1(0)	Load address of base of array y
262:    SUB  3,4,3	compute location from index 
263:     LD  3,0(3)	Load array element 
264:     ST  3,-11(1)	Push parameter y
* TOFF dec: -12
* Param end output
265:    LDA  1,-9(1)	Ghost frame becomes new active frame 
266:    LDA  3,1(7)	Return address in ac 
267:    JMP  7,-262(7)	CALL output
268:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
* CALL outnl
269:     ST  1,-9(1)	Store fp in ghost frame for outnl
* TOFF dec: -10
* TOFF dec: -11
* Param end outnl
270:    LDA  1,-9(1)	Ghost frame becomes new active frame 
271:    LDA  3,1(7)	Return address in ac 
272:    JMP  7,-239(7)	CALL outnl
273:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -9
* EXPRESSION
274:    LDA  3,-8(1)	Load variable (address) dog
275:     ST  3,-9(1)	Push left side (store variable address in frame) 
* TOFF dec: -10
* EXPRESSION
* CALL get
276:     ST  1,-10(1)	Store fp in ghost frame for get
* TOFF dec: -11
* TOFF dec: -12
* Param 1
277:    LDA  3,-1(0)	Load address of base of array y
278:     ST  3,-12(1)	Push parameter 
* TOFF dec: -13
* Param 2
279:    LDC  3,2(6)	Load integer constant 
280:     ST  3,-13(1)	Push parameter 2
* TOFF dec: -14
* Param end get
281:    LDA  1,-10(1)	Ghost frame becomes new active frame 
282:    LDA  3,1(7)	Return address in ac 
283:    JMP  7,-245(7)	CALL get
284:    LDA  3,0(2)	Save the result in ac 
* Call end get
* TOFF set: -10
* TOFF inc: -9
285:     LD  5,-9(1)	Pop left into ac2 (variable address) 
286:     LD  4,0(5)	Load left variable into ac1 (value) 
287:     ST  3,0(5)	Store variable dog
* EXPRESSION
* CALL output
288:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
289:     LD  3,-8(1)	Load variable (value) dog
290:     ST  3,-11(1)	Push parameter 
* TOFF dec: -12
* Param end output
291:    LDA  1,-9(1)	Ghost frame becomes new active frame 
292:    LDA  3,1(7)	Return address in ac 
293:    JMP  7,-288(7)	CALL output
294:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
* CALL output
295:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
* EXPRESSION
* CALL get
296:     ST  1,-11(1)	Store fp in ghost frame for get
* TOFF dec: -12
* TOFF dec: -13
* Param 1
297:    LDA  3,-1(0)	Load address of base of array y
298:     ST  3,-13(1)	Push parameter 
* TOFF dec: -14
* Param 2
299:    LDC  3,2(6)	Load integer constant 
300:     ST  3,-14(1)	Push parameter 2
* TOFF dec: -15
* Param end get
301:    LDA  1,-11(1)	Ghost frame becomes new active frame 
302:    LDA  3,1(7)	Return address in ac 
303:    JMP  7,-265(7)	CALL get
304:    LDA  3,0(2)	Save the result in ac 
* Call end get
* TOFF set: -11
305:     ST  3,-11(1)	Push parameter get
* TOFF dec: -12
* Param end output
306:    LDA  1,-9(1)	Ghost frame becomes new active frame 
307:    LDA  3,1(7)	Return address in ac 
308:    JMP  7,-303(7)	CALL output
309:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
* CALL output
310:     ST  1,-9(1)	Store fp in ghost frame for output
* TOFF dec: -10
* TOFF dec: -11
* Param 1
311:    LDC  3,1(6)	Load integer constant 
312:    LDA  4,-3(1)	Load address of base of array x
313:    SUB  3,4,3	compute location from index 
314:     LD  3,0(3)	Load array element 
315:     ST  3,-11(1)	Push parameter x
* TOFF dec: -12
* Param end output
316:    LDA  1,-9(1)	Ghost frame becomes new active frame 
317:    LDA  3,1(7)	Return address in ac 
318:    JMP  7,-313(7)	CALL output
319:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -9
* EXPRESSION
* CALL outnl
320:     ST  1,-9(1)	Store fp in ghost frame for outnl
* TOFF dec: -10
* TOFF dec: -11
* Param end outnl
321:    LDA  1,-9(1)	Ghost frame becomes new active frame 
322:    LDA  3,1(7)	Return address in ac 
323:    JMP  7,-290(7)	CALL outnl
324:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -9
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
325:    LDC  2,0(6)	Set return value to 0 
326:     LD  3,-1(1)	Load return address 
327:     LD  1,0(1)	Adjust fp 
328:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,328(7)	Jump to init [backpatch] 
* INIT
329:    LDA  1,-6(0)	set first frame at end of globals 
330:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
331:    LDC  3,5(6)	load size of array y
332:     ST  3,0(0)	save size of array y
* END INIT GLOBALS AND STATICS
333:    LDA  3,1(7)	Return address in ac 
334:    JMP  7,-260(7)	Jump to main 
335:   HALT  0,0,0	DONE! 
* END INIT
