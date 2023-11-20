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
type tampon = { mutable val0: int; mutable nbits: int };;
let tampon = { val0 = 0; nbits = 0 };;
let initialise () = tampon.val0 <- 0; tampon.nbits <- 0;;
let écrire_bit sortie bit =
  tampon.val0 <- tampon.val0 lor (bit lsl tampon.nbits);
  tampon.nbits <- tampon.nbits + 1;
  if tampon.nbits >= 8 then begin
    output_char sortie (Char.chr tampon.val0);
    tampon.val0 <- 0;
    tampon.nbits <- 0
  end;;

let finir sortie =
  if tampon.nbits > 0 then
    output_char sortie (Char.chr tampon.val0);;
let lire_bit entrée =
  if tampon.nbits <= 0 then begin
    tampon.val0 <- Char.code(input_char entrée);
    tampon.nbits <- 8
  end;
  let res = tampon.val0 land 1 in
  tampon.val0 <- tampon.val0 lsr 1;
  tampon.nbits <- tampon.nbits - 1;
  res;;
