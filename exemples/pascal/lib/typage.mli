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

type erreur_de_type =
    Ind�fini of string      (* variable utilis�e mais non d�finie *)
  | Conflit of string * expr_type * expr_type (* conflit de types *)
  | Arit� of string * int * int     (* mauvais nombre d'arguments *)
  | Tableau_attendu             (* [..] appliqu� � un non-tableau *)
  | Tableau_interdit of string;;   (* tableau renvoy� en r�sultat *)

exception Erreur_typage of erreur_de_type;;

val type_programme: programme -> unit
  val affiche_erreur: erreur_de_type -> unit
  val type_op_unaire: op_unaire -> expr_type * expr_type
  val type_op_binaire: op_binaire -> expr_type * expr_type * expr_type;;
