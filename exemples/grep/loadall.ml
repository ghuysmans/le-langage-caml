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
compile "expr.mli";;
compile "expr.ml";;
load_object "expr.zo";;
compile "auto.mli";;
compile "auto.ml";;
load_object "auto.zo";;
compile "ensent.mli";;
compile "ensent.ml";;
load_object "ensent.zo";;
compile "determ.mli";;
compile "determ.ml";;
load_object "determ.zo";;
compile "grep.ml";;
load_object "grep.zo";;
#open "grep";;
print_string "Pour lancer: grep \"expression rationnelle\" \"nom de fichier\"";
print_newline();;
