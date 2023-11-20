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

(* $Id: loadall.ml,v 1.3 2015/03/27 19:26:08 weis Exp $ *)

compile "code.mli";;
compile "code.ml";;
load_object "code.zo";;
compile "simul.mli";;
compile "simul.ml";;
load_object "simul.zo";;
compile "exec.ml";;
load_object "exec.zo";;
compile "stockage.mli";;
compile "stockage.ml";;
load_object "stockage.zo";;
compile "lexuniv.mli";;
compile "lexuniv.ml";;
load_object "lexuniv.zo";;
compile "lecture.mli";;
compile "lecture.ml";;
load_object "lecture.zo";;
compile "asm.ml";;
load_object "asm.zo";;
#open "exec";;
#open "asm";;
print_string
"Pour assembler un fichier:
     assemble_fichier \"fichier source\" \"fichier r�sultat\"
Pour executer le fichier produit:
     ex�cute_fichier \"fichier r�sultat\" 4096";
print_newline();;
