all: logo
logo: crayon.ml langage.ml alex.ml asynt.ml logo.ml

.SUFFIXES : .ml .mli .caml .camli

.caml.ml:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

.camli.mli:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

asynt.mli: alex.mli langage.mli 
alex.ml: alex.mli 
asynt.ml: asynt.mli langage.mli alex.mli 
crayon.ml: crayon.mli 
langage.ml: langage.mli crayon.mli 
loadall.ml: logo.ml 
logo.ml: crayon.mli alex.mli asynt.mli langage.mli 
