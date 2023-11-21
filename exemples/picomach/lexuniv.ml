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
type lexème =
     MC of string
   | Ident of string
   | Entier of int;;

let rec lire_entier accumulateur flux =
  match flux with parser
  | [< c = Caml__csl.within ['0','9'] "" >] ->
      lire_entier (10 * accumulateur + Char.code c - 48) flux
  | [< >] ->
      accumulateur;;

let tampon = "----------------";;

let rec lire_mot position flux =
  match flux with parser
  | [< c = Caml__csl.within ['A','Z'; 'a','z'; '0','9'] "_'éàèùâêîôûëïüçÉÀÈÙÂÊÎÔÛÀÏÜÇ" >] ->
      if position < String.length tampon then
        String.set tampon position c;
      lire_mot (position+1) flux
  | [< >] ->
      String.sub tampon 0 (min position (String.length tampon));;
let rec lire_symbole position flux =
  match flux with parser
  | [< c = Caml__csl.within [] "!$%&*+-./:;<=>?@^|~" >] ->
      if position < String.length tampon then
        String.set tampon position c;
      lire_symbole (position + 1) flux
  | [< >] ->
      String.sub tampon 0 (min position (String.length tampon));;
let rec lire_commentaire flux =
  match flux with parser
  | [< ''\n' >] -> ()
  | [< '_ >] -> lire_commentaire flux;;
let mc_ou_ident table_des_mots_clés ident =
    try Hashtbl.find table_des_mots_clés ident
    with Not_found -> Ident(ident);;
let mc_ou_erreur table_des_mots_clés caractère =
    let ident = String.make 1 caractère in
    try Hashtbl.find table_des_mots_clés ident
    with Not_found -> raise (Stream.Error "");;
let rec lire_lexème table flux =
  match flux with parser
  | [< _ = Caml__csl.within [] " \n\r\t" >] ->
      lire_lexème table flux
  | [< ''#' >] ->
      lire_commentaire flux; lire_lexème table flux
  | [< c = Caml__csl.within ['A','Z'; 'a','z'] "éàèùâêîôûëïüçÉÀÈÙÂÊÎÔÛÀÏÜÇ" >] ->
      String.set tampon 0 c;
      mc_ou_ident table (lire_mot 1 flux)
  | [< c = Caml__csl.within [] "!$%&*+-./:;<=>?@^|~" >] ->
      String.set tampon 0 c;
      mc_ou_ident table (lire_symbole 1 flux)
  | [< c = Caml__csl.within ['0','9'] "" >] ->
      Entier(lire_entier (Char.code c - 48) flux)
  | [< ''-' >] ->
      begin match flux with parser
      | [< c = Caml__csl.within ['0','9'] "" >] ->
          Entier(- (lire_entier  (Char.code c - 48) flux))
      | [< >] ->
          String.set tampon 0 '-';
          mc_ou_ident table (lire_symbole 1 flux)
      end
  | [< 'c >] ->
      mc_ou_erreur table c;;
let analyseur table flux =
    Caml__csl.from (function () -> 
      match flux with parser
      | [< lexème = (lire_lexème table) >] -> lexème
      | [< >] -> raise Stream.Failure);;
let construire_analyseur mots_clés =
    let table_des_mots_clés = Hashtbl.create 17 in
    List.iter
      (function mot -> Hashtbl.add table_des_mots_clés mot (MC mot))
      mots_clés;
    analyseur table_des_mots_clés;;
