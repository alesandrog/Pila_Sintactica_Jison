
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
        { var pila = eval('$$'); console.log(pila); return $1;}
    ;

a : b c 
{  
    var pila = eval('$$');
    console.log("Pila en a -> b c");
    console.log(pila);
    $$ = $2;
}
;

c : '+' b c 
{ 
var pila = eval('$$');
console.log("Pila en c -> + b c");
console.log(pila);
var tope = pila.length;
$$ = parseInt(pila[tope -4 ] + pila[tope-1]);
}
  | 
{ var pila = eval('$$');
console.log("Pila en epsilon c"); 
console.log(pila);
var tope = pila.length;
$$ = pila[tope-1];
}
;

b : d e  { 

var pila = eval('$$');
console.log("Pila en b -> d e");
console.log(pila);
$$ = $2; 
}

;

e : '*' d e 
{  
console.log("Pila e -> * d e ");
var pila = eval('$$');
var tope = pila.length;
console.log(pila);
$$ = parseInt(pila[tope -4 ] * pila[tope-1]);
}
  | 
{ 
console.log("Pila en epsilon e");
var pila = eval('$$');
var tope = pila.length;
console.log(pila);
$$ = parseInt(pila[tope-1]);
}
;

d : 'NUMBER'
{ 
    var pila = eval('$$'); 
    console.log(pila); 
    $$ = parseInt($1);
};
 