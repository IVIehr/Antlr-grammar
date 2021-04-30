grammar Test;

accccess_modifier: (PUBLIC|PRIVATE|PROTECTED)?;
modifier: (ABSTRACT|STATIS|FINAL)?;
data_type: (INT|DOUBLE|FLOAT|STRING|BOOLEAN);
type: (VAR|CONST);

start: orders;
orders: import_declaration* class_definition+;

//import libraries
import_declaration: (imports_all_from|imports_sth_from|imports_sth_as);
imports_all_from: (IMPORT WORD+('.'WORD+)* | FROM WORD+('.'WORD+)* IMPORT)'*'? ';';
imports_sth_from: FROM WORD+('.'WORD+)* IMPORT WORD+('.'WORD+)* (','WORD+('.'WORD+)*)* ';';
imports_sth_as: FROM WORD+('.'WORD+)* IMPORT WORD+('.'WORD+)* '=>' WORD+('.'WORD+)* ';';

//variables and array
variable_declaration:accccess_modifier type (variable|array)+(','accccess_modifier (variable|array))* ';';
variable: WORD (':'data_type)? ('='(STRING_LITERAL|DIGIT+|S_NOTATION|MANTISSA))? ','?;
array: WORD (':' NEW ARRAY '['data_type']''('DIGIT+')'|'='ARRAY '('(DIGIT+|S_NOTATION|MANTISSA)+(','(DIGIT+|S_NOTATION|MANTISSA))* ')');

//class definition
class_definition: accccess_modifier CLASS WORD (EXTENDS WORD)? (IMPLEMENTS WORD (WITH WORD)*)? '{'class_body'}';
class_body: (variable_declaration|method)*;
initialization:WORD('='(STRING_LITERAL|DIGIT+|S_NOTATION|MANTISSA)|WORD)?;
parameters:data_type initialization (','data_type initialization)*;

//methods definition
method: accccess_modifier modifier (data_type|VOID)? WORD ('('parameters?')')?'{'method_body'}'; //normal mthods and constructors
method_body:import_declaration* (code|return_address{1}|exception)+;

//body of methods and blocks
code:(variable_declaration|create_object|attribution|operations|access_internal|loop|if|method_call|switch_case);
create_object:type WORD':' NEW WORD '('(parameters|(DIGIT+|S_NOTATION|MANTISSA|WORD)(','(DIGIT+|S_NOTATION|MANTISSA|WORD))*)?')' ';';
attribution:(THIS'.')? WORD ('+'|'-'|'*'|'/')?'=' WORD ';';
operations: assignment ';';

abreviation:WORD(('+'|'-'|'*'|'/')'=' (WORD|(DIGIT+|S_NOTATION|MANTISSA)) |('++'|'--'));
assignment : WORD exp | operators ('++' | '--');

exp : ('**='|'/='|'//='|'%='|'*='|'<<='|'>>='|'+='|'-='|'&='|'^='|'|='|'=') operators;

operators: '(' operators ')'| <assoc=right> operators '**' operators | '~' operators | ('+' | '-') (DIGIT+|S_NOTATION|MANTISSA)
    | ('++' | '--') operators | operators ('++' | '--')| operators ('*' | '//' | '/' | '%') operators | operators ('+' | '-') operators
    | operators ('<<' | '>>') operators| operators ('&' | '^' | '|') operators | (DIGIT+|S_NOTATION|MANTISSA) | WORD ;


access_internal: WORD('.'WORD)+'('((DIGIT+|S_NOTATION|MANTISSA)|WORD('.'WORD)+)')' ';';
return_address: RETURN (WORD|BOOLEAN|(DIGIT+|S_NOTATION|MANTISSA))';';

loop:(for_type1|for_type2|while|do_while)+;
for_type1: FOR '(' type? parameters? ';' conditions? ';' abreviation?')' '{'loop_body'}' ;
for_type2: FOR '('type? WORD IN WORD ')' '{'loop_body'}';
while: WHILE '('conditions')''{'loop_body'}';
do_while: DO '{'loop_body'}'WHILE '('conditions')' ';';
loop_body: code+ (BREAK ';')?;
comparison:WORD ('<'|'>'|'=='|'!='|'<='|'>=') (DIGIT+|S_NOTATION|MANTISSA|WORD);
conditions: (WORD('=='|'!=')BOOLEAN) |(comparison (('&&'|'||')comparison)*);

if: IF'('conditions')' '{'code'}' elif* else?;
elif: ELIF '('conditions')''{'code'}' else?;
else:ELSE '{'?code'}'?;

method_call: WORD '('(STRING_LITERAL|WORD)')' ';';
switch_case: SWITCH '('WORD')' '{' case+ default? '}';
case: CASE (STRING_LITERAL|WORD) ':' code? (BREAK';')?;
default: DEFAULT ':' code (BREAK';')?;

exception: TRY '{' code '}' (ON WORD (CATCH '('WORD')')? '{'code'}'| CATCH '('WORD')''{'code'}')+ ;

//lexers
IMPORT: 'import';
FROM: 'from';
VAR: 'var';
CONST: 'const';
ARRAY: 'Array';
INT: ('Int'|'int');
DOUBLE: 'Double';
FLOAT: 'float';
STRING: 'String';
VOID: 'void';
CLASS: 'class';
EXTENDS: 'extends';
IMPLEMENTS: 'implements';
WITH: 'with';
PRIVATE : 'private';
PROTECTED : 'protected';
PUBLIC : 'public';
THIS: 'this';
RETURN: 'return';
NEW: 'new';
FOR: 'for';
IN: 'in';
ON: 'on';
WHILE: 'while';
DO: 'do';
IF: 'if';
ELIF: 'elif';
ELSE: 'else';
SWITCH: 'switch';
CASE: 'case';
DEFAULT: 'default';
BREAK: 'break';
TRY: 'try';
CATCH: 'catch';
BOOLEAN: 'true'|'false';
ABSTRACT: 'abstract';
STATIS: 'static';
FINAL: 'final';

STRING_LITERAL: '"' ( '\\"'| ~[\r\n$"] | '$'~[\r\n{"] | '${' WORD '}' )* '$'? '"';
WORD:[a-zA-Z_$]+[a-zA-Z0-9_$]*;
DIGIT:[0-9];
S_NOTATION: DIGIT'.'(DIGIT+('e''-'?DIGIT+)?);
MANTISSA: DIGIT+'.'DIGIT+;

WS : [ \t\r\n]+ -> skip;
COMMENT_ML: '/*'.*'*/' -> skip;
COMMENT_SL: '//'~[\r\n]* -> skip;

