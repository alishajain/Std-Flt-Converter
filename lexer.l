%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"
int line_num = 1;

%}

space		[[:space:]]
digits		[0-9]+
integer		{digits}
float		{integer}"."{digits}*
endl		[\r]*[\n]*
jc		(JOINT{space}COORDINATES{endl})
mi		(MEMBER{space}INCIDENCES{endl})
semicolon	[;]
finish		(FINISH)

month           [A-Za-z]+
date            ({digits}-{month}-{digits})
width           (WIDTH{space}{digits})

%%

{jc}		{ yylval.c = strdup (yytext); return JC; }

{mi}		{ yylval.c = strdup (yytext); return MI; }

{integer}	{  yylval.f = atof (yytext); return DIGIT; }

{width}
{date}

{semicolon}	{ return SEMICOLON; }

{finish}	{ return FINISH;/* }

({digits}+;{s}*)+	{ *//*// For joint-coordinates
			    char* str = strdup( yytext );
			    int i = 0;
			    char *value;
        		    value = strtok (str,";\r\n");
        		    while (value != NULL) {
				yylval.c = strdup (value);
				return jc;
                                cout << yylval.c << endl;
            			value = strtok (NULL, " ;");
            			i++;
        		    } 
			    //return jc;*/
		/*	}
 
{mi}({digits}+;{s}*)+	{ *//*// For member-incidences
                            char* str_mi = strdup( yytext );
                            int i = 0;
                            char *value;
                            value = strtok (str_mi,";\r\n");
                            while (value != NULL) {
				yylval.c = strdup (value);
				return mi;
				cout << yylval.c << endl;
				value = strtok (NULL, " ;");
				i++;
                            }
			   // return mi;*/
                        }


.			;

