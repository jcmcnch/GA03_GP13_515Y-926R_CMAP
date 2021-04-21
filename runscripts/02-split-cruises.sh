#!/bin/bash -i

mkdir -p 04-Split

#rearrange columns to put taxonomy at beginning
cut -f1,310 03-Merged/210420_GA03_GP13_normalized_sequence_counts.tsv > 04-Split/tmp1
cut -f2-309 03-Merged/210420_GA03_GP13_normalized_sequence_counts.tsv > 04-Split/tmp2
paste 04-Split/tmp1 04-Split/tmp2 > 04-Split/210420_GA03_GP13_normalized_sequence_counts_reordered.tsv
rm 04-Split/tmp*

cut -f1,310 03-Merged/210420_GA03_GP13_proportions.tsv > 04-Split/tmp1
cut -f2-309 03-Merged/210420_GA03_GP13_proportions.tsv > 04-Split/tmp2
paste 04-Split/tmp1 04-Split/tmp2 > 04-Split/210420_GA03_GP13_proportions_reordered.tsv
rm 04-Split/tmp*

#subset spreadsheets with pandas (as wrapped by a python script)
conda activate qiime2-2019.4
eASV-pipeline-for-515Y-926R/DADA2-pipeline/02-utility-scripts/remove-bad-columns-and-empty-rows.py \
  sample-metadata-backup/samples-to-remove-GP13.tsv \
  04-Split/210420_GA03_GP13_normalized_sequence_counts_reordered.tsv \
  04-Split/210420_GP13_normalized_sequence_counts_reordered.tsv

eASV-pipeline-for-515Y-926R/DADA2-pipeline/02-utility-scripts/remove-bad-columns-and-empty-rows.py \
  sample-metadata-backup/samples-to-remove-GP13.tsv \
  04-Split/210420_GA03_GP13_proportions_reordered.tsv \
  04-Split/210420_GP13_proportions_reordered.tsv
