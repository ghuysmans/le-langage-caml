rule tokenize = parse
| '-'? ['0'-'9']+ as n { Parser.ENTIER (int_of_string n) }
| "false" { Parser.FALSE }
| "true" { Parser.TRUE }
| "not" { Parser.NOT }
| "and" { Parser.AND }
| "or" { Parser.OR }
| "if" { Parser.IF }
| "then" { Parser.THEN }
| "else" { Parser.ELSE }
| "while" { Parser.WHILE }
| "do" { Parser.DO }
| "write" { Parser.WRITE }
| "read" { Parser.READ }
| "begin" { Parser.BEGIN }
| "end" { Parser.END }
| "integer" { Parser.INTEGER }
| "boolean" { Parser.BOOLEAN }
| "array" { Parser.ARRAY }
| "of" { Parser.OF }
| "var" { Parser.VAR }
| "procedure" { Parser.PROCEDURE }
| "function" { Parser.FUNCTION }
| "program" { Parser.PROGRAM }
| ['A'-'Z' 'a'-'z' '0'-'9' '_' '\''
   'é' 'à' 'è' 'ù' 'â' 'ê' 'î' 'ô' 'û' 'ë' 'ï' 'ü' 'ç'
   'É' 'À' 'È' 'Ù' 'Â' 'Ê' 'Î' 'Ô' 'Û' 'À' 'Ï' 'Ü' 'Ç']+ as s
  { Parser.IDENT s }
| '(' { Parser.PARG }
| ',' { Parser.VIRGULE }
| ')' { Parser.PARD }
| '[' { Parser.CROG }
| ']' { Parser.CROD }
| '*' { Parser.FOIS }
| '/' { Parser.DIV }
| '-' { Parser.MOINS }
| '+' { Parser.PLUS }
| '=' { Parser.EGAL }
| "<>" { Parser.DIFF }
| "<=" { Parser.PPE }
| ">=" { Parser.PGE }
| '<' { Parser.PP }
| '>' { Parser.PG }
| ';' { Parser.PV }
| ":=" { Parser.AFF }
| ".." { Parser.POINTPOINT }
| ':' { Parser.DE_TYPE }
| '#' { comment lexbuf; tokenize lexbuf }
| [' ' '\t'] { tokenize lexbuf }
| '\n' { Lexing.new_line lexbuf; tokenize lexbuf }
| eof { Parser.EOF }

and comment = parse
| '\n' { Lexing.new_line lexbuf }
| _ { comment lexbuf }
