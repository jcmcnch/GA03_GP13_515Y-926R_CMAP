#!/bin/bash -i
#activate conda env specified in Colette's repo
conda activate r-optparse-env

date=211207

#Change taxonomy string to clarify these sequences are derived from Eukaryotes but represent 16S rRNA instead of 18S rRNA
sed 's/Eukaryota\;/Eukaryota-Chloroplast-16S\;/' 02-PROKs/10-exports/all-16S-seqs.with-tax.tsv > tmp.16S.chloroplast.renamed.tsv

mkdir -p 03-Merged

#run script
normalizing_16S_18S_tags/normalize_16S_18S_ASVs.R \
  --inputproks tmp.16S.chloroplast.renamed.tsv \
  --inputeuks 02-EUKs/15-exports/all-18S-seqs.with-PR2-tax.tsv \
  --outputfile ${date}_GA03_GP13 \
  --bias 5.76

#move output files to subfolder
mv ${date}_GA03_GP13_* 03-Merged/

#remove temp file
rm tmp.16S.chloroplast.renamed.tsv
