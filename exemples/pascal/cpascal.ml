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
open Syntaxe;;

let compile_fichier nom =
  try
    let canal = open_in nom in
    try
      let prog = lire_programme (Caml__csl.stream_of_channel canal) in
      close_in canal;
      Typage.type_programme prog;
      Compil.compile_programme prog
    with (Stream.Error "") | Stream.Failure ->
           prerr_string "Erreur de syntaxe aux alentours \
                         du caractère numéro ";
           prerr_int (pos_in canal);
           prerr_endline ""
       | Typage.Erreur_typage err ->
           Typage.affiche_erreur err
  with Sys_error message ->
        prerr_string "Erreur du système: "; prerr_endline message;;

if Caml__csl.interactive then () else
  begin compile_fichier Sys.argv.(1); exit 0 end;;
