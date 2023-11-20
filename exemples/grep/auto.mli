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
#open "expr";;

type état =
  { mutable transitions : (char * état) list;
    mutable epsilon_transitions : état list;
    mutable terminal : bool;
    numéro : int };;

value expr_vers_automate : expr -> état;;
