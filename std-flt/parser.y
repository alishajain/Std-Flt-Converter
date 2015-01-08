%{
#include "write_felt.h"
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

extern "C" int yylex();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s1);
#define YYDEBUG 1

write w;
int n_i = 0, b_i = 0;
char mode = 'n';
%}

/**
 %union is used to declare the types for various tokens used. 
 It is particularly used when we need to used more than one type
 */
%union{
	float f;
	char *c;
}

/**
 Token declaration with appropriate type
 */
%token <c> JC MI DESCRIPTION
%token <f> DIGIT
%token ENDL FINISH SEMICOLON 

%%

/**
 Grammar rules
 */

converter:
	title jc mi end
	;
title:
	DESCRIPTION { w.write_title(); }
	;
jc:
	JC coord { mode = 'b'; }
	;
mi:
	MI coord { }
	;
coord:
	digit SEMICOLON
	| digit SEMICOLON coord
	;
digit:
	digit DIGIT {
			if (mode == 'n') {
			    w.store_values('n', $2, n_i);
			    n_i++;
			} else {
			    w.store_values('b', $2, b_i);
                            b_i++;
			}
		    }
	| DIGIT { } 
	;
end:
	FINISH { w.write_data(); w.write_end_file(); }
	;
	
%%

int main(int argc, char **argv)	// Definition of main function
{
	string out_file;
	if(argc > 1)
	{
		if(!(yyin = fopen(argv[1], "r")))	// open the first argument file and put it in yyin FILE variable 
		{
			perror(argv[1]);
			return (1);
		}

		out_file = argv [2];	// create the output file
	}

	w.write_description(out_file);

        while(!feof(yyin)) //until input file doesn't end 
        {
//              yydebug = 1;	Bison debugger
                yyparse(); //keep on calling above grammar rules 
        }

	cout << "*************************************************************************" << endl;
	cout << "*	" << out_file << " has been generated in the same directory		*" << endl;
	cout << "*************************************************************************\n" << endl;

}
void yyerror(const char *s1)	// Definition of function handling error
{
	cout << "Parser error! Message: " << s1 << endl;
	exit(-1);
}
