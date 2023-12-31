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
open Types;;

type environnement = (string * sch�ma_de_types) list;;

val type_exp: environnement -> expression -> type_simple
  val type_d�f: environnement -> d�finition -> environnement;;

exception Erreur of string;;
