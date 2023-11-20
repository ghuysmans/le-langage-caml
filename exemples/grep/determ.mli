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
type �tat =
  { mutable dtransitions : transition vect;
    dterminal : bool }
and transition =
    Vers of �tat
  | Rejet;;

value d�terminise : auto__�tat -> determ__�tat
  and reconna�t : determ__�tat -> string -> bool;;
