#!/bin/bash -i
#Note: I would normally run these steps semi-manually to inspect outputs at each step, but they are provided here together for clarity
#All scripts should be run from either the base directory (i.e. here) or the two subfolders created by the pipeline after splitting (i.e. "02-PROKs", and "02-EUKs")
./eASV-pipeline-for-515Y-926R/DADA2-pipeline/00-trimming-sorting-scripts/00-run-cutadapt.sh 
./eASV-pipeline-for-515Y-926R/DADA2-pipeline/00-trimming-sorting-scripts/01-sort-16S-18S-bbsplit.sh
#files have now been split into 16S and 18S pools, and can be denoised separately
cd 02-PROKs
./scripts/P00-create-manifest.sh
./scripts/P01-import.sh
./scripts/P02-visualize-quality_R1-R2.sh
#fwd trim=220bp, rev trim=180bp
./scripts/P03-DADA2.sh 220 180
#needed for merging script
./scripts/P04-export-DADA2-results.sh
./scripts/P05-classify-eASVs.sh
./scripts/P06-make-sample-metadata-file.py
./scripts/P07-make-barplot.sh
#did not cluster this time, seemed to confuse collaborators and adds too much data to CMAP
#./scripts/P08-optionally-cluster-eASVs.sh
./scripts/P09-split-mito-chloro-PhytoRef-reclassify.sh
#These biom tables are then the input for merging scripts
./scripts/P10-generate-tsv-biom-tables-with-taxonomy.sh
#following step optional, gives you proportional data to play with
./scripts/P11-transform-tsv-to-proportions.sh
#./scripts/P12a-remake-barplot-with-PhytoRef-taxonomy.sh
#./scripts/P12-make-subsetted-barplots.sh
#./scripts/P13-exclude-samples-from-barplots.sh
#./scripts/P14-optional-reclassify-multiple-p-confidence.sh
#./scripts/P15-optional-new-generate-tsv-biom-tables-with-taxonomy.sh
#./scripts/P16-optional-transform-tsv-to-proportions.sh
#./scripts/P17-optional-merge-taxonomy.sh
