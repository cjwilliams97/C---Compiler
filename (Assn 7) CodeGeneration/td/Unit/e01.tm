* C- compiler version C-S21
* Built: Apr 22, 2021
* Author: Connor Williams
* File compiled: Unit/e01.c-
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
* TOFF set: -3
* Compound Body
* Compound body
* IF
 40:    LDC  3,1(6)	Load Boolean constant 
* THEN
* EXPRESSION
* CALL output
 42:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 43:    LDC  3,13(6)	Load integer constant 
 44:     ST  3,-5(1)	Push parameter 13
* TOFF dec: -6
* Param end output
 45:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 46:    LDA  3,1(7)	Return address in ac 
 47:    JMP  7,-42(7)	CALL output
 48:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
 41:    JZR  3,7(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
* CALL output
 49:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 50:    LDC  3,23(6)	Load integer constant 
 51:     ST  3,-5(1)	Push parameter 23
* TOFF dec: -6
* Param end output
 52:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 53:    LDA  3,1(7)	Return address in ac 
 54:    JMP  7,-49(7)	CALL output
 55:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
* EXPRESSION
* CALL outnl
 56:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 57:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 58:    LDA  3,1(7)	Return address in ac 
 59:    JMP  7,-26(7)	CALL outnl
 60:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* EXPRESSION
 61:    LDA  3,-2(1)	Load variable (address) x
 62:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
 63:    LDC  3,0(6)	Load Boolean constant 
* TOFF inc: -3
 64:     LD  5,-3(1)	Pop left into ac2 (variable address) 
 65:     LD  4,0(5)	Load left variable into ac1 (value) 
 66:     ST  3,0(5)	Store variable x
* IF
 67:     LD  3,-2(1)	Load variable (value) x
* THEN
* EXPRESSION
* CALL output
 69:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 70:    LDC  3,44(6)	Load integer constant 
 71:     ST  3,-5(1)	Push parameter 44
* TOFF dec: -6
* Param end output
 72:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 73:    LDA  3,1(7)	Return address in ac 
 74:    JMP  7,-69(7)	CALL output
 75:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
 68:    JZR  3,7(7)	Jump around the THEN if false [backpatch] 
* IF
* EXPRESSION
 76:     LD  3,-2(1)	Load variable (value) x
 77:    LDC  4,1(6)	Load 1 
 78:    XOR  3,3,4	Op XOR to get logical not 
* THEN
* EXPRESSION
* CALL output
 80:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 81:    LDC  3,55(6)	Load integer constant 
 82:     ST  3,-5(1)	Push parameter 55
* TOFF dec: -6
* Param end output
 83:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 84:    LDA  3,1(7)	Return address in ac 
 85:    JMP  7,-80(7)	CALL output
 86:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
 79:    JZR  3,7(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
* CALL outnl
 87:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
 88:    LDA  1,-3(1)	Ghost frame becomes new active frame 
 89:    LDA  3,1(7)	Return address in ac 
 90:    JMP  7,-57(7)	CALL outnl
 91:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* IF
* EXPRESSION
 92:    LDC  3,3(6)	Load integer constant 
 93:     ST  3,-3(1)	Push left side (store const value in temp loc in frame) 
* TOFF dec: -4
 94:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -3
 95:     LD  4,-3(1)	Pop left into ac1 (const value) 
 96:    TGT  3,4,3	Op > 
* THEN
* EXPRESSION
* CALL output
 98:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
 99:    LDC  3,987(6)	Load integer constant 
100:     ST  3,-5(1)	Push parameter 987
* TOFF dec: -6
* Param end output
101:    LDA  1,-3(1)	Ghost frame becomes new active frame 
102:    LDA  3,1(7)	Return address in ac 
103:    JMP  7,-98(7)	CALL output
104:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
 97:    JZR  3,7(7)	Jump around the THEN if false [backpatch] 
* IF
* EXPRESSION
105:    LDC  3,3(6)	Load integer constant 
106:     ST  3,-3(1)	Push left side (store const value in temp loc in frame) 
* TOFF dec: -4
107:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -3
108:     LD  4,-3(1)	Pop left into ac1 (const value) 
109:    TLT  3,4,3	Op < 
* THEN
* EXPRESSION
* CALL output
111:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
112:    LDC  3,211(6)	Load integer constant 
113:     ST  3,-5(1)	Push parameter 211
* TOFF dec: -6
* Param end output
114:    LDA  1,-3(1)	Ghost frame becomes new active frame 
115:    LDA  3,1(7)	Return address in ac 
116:    JMP  7,-111(7)	CALL output
117:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
110:    JZR  3,7(7)	Jump around the THEN if false [backpatch] 
* EXPRESSION
* CALL outnl
118:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
119:    LDA  1,-3(1)	Ghost frame becomes new active frame 
120:    LDA  3,1(7)	Return address in ac 
121:    JMP  7,-88(7)	CALL outnl
122:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* IF
123:    LDC  3,1(6)	Load Boolean constant 
* THEN
* EXPRESSION
* CALL output
125:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
126:    LDC  3,13(6)	Load integer constant 
127:     ST  3,-5(1)	Push parameter 13
* TOFF dec: -6
* Param end output
128:    LDA  1,-3(1)	Ghost frame becomes new active frame 
129:    LDA  3,1(7)	Return address in ac 
130:    JMP  7,-125(7)	CALL output
131:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
124:    JZR  3,8(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
* CALL output
133:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
134:    LDC  3,51(6)	Load integer constant 
135:     ST  3,-5(1)	Push parameter 51
* TOFF dec: -6
* Param end output
136:    LDA  1,-3(1)	Ghost frame becomes new active frame 
137:    LDA  3,1(7)	Return address in ac 
138:    JMP  7,-133(7)	CALL output
139:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
132:    JMP  7,7(7)	Jump around the ELSE [backpatch] 
* IF
140:    LDC  3,0(6)	Load Boolean constant 
* THEN
* EXPRESSION
* CALL output
142:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
143:    LDC  3,23(6)	Load integer constant 
144:     ST  3,-5(1)	Push parameter 23
* TOFF dec: -6
* Param end output
145:    LDA  1,-3(1)	Ghost frame becomes new active frame 
146:    LDA  3,1(7)	Return address in ac 
147:    JMP  7,-142(7)	CALL output
148:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
141:    JZR  3,8(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
* CALL output
150:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
151:    LDC  3,451(6)	Load integer constant 
152:     ST  3,-5(1)	Push parameter 451
* TOFF dec: -6
* Param end output
153:    LDA  1,-3(1)	Ghost frame becomes new active frame 
154:    LDA  3,1(7)	Return address in ac 
155:    JMP  7,-150(7)	CALL output
156:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
149:    JMP  7,7(7)	Jump around the ELSE [backpatch] 
* EXPRESSION
* CALL outnl
157:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
158:    LDA  1,-3(1)	Ghost frame becomes new active frame 
159:    LDA  3,1(7)	Return address in ac 
160:    JMP  7,-127(7)	CALL outnl
161:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* EXPRESSION
162:    LDA  3,-2(1)	Load variable (address) x
163:     ST  3,-3(1)	Push left side (store variable address in frame) 
* TOFF dec: -4
164:    LDC  3,0(6)	Load Boolean constant 
* TOFF inc: -3
165:     LD  5,-3(1)	Pop left into ac2 (variable address) 
166:     LD  4,0(5)	Load left variable into ac1 (value) 
167:     ST  3,0(5)	Store variable x
* IF
168:     LD  3,-2(1)	Load variable (value) x
* THEN
* EXPRESSION
* CALL output
170:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
171:    LDC  3,44(6)	Load integer constant 
172:     ST  3,-5(1)	Push parameter 44
* TOFF dec: -6
* Param end output
173:    LDA  1,-3(1)	Ghost frame becomes new active frame 
174:    LDA  3,1(7)	Return address in ac 
175:    JMP  7,-170(7)	CALL output
176:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
169:    JZR  3,8(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
* CALL output
178:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
179:    LDC  3,514(6)	Load integer constant 
180:     ST  3,-5(1)	Push parameter 514
* TOFF dec: -6
* Param end output
181:    LDA  1,-3(1)	Ghost frame becomes new active frame 
182:    LDA  3,1(7)	Return address in ac 
183:    JMP  7,-178(7)	CALL output
184:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
177:    JMP  7,7(7)	Jump around the ELSE [backpatch] 
* IF
* EXPRESSION
185:     LD  3,-2(1)	Load variable (value) x
186:    LDC  4,1(6)	Load 1 
187:    XOR  3,3,4	Op XOR to get logical not 
* THEN
* EXPRESSION
* CALL output
189:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
190:    LDC  3,55(6)	Load integer constant 
191:     ST  3,-5(1)	Push parameter 55
* TOFF dec: -6
* Param end output
192:    LDA  1,-3(1)	Ghost frame becomes new active frame 
193:    LDA  3,1(7)	Return address in ac 
194:    JMP  7,-189(7)	CALL output
195:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
188:    JZR  3,8(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
* CALL output
197:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
198:    LDC  3,1514(6)	Load integer constant 
199:     ST  3,-5(1)	Push parameter 1514
* TOFF dec: -6
* Param end output
200:    LDA  1,-3(1)	Ghost frame becomes new active frame 
201:    LDA  3,1(7)	Return address in ac 
202:    JMP  7,-197(7)	CALL output
203:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
196:    JMP  7,7(7)	Jump around the ELSE [backpatch] 
* EXPRESSION
* CALL outnl
204:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
205:    LDA  1,-3(1)	Ghost frame becomes new active frame 
206:    LDA  3,1(7)	Return address in ac 
207:    JMP  7,-174(7)	CALL outnl
208:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* IF
* EXPRESSION
209:    LDC  3,3(6)	Load integer constant 
210:     ST  3,-3(1)	Push left side (store const value in temp loc in frame) 
* TOFF dec: -4
211:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -3
212:     LD  4,-3(1)	Pop left into ac1 (const value) 
213:    TGT  3,4,3	Op > 
* THEN
* EXPRESSION
* CALL output
215:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
216:    LDC  3,987(6)	Load integer constant 
217:     ST  3,-5(1)	Push parameter 987
* TOFF dec: -6
* Param end output
218:    LDA  1,-3(1)	Ghost frame becomes new active frame 
219:    LDA  3,1(7)	Return address in ac 
220:    JMP  7,-215(7)	CALL output
221:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
214:    JZR  3,8(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
* CALL output
223:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
224:    LDC  3,114(6)	Load integer constant 
225:     ST  3,-5(1)	Push parameter 114
* TOFF dec: -6
* Param end output
226:    LDA  1,-3(1)	Ghost frame becomes new active frame 
227:    LDA  3,1(7)	Return address in ac 
228:    JMP  7,-223(7)	CALL output
229:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
222:    JMP  7,7(7)	Jump around the ELSE [backpatch] 
* IF
* EXPRESSION
230:    LDC  3,3(6)	Load integer constant 
231:     ST  3,-3(1)	Push left side (store const value in temp loc in frame) 
* TOFF dec: -4
232:    LDC  3,1(6)	Load integer constant 
* TOFF inc: -3
233:     LD  4,-3(1)	Pop left into ac1 (const value) 
234:    TLT  3,4,3	Op < 
* THEN
* EXPRESSION
* CALL output
236:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
237:    LDC  3,211(6)	Load integer constant 
238:     ST  3,-5(1)	Push parameter 211
* TOFF dec: -6
* Param end output
239:    LDA  1,-3(1)	Ghost frame becomes new active frame 
240:    LDA  3,1(7)	Return address in ac 
241:    JMP  7,-236(7)	CALL output
242:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
235:    JZR  3,8(7)	Jump around the THEN if false [backpatch] 
* ELSE
* EXPRESSION
* CALL output
244:     ST  1,-3(1)	Store fp in ghost frame for output
* TOFF dec: -4
* TOFF dec: -5
* Param 1
245:    LDC  3,1614(6)	Load integer constant 
246:     ST  3,-5(1)	Push parameter 1614
* TOFF dec: -6
* Param end output
247:    LDA  1,-3(1)	Ghost frame becomes new active frame 
248:    LDA  3,1(7)	Return address in ac 
249:    JMP  7,-244(7)	CALL output
250:    LDA  3,0(2)	Save the result in ac 
* Call end output
* TOFF set: -3
243:    JMP  7,7(7)	Jump around the ELSE [backpatch] 
* EXPRESSION
* CALL outnl
251:     ST  1,-3(1)	Store fp in ghost frame for outnl
* TOFF dec: -4
* TOFF dec: -5
* Param end outnl
252:    LDA  1,-3(1)	Ghost frame becomes new active frame 
253:    LDA  3,1(7)	Return address in ac 
254:    JMP  7,-221(7)	CALL outnl
255:    LDA  3,0(2)	Save the result in ac 
* Call end outnl
* TOFF set: -3
* TOFF set: -2
* END COMPOUND
* Add standard closing in case there is no return statement
256:    LDC  2,0(6)	Set return value to 0 
257:     LD  3,-1(1)	Load return address 
258:     LD  1,0(1)	Adjust fp 
259:    JMP  7,0(3)	Return 
* ** ** ** ** ** ** ** ** ** ** ** **
* END FUNCTION main
  0:    JMP  7,259(7)	Jump to init [backpatch] 
* INIT
260:    LDA  1,0(0)	set first frame at end of globals 
261:     ST  1,0(1)	store old fp (point to self) 
* INIT GLOBALS AND STATICS
* END INIT GLOBALS AND STATICS
262:    LDA  3,1(7)	Return address in ac 
263:    JMP  7,-225(7)	Jump to main 
264:   HALT  0,0,0	DONE! 
* END INIT
