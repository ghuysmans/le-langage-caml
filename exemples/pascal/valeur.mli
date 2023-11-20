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
type valeur =
    Inconnue
  | Ent of int
  | Bool of bool
  | Tableau of int * valeur vect;;

value ent_val: valeur -> int
  and bool_val: valeur -> bool
  and tableau_val: valeur -> int * valeur vect
  and affiche_valeur: valeur -> unit
  and lire_valeur: unit -> valeur;;
