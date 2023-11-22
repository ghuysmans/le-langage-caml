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

let interpr�te_fichier nom =
  try
    let canal = open_in nom in
    try
      let prog = Parser.prog Lexer.tokenize (Lexing.from_channel canal) in
      close_in canal;
      Typage.type_programme prog;                 (* ligne ajout�e *)
      Interp.ex�cute_programme prog
    with Parsing.Parse_error ->
           prerr_string "Erreur de syntaxe aux alentours \
                         du caract�re num�ro ";
           prerr_int (pos_in canal);
           prerr_endline ""
       | Typage.Erreur_typage err ->              (* ligne ajout�e *)
           Typage.affiche_erreur err; exit 2      (* ligne ajout�e *)
       | Valeur.Erreur_ex�cution message ->
           prerr_string "Erreur pendant l'ex�cution: ";
           prerr_endline message
  with Sys_error message ->
        prerr_string "Erreur du syst�me: "; prerr_endline message;;

if Caml__csl.interactive then () else
  begin interpr�te_fichier Sys.argv.(1); exit 0 end;;
