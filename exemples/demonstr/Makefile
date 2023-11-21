all: demonstr
demonstr: prop.ml lexuniv.ml asynt.ml demo.ml

.SUFFIXES : .ml .mli .caml .camli

.caml.ml:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

.camli.mli:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

asynt.mli: prop.mli 
asynt.ml: asynt.mli lexuniv.mli prop.mli 
demo.ml: asynt.mli prop.mli 
lexuniv.ml: lexuniv.mli 
loadall.ml: demo.ml 
prop.ml: prop.mli 
