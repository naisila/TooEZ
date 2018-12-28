/* CS315f18_group33.l */

%{
  #include <stdlib.h>
  void yyerror(char *);
%}

%option yylineno

LETTER [a-zA-Z]
DIGIT [0-9]
ID_CHARS {LETTER}|{DIGIT}|\_

%%

{DIGIT}+ return POS_INTEGER;
\(\-{DIGIT}+\) return NEG_INTEGER;
{DIGIT}*[/.]?{DIGIT}+ return POS_FLOAT;
\(\-{DIGIT}*[/.]?{DIGIT}+\)return NEG_FLOAT;
(true|false) return BOOLEAN;
(int|string|float|boolean) return TYPE;
void return VOID;       
sensor{DIGIT}+ return SENSOR_ID;
grab return GRAB;       
move return MOVE;       
turn return TURN;       
send return SEND;       
left return LEFT;       
right return RIGHT;     
receive return RECEIVE; 
release return RELEASE; 
read return READ;       
beginEZ return BEGIN_EZ;
endEZ return END_EZ;    
ezin return EZ_IN;      
ezout return EZ_OUT;    
for return FOR;         
endfor return END_FOR;  
while return WHILE;     
endwhile return END_WHILE;
if return IF;           
elsif return ELSIF;     
 else return ELSE;       
endif return END_IF;    
skip return SKIP;       
break return BREAK;     
functEZ return FUNCTION_EZ;
endfunct return END_FUNCTION;
return return RETURN;   
\= return ASSIGN_OP;    
\\\/ return OR;         
\/\\ return AND;        
\+ return PLUS_OP;      
\- return SUB_OP;       
\* return MULT_OP;      
\/ return DIV_OP;       
\^ return POWER_OP;     
\+\+return INCR_OP;     
\-\- return DECR_OP;    
\% return MOD_OP;       
\<\- return ARGS_ARROW; 
\( return LB;           
\) return RB;           
\>\= return GREATER_EQUAL;
\<\= return LESS_EQUAL; 
\< return LESS;         
\> return GREATER;      
\~\= return NOT_EQUAL;  
\=\= return EQUAL;      
\. return FULL_STOP;    
\; return SEMICOLON;    
\, return COMMA;        
\~ return NOT;          
\#\#[^\n]* ;            
\"(\\.|[^"\\])*\" return STRING;
{LETTER}+{ID_CHARS}* return VAR_NAME;
[ \t\n\r] ;
. return yytext[0];

%%

int yywrap() {
  return 1; 
}
