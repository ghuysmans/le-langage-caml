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
type proposition =
     Vrai
   | Faux
   | Non of proposition
   | Et of proposition * proposition
   | Ou of proposition * proposition
   | Implique of proposition * proposition
   | �quivalent of proposition * proposition
   | Variable of string;;

exception R�futation of (string * bool) list;;

let rec �value_dans liaisons = function
  | Vrai -> true
  | Faux -> false
  | Non p -> (not ((�value_dans liaisons p)))
  | Et (p, q) -> (�value_dans liaisons p) &  (�value_dans liaisons q)
  | Ou (p, q) -> (�value_dans liaisons p) or (�value_dans liaisons q)
  | Implique (p, q) ->
      ((not ((�value_dans liaisons p)))) or (�value_dans liaisons q)
  | �quivalent (p, q) ->
      �value_dans liaisons p = �value_dans liaisons q
  | Variable v -> List.assoc v liaisons;;
let rec v�rifie_lignes proposition liaisons variables =
  match variables with
  | [] ->
     if (not (�value_dans liaisons proposition))
     then raise (R�futation liaisons)
  | var :: autres ->
     v�rifie_lignes proposition ((var, true) :: liaisons) autres;
     v�rifie_lignes proposition ((var, false):: liaisons) autres;;

let v�rifie_tautologie proposition variables =
  v�rifie_lignes proposition [] variables;;
let rec variables accu proposition =
  match proposition with
  | Variable v -> if List.mem v accu then accu else v::accu
  | Non p -> variables accu p
  | Et (p, q) -> variables (variables accu p) q
  | Ou (p, q) -> variables (variables accu p) q
  | Implique (p, q) -> variables (variables accu p) q
  | �quivalent (p, q) -> variables (variables accu p) q
  | _ -> accu;;

let variables_libres proposition = variables [] proposition;;
