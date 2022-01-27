#!/bin/bash -i

mkdir -p 04-Split
date=220123
rm 04-Split/${date}*

#rearrange columns to put taxonomy at beginning
cut -f1,310 03-Merged/${date}_GA03_GP13_normalized_sequence_counts.tsv > 04-Split/tmp1
cut -f2-309 03-Merged/${date}_GA03_GP13_normalized_sequence_counts.tsv > 04-Split/tmp2
paste 04-Split/tmp1 04-Split/tmp2 > 04-Split/${date}_GA03_GP13_normalized_sequence_counts_reordered_16S_and_18S.tsv
rm 04-Split/tmp* 2> /dev/null

#same but for proportions file
cut -f1,310 03-Merged/${date}_GA03_GP13_proportions.tsv > 04-Split/tmp1
cut -f2-309 03-Merged/${date}_GA03_GP13_proportions.tsv > 04-Split/tmp2
paste 04-Split/tmp1 04-Split/tmp2 > 04-Split/${date}_GA03_GP13_proportions_reordered_16S_and_18S.tsv
rm 04-Split/tmp* 2> /dev/null

#same but now for 16S only
cut -f1,308 02-PROKs/10-exports/all-16S-seqs.with-tax.tsv > 04-Split/tmp1
cut -f2-307 02-PROKs/10-exports/all-16S-seqs.with-tax.tsv > 04-Split/tmp2
paste 04-Split/tmp1 04-Split/tmp2 > 04-Split/${date}_GA03_GP13_sequence_counts_reordered_16S-only.tsv

#remove first line
tail -n+2 04-Split/${date}_GA03_GP13_sequence_counts_reordered_16S-only.tsv | sponge 04-Split/${date}_GA03_GP13_sequence_counts_reordered_16S-only.tsv
sed -i 's/#OTU ID/OTU_ID/g' 04-Split/${date}_GA03_GP13_sequence_counts_reordered_16S-only.tsv

#Change Chloroplast taxonomy string to clarify sequences are derived from Eukaryotes but represent 16S rRNA instead of 18S rRNA
sed -i 's/Eukaryota\;/Eukaryota-Chloroplast-16S\;/' 04-Split/${date}_GA03_GP13_sequence_counts_reordered_16S-only.tsv

rm 04-Split/tmp* 2> /dev/null

#subset spreadsheets with pandas (as wrapped by a python script; use qiime env for pandas library)
conda activate qiime2-2019.4

#unmerged 16S and 18S spreadsheets for those who would prefer to look at one or another
#plain sequence counts GP13 output
eASV-pipeline-for-515Y-926R/DADA2-pipeline/02-utility-scripts/remove-bad-columns-and-empty-rows.py \
  sample-metadata-backup/samples-to-remove-GP13.tsv \
  04-Split/${date}_GA03_GP13_sequence_counts_reordered_16S-only.tsv \
  04-Split/${date}_GP13_sequence_counts_16S_only.tsv

#merged spreadsheets (16S + 18S) according to 18S correction factor discussed in README
#plain sequence counts, GP13 output
eASV-pipeline-for-515Y-926R/DADA2-pipeline/02-utility-scripts/remove-bad-columns-and-empty-rows.py \
  sample-metadata-backup/samples-to-remove-GP13.tsv \
  04-Split/${date}_GA03_GP13_normalized_sequence_counts_reordered_16S_and_18S.tsv \
  04-Split/${date}_GP13_normalized_sequence_counts_reordered_16S_and_18S.tsv

#proportions GP13, 16S only
eASV-pipeline-for-515Y-926R/DADA2-pipeline/02-utility-scripts/remove-bad-columns-and-empty-rows.py \
  sample-metadata-backup/samples-to-remove-GP13.tsv \
  04-Split/${date}_GA03_GP13_proportions_reordered_16S-only.tsv \
  04-Split/${date}_GP13_proportions_reordered_16S-only.tsv

#sequence counts, GA03 output, merged table
eASV-pipeline-for-515Y-926R/DADA2-pipeline/02-utility-scripts/remove-bad-columns-and-empty-rows.py \
  sample-metadata-backup/samples-to-remove-GA03.tsv \
  04-Split/${date}_GA03_GP13_normalized_sequence_counts_reordered_16S_and_18S.tsv \
  04-Split/${date}_GA03_normalized_sequence_counts_reordered_16S_and_18S.tsv

#proportions, GA03 output, 16S only
eASV-pipeline-for-515Y-926R/DADA2-pipeline/02-utility-scripts/remove-bad-columns-and-empty-rows.py \
  sample-metadata-backup/samples-to-remove-GA03.tsv \
  04-Split/${date}_GA03_GP13_proportions_reordered_16S-only.tsv \
  04-Split/${date}_GA03_proportions_reordered_16S-only.tsv
