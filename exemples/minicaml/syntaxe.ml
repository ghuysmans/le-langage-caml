(***********************************************************************)
(*                                                                     *)
(*                        Caml examples                                *)
(*                                                                     *)
(*            Pierre Weis                                              *)
(*                                                                     *)
(*                        INRIA Rocquencourt                           *)
(*                                                                     *)
(*  Copyright (c) 1994-2015, INRIA                                     *)
(*  All rights reserved.                                               *)
(*                                                                     *)
(*  Distributed under the BSD license.                                 *)
(*                                                                     *)
(***********************************************************************)
open Lexuniv;;

type expression =
    Variable of string
  | Fonction of (motif * expression) list
  | Application of expression * expression
  | Let of d�finition * expression
  | Bool�en of bool
  | Nombre of int
  | Paire of expression * expression
  | Nil
  | Cons of expression * expression

and motif =
    Motif_variable of string
  | Motif_bool�en of bool
  | Motif_nombre of int
  | Motif_paire of motif * motif
  | Motif_nil
  | Motif_cons of motif * motif

and d�finition =
  { r�cursive: bool;
    nom: string;
    expr: expression };;
type phrase =
    Expression of expression
  | D�finition of d�finition;;

let est_un_op�rateur op�rateurs = function
  | MC op -> List.mem op op�rateurs
  | _     -> false;;
  
let lire_op�rateur op�rateurs = parser
  | [< (MC op) = (Caml__csl.check (est_un_op�rateur op�rateurs)) >] -> op;;

let lire_op�ration lire_base op�rateurs =
  let rec lire_reste e1 = parser
  | [< op = (lire_op�rateur op�rateurs);
       e2 = lire_base;
       e = (lire_reste (Application(Variable op, Paire(e1, e2)))) >]
          -> e
  | [< >] -> e1 in
  parser [< e1 = lire_base; e = (lire_reste e1) >] -> e;;

let lire_infixe lire_base infixe construire_syntaxe flux =
  let rec lire_d�but = parser
    [< e1 = lire_base; e2 = (lire_reste e1) >] -> e2
  and lire_reste e1 = parser
  | [< _ = (Caml__csl.check (function MC op -> op = infixe | _ -> false));
       e2 = lire_d�but >] -> construire_syntaxe e1 e2
  | [< >] -> e1 in
  lire_d�but flux;;

let rec phrase = parser
  | [< d = d�finition; p = (fin_de_d�finition d); 'MC ";;" >] -> p
  | [< e = expression; 'MC ";;" >] -> Expression e
and fin_de_d�finition d = parser
  | [< 'MC "in"; e = expression >] -> Expression (Let(d, e))
  | [< >] -> D�finition d

and expression = parser
  | [< d = d�finition; 'MC "in"; e = expression >] -> Let(d, e)
  | [< 'MC "function"; liste = liste_de_cas >] ->
      Fonction(liste)
  | [< 'MC "match"; e = expression; 'MC "with";
         liste = liste_de_cas >] ->
      Application(Fonction(liste), e)
  | [< e = expr5 >] -> e
and expr_simple = parser
  | [< 'Entier i >] -> Nombre i
  | [< 'MC "true" >] -> Bool�en true
  | [< 'MC "false" >] -> Bool�en false
  | [< 'Ident id >] -> Variable id
  | [< 'MC "["; 'MC "]" >] -> Nil
  | [< 'MC "("; e = expression; 'MC ")" >] -> e
and expr0 = parser
  | [< es = expr_simple; e = (suite_d'applications es) >] -> e
and suite_d'applications f = parser
  | [< arg = expr_simple;
       e = (suite_d'applications (Application(f, arg))) >] -> e
  | [<>] -> f
and expr1 flux =
  lire_op�ration expr0 ["*"; "/"] flux
and expr2 flux =
  lire_op�ration expr1 ["+"; "-"] flux
and expr3 flux =
  lire_op�ration expr2 ["="; "<>"; "<"; ">"; "<="; ">="] flux
and expr4 flux =
  lire_infixe expr3 "::" (fun e1 e2 -> Cons(e1, e2)) flux
and expr5 flux =
  lire_infixe expr4 "," (fun e1 e2 -> Paire(e1, e2)) flux

and d�finition = parser
  | [< 'MC "let"; r = r�cursive; 'Ident nom; 'MC "="; e = expression >] ->
      {r�cursive = r; nom = nom; expr = e}
and r�cursive = parser
  | [< 'MC "rec" >] -> true
  | [< >] -> false

and liste_de_cas = parser
  | [< m = motif; 'MC "->"; e = expression; reste = autres_cas >] ->
      (m, e) :: reste
and autres_cas = parser
  | [< 'MC "|"; m = motif; 'MC "->"; e = expression;
       reste = autres_cas >] -> (m, e) :: reste
  | [< >] -> []

and motif_simple = parser
  | [< 'Ident id >] -> Motif_variable id
  | [< 'Entier n >] -> Motif_nombre n
  | [< 'MC "true" >] -> Motif_bool�en true
  | [< 'MC "false" >] -> Motif_bool�en false
  | [< 'MC "["; 'MC "]" >] -> Motif_nil
  | [< 'MC "("; e = motif; 'MC ")" >] -> e
and motif1 flux =
  lire_infixe motif_simple "::" (fun m1 m2 -> Motif_cons(m1,m2)) flux
and motif flux =
  lire_infixe motif1 "," (fun m1 m2 -> Motif_paire(m1,m2)) flux;;

let analyseur_lexical = construire_analyseur
   ["function"; "let"; "rec"; "in"; "match"; "with"; "->"; ";;";
    "true"; "false"; "["; "]"; "("; ")"; "::"; "|"; ",";
    "*"; "/"; "-"; "+"; "="; "<>"; "<"; ">"; "<="; ">="; "::"];;

let lire_phrase f = phrase (analyseur_lexical f);;
