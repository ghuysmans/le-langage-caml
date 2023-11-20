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
compile "crayon.mli";;
compile "crayon.ml";;
load_object "crayon.zo";;
compile "langage.mli";;
compile "langage.ml";;
load_object "langage.zo";;
compile "alex.mli";;
compile "alex.ml";;
load_object "alex.zo";;
compile "asynt.mli";;
compile "asynt.ml";;
load_object "asynt.zo";;
compile "logo.ml";;
load_object "logo.zo";;
#open "logo";;
print_string "Pour lancer l'interpréteur: boucle();;";
print_newline();;
