Definitions.

NUMBER     = [0-9]+
WHITESPACE = [\s\t\n\r]

Rules.

{NUMBER}      : {token, {number, {TokenLine,TokenCol,TokenLen}, list_to_integer(TokenChars)}}.
\*            : {token, {'*',    {TokenLine,TokenCol,TokenLen}}}.
\/            : {token, {'/',    {TokenLine,TokenCol,TokenLen}}}.
\+            : {token, {'+',    {TokenLine,TokenCol,TokenLen}}}.
\-            : {token, {'-',    {TokenLine,TokenCol,TokenLen}}}.
\(            : {token, {'(',    {TokenLine,TokenCol,TokenLen}}}.
\)            : {token, {')',    {TokenLine,TokenCol,TokenLen}}}.
{WHITESPACE}+ : skip_token.

Erlang code.

%%to_atom([$:|Chars]) ->
%%  list_to_atom(Chars).
