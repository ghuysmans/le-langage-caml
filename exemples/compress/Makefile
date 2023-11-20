all: compr
compr: esbit.ml fileprio.ml huffman.ml compr.ml

.SUFFIXES : .ml .mli .caml .camli

.caml.ml:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

.camli.mli:
	caml2csl -clib ~/.opam/4.08.1/lib/caml2csl/std.zlc -I ~/.opam/4.08.1/lib/caml2csl $<

compr.ml: huffman.mli 
decompr.ml: huffman.mli 
esbit.ml: esbit.mli 
fileprio.ml: fileprio.mli 
huffman.ml: huffman.mli esbit.mli fileprio.mli 
loadall.ml: compr.ml 
