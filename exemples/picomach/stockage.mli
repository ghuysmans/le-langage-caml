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
#open "code";;

exception Erreur of string;;

value initialise: unit -> unit
  and assemble: instruction -> unit
  and poser_étiquette: string -> unit
  and valeur_étiquette: string -> int
  and extraire_code: unit -> instruction vect;;
