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
type lexème =
     Mot of string
   | Symbole of char
   | Constante_entière of int
   | Constante_flottante of float;;

let rec saute_blancs flux =
  match flux with parser
  | [< '' ' >] -> saute_blancs flux  (* ' ' est l'espace *)
  | [< ''\t' >] -> saute_blancs flux (* '\t' est la tabulation *)
  | [< ''\n' >] -> saute_blancs flux (* '\n' est la fin de ligne *)
  | [< >] -> ();;

let rec saute_blancs flux =
  match flux with parser
  | [< _ = Caml__csl.within [] " \t\n" >] -> saute_blancs flux
  | [< >] -> ();;

let rec lire_entier accumulateur flux =
  match flux with parser
  | [< c = Caml__csl.within ['0','9'] "" >] ->
      lire_entier (10 * accumulateur + Char.code c - 48) flux
  | [< >] -> accumulateur;;

let rec lire_décimales accumulateur échelle flux =
  match flux with parser
  | [< c = Caml__csl.within ['0','9'] "" >] ->
      lire_décimales
        (accumulateur +.
           float(Char.code c - 48) *. échelle)
        (échelle /. 10.0) flux
  | [< >] -> accumulateur;;

let tampon = "----------------";;

let rec lire_mot position flux =
  match flux with parser
  | [< c = Caml__csl.within ['A','Z'; 'a','z'] "éè_" >] ->
      if position < String.length tampon then
        String.set tampon position c;
      lire_mot (position+1) flux
  | [< >] ->
      String.sub tampon 0 (min position (String.length tampon));;

let rec lire_lexème flux =
  saute_blancs flux;
  match flux with parser
  | [< c = Caml__csl.within ['A','Z'; 'a','z'] "éè" >] ->
      String.set tampon 0 c;
      Mot(lire_mot 1 flux)
  | [< c = Caml__csl.within ['0','9'] "" >] ->
      let n = lire_entier (Char.code c - 48) flux in
      begin match flux with parser
      | [< ''.' >] ->
          Constante_flottante
            (lire_décimales (float n) 0.1 flux)
      | [< >] -> Constante_entière(n)
      end
  | [< 'c >] -> Symbole c;;

let analyseur_lexical flux =
  Caml__csl.from (fun () -> lire_lexème flux);;
