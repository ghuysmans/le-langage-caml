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

type 'a env =
  { vars: (string * 'a) list;
    procs: (string * d�cl_proc) list;
    foncs: (string * d�cl_fonc) list };;

let environnement_initial p f =
  { vars=[]; procs=p; foncs=f };;

let ajoute_variable nom info env =
  { vars=(nom,info)::env.vars; procs=env.procs; foncs=env.foncs };;

exception Pas_trouv� of string;;

let cherche nom liste =
  try List.assoc nom liste with Not_found -> raise(Pas_trouv� nom);;

let cherche_variable nom env = cherche nom env.vars
and cherche_fonction nom env = cherche nom env.foncs
and cherche_proc�dure nom env = cherche nom env.procs;;
