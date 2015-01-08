%{
#include <iostream>
#include <string>
#include "write.h"
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "parser.tab.h"

float splitequaloperator( string s )
{
        string delimiter = "=";
	float t;
        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos + delimiter.length());
        }
        t = atof(s.c_str());
        return t;
}
float splitbeamx( string s )
{
        string delimiter = "[";

        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos + delimiter.length());
        }
        float t;
        t = atof(s.c_str());
        return t;
}

float splitbeamy( string s )
{
        string delimiter = ",";

        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos+delimiter.length());
        }
        float t;
        t = atof(s.c_str());
        return t;
}

%}

space           [[:space:]]
endl            [\r]*[\n]*
digits		[0-9]+	
float		{digits}*"."{digits}	
nodes		[\t]*(=){digits}
beamx		(nodes=)\[{digits}
beamy		[,]{digits}
jc_count	(nodes)(=){digits}
mi_count	(elements=){digits}

%%

[ \n\t]

{jc_count}			{ yylval.i = splitequaloperator(yytext); return jc_count;}


{mi_count}			{ yylval.i = splitequaloperator(yytext); return mi_count;}
 				
^(nodes){endl}			{ yylval.s = strdup(yytext); return joint_coordinates; }

^(beam{space}elements){endl}	{ yylval.s = strdup(yytext); return member_incidences; }

x{nodes}                        { yylval.f = splitequaloperator(yytext); return x_nodes; }

y{nodes}                        { yylval.f = splitequaloperator(yytext); return y_nodes; }

z{nodes}			{ yylval.f = splitequaloperator(yytext); return z_nodes; }

{beamx}				{ yylval.f = splitbeamx(yytext); return beam_x; }

{beamy}                         { yylval.f = splitbeamy(yytext); return beam_y; }

end				{ return end; }

.		;

