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
type état =
  { mutable dtransitions : transition vect;
    dterminal : bool }
and transition =
    Vers of état
  | Rejet;;

value déterminise : auto__état -> determ__état
  and reconnaît : determ__état -> string -> bool;;
