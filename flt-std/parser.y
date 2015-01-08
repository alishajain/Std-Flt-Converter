%{
#include <cstdio>
#include <iostream>
#include <fstream>
#include <ctime>
#include "write.h"
using namespace std;

extern "C" int yylex ();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s);
#define YYDEBUG 1

write w;
int n_i = 0, b_i = 0;
%}

%union{
	
	int i;
	float f;
	char* s;
}
%token <i>  jc_count mi_count;
%token <f>  nodes beam_x beam_y x_nodes y_nodes z_nodes;
%token <s>  joint_coordinates member_incidences end; 

%%

FELT:/*empty*/
	FELT jc_count			{ w.counter('n', $2); }
	| FELT mi_count			{ w.counter('b', $2); }
	| FELT joint_coordinates	{ }
	| FELT x_nodes			{ w.store_values('n', $2, n_i); n_i++; }
	| FELT y_nodes			{ w.store_values('n', $2, n_i); n_i++; }
	| FELT z_nodes			{ w.store_values('n', $2, n_i); n_i++; }
	| FELT member_incidences	{ }
	| FELT beam_x			{ w.store_values('b', $2, b_i); b_i++; }
	| FELT beam_y			{ w.store_values('b', $2, b_i); b_i++; }
	| FELT end			{ w.write_content(); }
	| jc_count			{ w.counter('n', $1);  }
	| mi_count			{ w.counter('b', $1); }
	| joint_coordinates		{ }
        | x_nodes			{ w.store_values('n', $1, n_i); n_i++; }
        | y_nodes			{ w.store_values('n', $1, n_i); n_i++; }
        | z_nodes			{ w.store_values('n', $1, n_i); n_i++; }
	| member_incidences		{ }
	| beam_x			{ w.store_values('b', $1, n_i); n_i++; }
	| beam_y			{ w.store_values('b', $1, n_i); n_i++; }
	| end				{ }
	;	
%%

int main(int argc, char **argv)
{
        string out_file;
        if(argc > 1)
        {
                if(!(yyin = fopen(argv[1], "r")))       // open the first argument file and put it in yyin FILE variable 
                {
                        perror(argv[1]);
                        return (1);
                }

                out_file = argv [2];    // create the output file
        }

        w.write_header(out_file);

        while(!feof(yyin)) //until input file doesn't end 
        {
//              yydebug = 1;    Bison debugger
                yyparse(); //keep on calling above grammar rules 
        }

	cout << "*************************************************************************" << endl;
	cout << "*	" << out_file << " has been generated in the same directory		*" << endl;
	cout << "*************************************************************************\n" << endl;

	return 0;
}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}


