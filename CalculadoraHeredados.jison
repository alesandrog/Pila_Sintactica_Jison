
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"("                   return '('
")"                   return ')'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

%start expressions

%% /* language grammar */

expressions
    : a EOF
{  
    return $1;
};

a : b c 
{  
    $$ = $2;
};

c : '+' b c 
{ 
    var pila = eval('$$');
    var tope = pila.length;
    $$ = parseInt(pila[tope -4 ] + pila[tope-1]);
}
   | '-' b c 
{ 
    var pila = eval('$$');
    var tope = pila.length;
    $$ = parseInt(pila[tope -4 ] - pila[tope-1]);
}
  | /* epsilon */
{ 
    var pila = eval('$$');
    var tope = pila.length;
    $$ = pila[tope-1];
}
;

b : d e  
{ 
    $$ = $2; 
};

e : '*' d e 
{  
    var pila = eval('$$');
    var tope = pila.length;
    $$ = parseInt(pila[tope -4 ] * pila[tope-1]);
}
   | '/' d e 
{  
    var pila = eval('$$');
    var tope = pila.length;
    $$ = parseInt(pila[tope -4 ] / pila[tope-1]);
}
  | /* epsilon */
{  
    var pila = eval('$$');
    var tope = pila.length;
    $$ = parseInt(pila[tope-1]);
};

d : 'NUMBER'
{ 
    $$ = parseInt($1);
}
   | '(' a ')'
{
    $$ = $2; 
};
 