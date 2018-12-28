/* CS315f18_group33.yacc */

//tokens
%token POS_INTEGER NEG_INTEGER POS_FLOAT NEG_FLOAT BOOLEAN TYPE VOID SENSOR_ID
%token GRAB MOVE TURN SEND LEFT RIGHT RECEIVE RELEASE READ BEGIN_EZ END_EZ
%token EZ_IN EZ_OUT FOR END_FOR WHILE END_WHILE IF ELSIF ELSE END_IF SKIP BREAK
%token FUNCTION_EZ END_FUNCTION RETURN ASSIGN_OP OR AND PLUS_OP SUB_OP MULT_OP
%token DIV_OP POWER_OP INCR_OP DECR_OP MOD_OP ARGS_ARROW LB RB GREATER_EQUAL
%token LESS_EQUAL LESS GREATER NOT_EQUAL EQUAL FULL_STOP SEMICOLON COMMA NOT
%token STRING VAR_NAME

 //associativity
%left PLUS_OP SUB_OP MULT_OP DIV_OP
%right POWER_OP

%{
  #include <stdio.h>
  #include <stdlib.h>
  #define YYDEBUG 1
  int yylex(void);
  void yyerror(char* s);
  extern int yylineno;
  int errorCount;
  %}

%%

program: function_defs BEGIN_EZ stmts END_EZ
;

function_defs:
             | function_def function_defs
	     ;

function_def: FUNCTION_EZ return_type VAR_NAME stmts END_FUNCTION
            | FUNCTION_EZ return_type VAR_NAME ARGS_ARROW LB args_list RB stmts END_FUNCTION
;

return_type: TYPE
           | VOID
;

args_list: TYPE VAR_NAME
         | TYPE VAR_NAME COMMA args_list
;

stmts: stmt stmts
     | stmt
;

stmt: declare_stmt FULL_STOP
    | assign_stmt FULL_STOP
    | function_call FULL_STOP
    | if_stmt
    | loop_stmt
    | jump_stmt FULL_STOP
    | return_stmt FULL_STOP
    | input_stmt FULL_STOP
    | output_stmt FULL_STOP
;

declare_stmt: TYPE VAR_NAME
;

assign_stmt: VAR_NAME ASSIGN_OP rhs_assign_stmt
           | TYPE VAR_NAME ASSIGN_OP rhs_assign_stmt
           | increment_stmt
           | decrement_stmt
;

rhs_assign_stmt: arithmetic_expr
               | BOOLEAN
               | STRING
               | function_call
;

arithmetic_expr: arithmetic_expr PLUS_OP term
               | arithmetic_expr SUB_OP term
               | term
;

term: term MULT_OP factor
    | term DIV_OP factor
    | factor
;

factor: component POWER_OP factor
      | component
;

component: LB arithmetic_expr RB
         | number
;

number: SENSOR_ID
      | VAR_NAME
      | constant_nr
;

constant_nr: POS_INTEGER
           | NEG_INTEGER
           | POS_FLOAT
           | NEG_FLOAT
;

constant: BOOLEAN
        | STRING
        | constant_nr
;

increment_stmt: VAR_NAME INCR_OP
;

decrement_stmt: VAR_NAME DECR_OP
;

function_call: VAR_NAME ARGS_ARROW LB args_values_list RB
             | prim_funct
;

args_values_list: args_value
                | args_value COMMA args_values_list
;

args_value: VAR_NAME
          | constant
;

prim_funct: MOVE
          | TURN ARGS_ARROW LB direction RB
          | GRAB
          | RELEASE
          | READ ARGS_ARROW LB SENSOR_ID RB
          | SEND ARGS_ARROW LB STRING RB
          | SEND ARGS_ARROW LB VAR_NAME RB
          | RECEIVE
;

direction: LEFT
         | RIGHT
;

if_stmt: IF LB logic_expr RB stmts elsifs END_IF
       | IF LB logic_expr RB stmts elsifs ELSE stmts END_IF
;

elsifs:
      | ELSIF LB logic_expr RB stmts elsifs
      ;

logic_expr: BOOLEAN
          | VAR_NAME
          | comp_expr
          | LB logic_expr AND logic_expr RB
          | LB logic_expr OR logic_expr RB
          | NOT LB logic_expr RB
;

comp_expr: number comp_op number
;

comp_op: LESS
       | GREATER
       | GREATER_EQUAL
       | LESS_EQUAL
       | EQUAL
       | NOT_EQUAL
;

loop_stmt: while_stmt
         | for_stmt
;

while_stmt: WHILE LB logic_expr RB stmts END_WHILE
;

for_stmt: FOR LB assign_stmt SEMICOLON logic_expr SEMICOLON assign_stmt RB stmts END_FOR
;

jump_stmt: SKIP
         | BREAK
;

return_stmt: RETURN
           | RETURN VAR_NAME
           | RETURN constant
;

input_stmt: EZ_IN ARGS_ARROW LB VAR_NAME RB
;

output_stmt: EZ_OUT ARGS_ARROW LB VAR_NAME RB
           | EZ_OUT ARGS_ARROW LB constant RB
;

%%

#include "lex.yy.c"
main() {
  errorCount=0;
  yyparse();
  if(errorCount == 0)
    printf("Program accepted, no syntax errors! It was too easy to write a program in TooEZ, right? \n");
  else
    printf("\nYou are close to writing a correct program in TooEZ. Please check again the indicated line.");
}
void yyerror(char *s) {
  errorCount++;
  fprintf(stdout, "%d-%s\n", yylineno,s);
}
