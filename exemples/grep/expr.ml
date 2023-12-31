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
type expr =
    Epsilon
  | Caract�res of char list
  | Alternative of expr * expr
  | S�quence of expr * expr
  | R�p�tition of expr;;

let intervalle c1 c2 =
  let rec interv n1 n2 =
    if n1 > n2 then [] else Char.chr n1 :: interv (n1 + 1) n2 in
  interv (Char.code c1) (Char.code c2);;

let tous_car = intervalle '\000' '\255';;
let rec lire_expr = parser
  | [< r1 = lire_s�q; r2 = (lire_alternative r1) >] -> r2

and lire_alternative r1 = parser
  | [< ''|'; r2 = lire_expr >] -> Alternative(r1,r2)
  | [< >] -> r1

and lire_s�q = parser
  | [< r1 = lire_r�p�t; r2 = (lire_fin_s�q r1) >] -> r2

and lire_fin_s�q r1 = parser
  | [< r2 = lire_s�q >] -> S�quence(r1,r2)
  | [< >] -> r1

and lire_r�p�t = parser
  | [< r1 = lire_simple; r2 = (lire_fin_r�p�t r1) >] -> r2

and lire_fin_r�p�t r1 = parser
  | [< ''*' >] -> R�p�tition r1
  | [< ''+' >] -> S�quence(r1, R�p�tition r1)
  | [< ''?' >] -> Alternative(r1, Epsilon)
  | [< >] -> r1

and lire_simple = parser
  | [< ''.' >] -> Caract�res tous_car
  | [< ''['; cl = lire_classe >] -> Caract�res cl
  | [< ''('; r = lire_expr; '')' >] -> r
  | [< ''\\'; 'c >] -> Caract�res [c]
  | [< c = (Caml__csl.check (function c -> c <> '|' & c <> ')' & c <> '$')) >] ->
      Caract�res [c]

and lire_classe = parser
  | [< ''^'; cl = lire_ensemble >] -> Caml__csl.subtract tous_car cl
  | [< cl = lire_ensemble >] -> cl

and lire_ensemble = parser
  | [< '']' >] -> []
  | [< c1 = lire_car; c2 = (lire_intervalle c1) >] -> c2

and lire_intervalle c1 = parser
  | [< ''-'; c2 = lire_car; reste = lire_ensemble >] ->
        Caml__csl.union (intervalle c1 c2) reste
  | [< reste = lire_ensemble >] -> Caml__csl.union [c1] reste

and lire_car = parser
  | [< ''\\'; 'c >] -> c
  | [< 'c >] -> c;;
let lire = parser
  [< chapeau = (parser | [< ''^' >] -> true | [< >] -> false);
     r = lire_expr;
     dollar = (parser | [< ''$' >] -> true | [< >] -> false) >] ->
  let r1 = if dollar then r else
             S�quence(r, R�p�tition(Caract�res tous_car)) in
  if chapeau then r1 else
    S�quence(R�p�tition(Caract�res tous_car), r1);;
