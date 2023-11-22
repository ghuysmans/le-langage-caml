%token <string> MC
%token <string> IDENT
%token <int> ENTIER
%token FALSE TRUE PARG VIRGULE PARD CROG CROD NOT FOIS DIV MOINS PLUS
%token EGAL DIFF PP PG PPE PGE AND OR IF THEN ELSE
%token WHILE DO WRITE READ BEGIN PV END AFF
%token INTEGER BOOLEAN ARRAY OF POINTPOINT VAR DE_TYPE
%token PROCEDURE FUNCTION PROGRAM
%token EOF
%type <Syntaxe.programme> prog
%start prog
%{
let fold op = List.fold_left (fun acc x -> Syntaxe.Op_binaire (op, acc, x))
%}
%%

expr0:
| n=ENTIER { Syntaxe.(Constante (Entière n)) }
| FALSE { Syntaxe.(Constante (Booléenne false)) }
| TRUE { Syntaxe.(Constante (Booléenne true)) }
| nom=IDENT PARG el=separated_list(VIRGULE,expr) PARD { Syntaxe.Application (nom, el) }
| nom=IDENT { Syntaxe.Variable nom }
| PARG e=expr PARD { e }

expr1:
| e1=expr0 CROG e2=expr CROD { Syntaxe.Accès_tableau (e1, e2) }
| e1=expr0 { e1 }

expr2:
| MOINS e=expr1 { Syntaxe.(Op_unaire (Moins, e)) }
| NOT e=expr1 { Syntaxe.(Op_unaire (Not, e)) }
| e=expr1 { e }

expr3:
| e=expr2 FOIS l=separated_list(FOIS,expr2) { fold Syntaxe.Fois e l }
| e=expr2 DIV l=separated_list(DIV,expr2) { fold Syntaxe.Div e l }
| e=expr2 { e }

expr4:
| e=expr3 PLUS l=separated_list(PLUS,expr3) { fold Syntaxe.Plus e l }
| e=expr3 MOINS l=separated_list(MOINS,expr3) { fold Syntaxe.Moins e l }
| e=expr3 { e }

expr5:
| e=expr4 EGAL l=separated_list(EGAL,expr4) { fold Syntaxe.Egal e l }
| e=expr4 DIFF l=separated_list(DIFF,expr4) { fold Syntaxe.Diff e l }
| e=expr4 PP l=separated_list(PP,expr4) { fold Syntaxe.Pp e l }
| e=expr4 PG l=separated_list(PG,expr4) { fold Syntaxe.Pg e l }
| e=expr4 PPE l=separated_list(PPE,expr4) { fold Syntaxe.Ppe e l }
| e=expr4 PGE l=separated_list(PGE,expr4) { fold Syntaxe.Pge e l }
| e=expr4 { e }

expr6:
| e=expr5 AND l=separated_list(AND,expr5) { fold Syntaxe.And e l }
| e=expr5 { e }

expr:
| e=expr6 OR l=separated_list(OR,expr6) { fold Syntaxe.Or e l }
| e=expr6 { e }

instr:
| IF e1=expr THEN i2=instr ELSE i3=instr { Syntaxe.If (e1, i2, i3) }
| IF e1=expr THEN i2=instr { Syntaxe.(If (e1, i2, Bloc [])) }
| WHILE e1=expr DO i2=instr { Syntaxe.While (e1, i2) }
| WRITE PARG e=expr PARD { Syntaxe.Write e }
| READ PARG nom=IDENT PARD { Syntaxe.Read nom }
| BEGIN il=separated_list(PV,instr) END { Syntaxe.Bloc il }
| e=expr {
  match e with
  | Syntaxe.Application (nom, el) -> Syntaxe.Appel (nom, el)
  | _ -> failwith "erreur de syntaxe : expression inattendue"
}
| e=expr AFF e3=expr {
  match e with
  | Syntaxe.Variable nom -> Syntaxe.Affectation_var (nom, e3)
  | Syntaxe.Accès_tableau (e1, e2) -> Syntaxe.Affectation_tableau (e1, e2, e3)
  | _ -> failwith "erreur de syntaxe : affectation invalide"
}

typ:
| INTEGER { Syntaxe.Integer }
| BOOLEAN { Syntaxe.Boolean }
| ARRAY CROG bas=ENTIER POINTPOINT haut=ENTIER CROD OF ty=typ
  { Syntaxe.Array (bas, haut, ty) }

variables:
| VAR nom=IDENT DE_TYPE ty=typ PV reste=variables { (nom, ty) :: reste }
| { [] }

un_paramètre:
| nom=IDENT DE_TYPE ty=typ { nom, ty }

paramètres:
| PARG paramètres=separated_list(VIRGULE,un_paramètre) PARD { paramètres }

procédure:
| PROCEDURE nom=IDENT p=paramètres PV v=variables i=instr PV
  { nom, Syntaxe.{proc_paramètres=p; proc_variables=v; proc_corps=i} }

fonction:
| FUNCTION nom=IDENT p=paramètres DE_TYPE ty=typ PV v=variables i=instr PV
  { nom, Syntaxe.{fonc_paramètres=p; fonc_type_résultat=ty; fonc_variables=v; fonc_corps=i} }

proc_fonc:
| proc=procédure pf=proc_fonc { proc :: fst pf, snd pf }
| fonc=fonction pf=proc_fonc { fst pf, fonc :: snd pf }
| { [], [] }

prog:
| PROGRAM nom_du_programme=IDENT PV v=variables pf=proc_fonc i=instr EOF
  { Syntaxe.{prog_variables=v; prog_procédures=fst pf; prog_fonctions=snd pf; prog_corps=i} }
