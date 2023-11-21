all: minicaml
minicaml: eval.ml lexuniv.ml syntaxe.ml types.ml synthese.ml caml.ml

.SUFFIXES : .ml .mli .caml .camli

.caml.ml:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

.camli.mli:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

eval.mli: syntaxe.mli 
synthese.mli: syntaxe.mli types.mli 
caml.ml: eval.mli types.mli synthese.mli syntaxe.mli 
eval.ml: eval.mli syntaxe.mli 
interp.ml: syntaxe.mli eval.mli 
lexuniv.ml: lexuniv.mli 
loadall.ml: caml.ml 
syntaxe.ml: syntaxe.mli lexuniv.mli 
synthese.ml: synthese.mli types.mli syntaxe.mli 
types.ml: types.mli 
typeur.ml: types.mli syntaxe.mli synthese.mli 
