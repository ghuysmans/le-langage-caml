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
#open "syntaxe";;
#open "types";;

type environnement == (string * sch�ma_de_types) list;;

value type_exp: environnement -> expression -> type_simple
  and type_d�f: environnement -> d�finition -> environnement;;

exception Erreur of string;;
