/* tooez.l */
%option main
LETTER [a-zA-Z]
DIGIT [0-9] 
ID_CHARS {LETTER}|{DIGIT}|\_   
%%
{DIGIT}+ printf("POS_INTEGER ");
\(\-{DIGIT}+\) printf("NEG_INTEGER ");
{DIGIT}*[/.]?{DIGIT}+ printf("POS_FLOAT ");
\(\-{DIGIT}*[/.]?{DIGIT}+\) printf("NEG_FLOAT ");
(true|false) printf("BOOLEAN ");
(int|string|float|boolean) printf("TYPE ");
void printf("VOID ");
sensor{DIGIT}+ printf("SENSOR_ID ");
grab printf("GRAB ");
move printf("MOVE ");
turn printf("TURN ");
send printf("SEND ");
left printf("LEFT ");
right printf("RIGHT ");
receive printf("RECEIVE ");
release printf("RELEASE ");
read printf("READ ");
beginEZ printf("BEGIN_EZ ");
endEZ printf("END_EZ ");
for printf("FOR ");
endfor printf("END_FOR ");
while  printf("WHILE ");
endwhile printf("END_WHILE ");
if printf("IF ");
elsif printf("ELSIF ");
else printf("ELSE ");
endif printf("END_IF ");
skip printf("SKIP ");
break printf("BREAK ");
functEZ printf("FUNCTION_EZ ");
endfunct printf("END_FUNCTION ");
return printf("RETURN ");
\=  printf("ASSIGN_OP ");
\\\/ printf("OR ");
\/\\ printf("AND ");
\+ printf("PLUS_OP ");
\- printf("SUB_OP ");
\* printf("MULT_OP ");
\/ printf("DIV_OP ");
\^ printf("POWER_OP ");
\+\+ printf("INCR_OP ");
\-\- printf("DECR_OP ");
\% printf("MOD_OP ");
\<\- printf("ARGS_ARROW ");
\(  printf("LB ");
\)  printf("RB ");
\>\= printf("GREATER_EQUAL ");
\<\= printf("LESS_EQUAL ");
\< printf("LESS ");
\> printf("GREATER ");
\~\= printf("NOT_EQUAL ");
\=\= printf("EQUAL ");
\. printf("FULL_STOP ");
\; printf("SEMICOLON ");
\, printf("COMMA ");
\~ printf("NOT ");
\#\#[^\n]* printf("COMMENT ");
\"(\\.|[^"\\])*\" printf("STRING ");
{LETTER}+{ID_CHARS}* printf("VAR_NAME ");
. ;
