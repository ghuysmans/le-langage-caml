all: ipascal cpascal
ipascal: lexuniv.ml syntaxe.ml valeur.ml envir.ml interp.ml typage.ml ipascal.ml
cpascal: lexuniv.ml syntaxe.ml envir.ml typage.ml compil.ml cpascal.ml

.SUFFIXES : .ml .mli .caml .camli

.caml.ml:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

.camli.mli:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

compil.mli: syntaxe.mli 
envir.mli: syntaxe.mli 
interp.mli: syntaxe.mli 
typage.mli: syntaxe.mli 
compil.ml: compil.mli typage.mli envir.mli syntaxe.mli 
cpascal.ml: typage.mli syntaxe.mli compil.mli 
envir.ml: envir.mli syntaxe.mli 
interp.ml: interp.mli syntaxe.mli envir.mli valeur.mli 
ipascal.ml: interp.mli syntaxe.mli typage.mli 
lexuniv.ml: lexuniv.mli 
loadall.ml: cpascal.ml ipascal.ml 
syntaxe.ml: syntaxe.mli lexuniv.mli 
typage.ml: typage.mli envir.mli syntaxe.mli 
valeur.ml: valeur.mli interp.mli 
