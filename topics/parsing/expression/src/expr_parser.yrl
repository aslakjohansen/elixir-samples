Nonterminals expr.
Terminals '+' '-' '*' '/' '(' ')' number.
Rootsymbol expr.

%% operator precedence and associativity
Left 200 '*'.
Left 200 '/'.
Left 100 '+'.
Left 100 '-'.

expr -> number : '$1'.
expr -> '(' expr ')' : '$2'.
expr -> expr '*' expr : {op_mul, aggregate_location('$1', '$3'), '$1', '$3'}.
expr -> expr '/' expr : {op_div, aggregate_location('$1', '$3'), '$1', '$3'}.
expr -> expr '+' expr : {op_add, aggregate_location('$1', '$3'), '$1', '$3'}.
expr -> expr '-' expr : {op_sub, aggregate_location('$1', '$3'), '$1', '$3'}.

Erlang code.

%%extract_token({_Token, _Line, Value}) -> Value.

aggregate_location(_a, _b) -> 42.