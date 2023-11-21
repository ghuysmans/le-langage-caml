all: asm exec
asm: code.ml stockage.ml lexuniv.ml lecture.ml asm.ml
exec: code.ml simul.ml exec.ml

.SUFFIXES : .ml .mli .caml .camli

.caml.ml:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

.camli.mli:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

lecture.mli: code.mli 
simul.mli: code.mli 
stockage.mli: code.mli 
asm.ml: lecture.mli stockage.mli 
code.ml: code.mli 
exec.ml: simul.mli code.mli 
lecture.ml: lecture.mli lexuniv.mli code.mli stockage.mli 
lexuniv.ml: lexuniv.mli 
loadall.ml: exec.ml asm.ml 
simul.ml: simul.mli code.mli 
stockage.ml: stockage.mli code.mli 
