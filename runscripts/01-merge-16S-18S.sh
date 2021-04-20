#!/bin/bash -i
#activate conda env specified in Colette's repo
conda activate r-optparse-env

#run script
normalizing_16S_18S_tags/normalize_16S_18S_ASVs.R \
  --inputproks 02-PROKs/10-exports/all-16S-seqs.with-tax.tsv \
  --inputeuks 02-EUKs/15-exports/all-18S-seqs.with-SILVA132-tax.tsv \
  --outputfile 210420_GA03_GP13 \
  --bias 5.76

#move output files to subfolder
mv 210420_GA03_GP13_* 03-Merged/
