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
open Graphics;;

open_graph "";;

let round x =
  if x >= 0.0
  then truncate (x +. 0.5)
  else - (truncate (-. x +. 0.5));;

type état =
   { mutable x : float; mutable y : float;
     mutable visée : float; mutable levé : bool };;

let crayon = { x = 0.0; y = 0.0; visée = 0.0; levé = false };;

let fixe_crayon b = crayon.levé <- b;;

let pi_sur_180 =
    let pi = 4.0 *. (atan 1.0) in pi /. 180.0;;

let tourne angle =
    crayon.visée <- (crayon.visée +. angle *. pi_sur_180);;

let avance d =
    let dx = d *. cos (crayon.visée)
    and dy = d *. sin (crayon.visée) in
    crayon.x <- crayon.x +. dx;
    crayon.y <- crayon.y +. dy;
    if crayon.levé
    then moveto (round crayon.x) (round crayon.y)
    else lineto (round crayon.x) (round crayon.y);;

let couleur_du_tracé = foreground;;
let couleur_du_fond = background;;
let zéro_x = float ((size_x ()) / 2);;
let zéro_y = float ((size_y ()) / 2);;
let vide_écran () =
    clear_graph();
    set_color couleur_du_tracé;
    crayon.x <- zéro_x;
    crayon.y <- zéro_y;
    crayon.visée <- 0.0;
    crayon.levé <- false;
    moveto (round crayon.x) (round crayon.y);;
