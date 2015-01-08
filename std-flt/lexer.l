%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"

%}

space		[[:space:]]
digit		[0-9]+
integer		{digit}
float		{integer}"."{digit}*
endl		[\r]*[\n]*
jc		(JOINT{space}COORDINATES{endl})
mi		(MEMBER{space}INCIDENCES{endl})
semicolon	[;]
finish		(FINISH)

month           Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec
date            ({digit}-{month}-{digit})
width           (WIDTH{space}{digit})

%%
[ \t\n]			;

{jc}			{ yylval.c = strdup (yytext); return JC; }

{mi}			{ yylval.c = strdup (yytext); return MI; }

{integer}|{float}	{ yylval.f = atof (yytext); return DIGIT; }

{width}

{date}			{ yylval.c = strdup (yytext); return DESCRIPTION; }

{semicolon}		{ return SEMICOLON; }

{finish}		{ return FINISH; }

.			;

