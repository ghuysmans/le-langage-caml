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
open Graphics;;
open Langage;;
open Alex;;
open Asynt;;

let boucle() =
  let flux_d'entr�e = Caml__csl.stream_of_channel stdin in
  let flux_lex�mes = analyseur_lexical flux_d'entr�e in
  try
    Crayon.vide_�cran();
    while true do
      print_string "? "; flush stdout;
      try
        ex�cute_programme(analyse_programme flux_lex�mes)
      with
      | Stream.Error "" ->
          print_string "Erreur de syntaxe"; print_newline ()
      | Failure s ->
          print_string "Erreur � l'ex�cution: "; print_string s;
          print_newline()
    done
  with Stream.Failure -> ()
;;

if (not (Caml__csl.interactive)) then begin boucle(); close_graph(); exit 0 end;;
