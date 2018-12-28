all: lex parse
	gcc -o parser y.tab.c

lex: tooez.lex
	lex tooez.lex

parse: tooez.yacc
	yacc tooez.yacc

clean:
	rm -f parser lex.yy.c y.tab.c
