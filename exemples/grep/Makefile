all: grep fastgrep
grep: expr.ml auto.ml ensent.ml determ.ml grep.ml
fastgrep: expr.ml auto.ml ensent.ml determ.ml fastgrep.ml

.SUFFIXES : .ml .mli .caml .camli

.caml.ml:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

.camli.mli:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

auto.mli: expr.mli 
determ.mli: auto.mli 
fastrec.mli: determ.mli 
auto.ml: auto.mli expr.mli 
determ.ml: determ.mli auto.mli ensent.mli 
ensent.ml: ensent.mli 
expr.ml: expr.mli 
fastgrep.ml: determ.mli auto.mli expr.mli fastrec.mli 
grep.ml: determ.mli auto.mli expr.mli 
loadall.ml: grep.ml 
