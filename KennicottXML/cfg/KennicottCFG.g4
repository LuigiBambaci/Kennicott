/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar ruthCFG;
all: listApp+ EOF;
listApp: loc app+ ;
app: lem?  rdgGrp+ closeApp;
lem: (w+ (occ lemSep? | (range w+ lemSep?) | lemSep)) 
     | (COMM NUM? (CONJ NUM)?);
rdgGrp: (rdg+|noteApp) rdgGrpSep?;
rdg: ((w+ occ?)? (range w+)? (term+)? (w+)?)
     (rasura* w+ rasura*|term+) noteRdg? noteMarg? wits noteRdg? noteMarg? rdgSep?;

w:  lin? HEBW|et;
range: MISSING+ (BRACKET_OP NUM BRACKET_CL MISSING+)?;
loc: chap? verse closeLoc;
term: MAN_DESC;
wits : wit+;
sigl: ((NUM ALPHA_SEQ)| (NUM|ALPHA_SEQ)); 
wit: sigl (marg|kq)? com?;
closeApp: END (TAB|NEWLINE)? | TAB;
closeLoc: END;

noteApp: NOTE_APP_OP (~ (TAB | NEWLINE))*;
kq: (lin? kqWord+)+;
kqWord:  HEBW;


lemSep: VAR_SEP;
rdgGrpSep: VAR_SEP ;
com: COMMA;
occ: (num numSign et?)+;
et : CONJ;
closeMainApp: NEWLINE;
num: NUM;
numSign: NUMEROSIGN ;
chap: num+ chapSep;
chapSep: PUNCT;
verse: num+ ((com num+)+)?;
rasura: RASURA;
lin : LIN;

noteRdg: noteOP? noteTok noteCL?;
noteOP: BRACKET_OP;
noteCL: BRACKET_CL;

noteTok: w+ (term+)?;
noteMarg: marg w+;
marg: MARG;
rdgSep: COMMA | SEMICOLON;

MAN_DESC: 'forte'|'primo videtur' |'bis' | '‸' | 'primo'|'ext.'|'videtur' | 'sup. ras.' | 'sup. ras. dilataté' |
'lit. majorib.' | 'lit. maj.' | 'eras.' | 'lit.' | 
'vox major, et ornata ;' | 'non major ;' | 'major ;' | 'nunc' | 'non punctat.' | 'add marg' | '∾' 
| 'marg. add.' | 'non punct.' |'fin. lin.' | 'delet.' | 'punctis supernè notantur' |
'literis majorib.' | 'lit. major. et ornat.' |'ter' | 'minusc.' ;

LIN: ['];

NOTE_APP_OP: 'Incipit'| 'post' | 'Comm.';

MARG:  'marg.' ;
COMM : 'Com.';
CONJ: 'et';
ALPHA_SEQ : [a-zA-Z]+;

NUM : [0-9]+('.'[0-9]+)?;
RASURA: '*';
HEBW : [\u0590-\u05ff]+(RASURA+[\u0590-\u05ff]+)?;

NEWLINE: ('\n');
NUMEROSIGN: '°';
BRACKET_OP : '(';
BRACKET_CL : ')';
PUNCT : ':'|'?'|'!'|'‘'|'’'|'“'|'”';
MISSING: '-' ;
VAR_SEP: '—';
END: '.';
TAB: [\t];
COMMA : ',';
SEMICOLON: ';';
WS : (' ') -> skip;
LTR: '\u200E' -> skip;
RTL: '\u200F' -> skip;
CR : [\r] -> skip;



