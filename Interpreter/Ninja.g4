grammar Ninja;


program : function* main function*;

main : main_signature OBRACE code CBRACE;

main_signature : FUN_KEYWORD VOID MAIN OBRACKET CBRACKET ;

function : fun_signature OBRACE code CBRACE;

fun_signature : FUN_KEYWORD (MEANINGFUL_TYPE | VOID) WORD OBRACKET params CBRACKET ;

code : (CALL | CUSTOM_CALL)* ;

MAIN : 'main' ;

FUN_KEYWORD : 'fun' ;

MEANINGFUL_TYPE : ('int'|'double'|'bool') ;

params : (var_signature (COMMA var_signature)*)|();

var_signature : MEANINGFUL_TYPE WORD;

VOID : 'void' ;

COMMA : ',' ;

OBRACE : '{' ;
CBRACE : '}' ;

OBRACKET : '(' ;
CBRACKET : ')' ;

WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

BOOL : ('true'|'false') ;
DOUBLE : [+-]?DIGIT*[.]DIGIT+ ;
INT : [+-]?DIGIT+ ; // references the DIGIT helper rule
fragment DIGIT : [0-9] ; // not a token by itself

WORD : [a-zA-Z]+ ;

STRING : '"'[a-zA-Z]*'"' ;

BUILTIN_FUNC : ('hit'|'move'|'turn'|'shoot') ;

CALL : BUILTIN_FUNC OBRACKET (INT|DOUBLE|BOOL|WORD) CBRACKET ;

CUSTOM_CALL : WORD OBRACKET (INT|DOUBLE|BOOL|WORD) CBRACKET ;