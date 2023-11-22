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
open Compiler;;

let interprète_fichier nom =
  try
    let canal = open_in nom in
    try
      let prog = Parser.prog Lexer.tokenize (Lexing.from_channel canal) in
      close_in canal;
      Typage.type_programme prog;                 (* ligne ajoutée *)
      Interp.exécute_programme prog
    with Parsing.Parse_error ->
           prerr_string "Erreur de syntaxe aux alentours \
                         du caractère numéro ";
           prerr_int (pos_in canal);
           prerr_endline ""
       | Typage.Erreur_typage err ->              (* ligne ajoutée *)
           Typage.affiche_erreur err; exit 2      (* ligne ajoutée *)
       | Valeur.Erreur_exécution message ->
           prerr_string "Erreur pendant l'exécution: ";
           prerr_endline message
  with Sys_error message ->
        prerr_string "Erreur du système: "; prerr_endline message;;

if Caml__csl.interactive then () else
  begin interprète_fichier Sys.argv.(1); exit 0 end;;
