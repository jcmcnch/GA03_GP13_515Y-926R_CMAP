# Scripts for Procssing BioGEOTRACES GA03/GP13 Amplicons Generated with 515Y/926R Primers

## Software requirements:

- A GNU/Linux system (e.g. Ubuntu) with [miniconda3](https://docs.conda.io/en/latest/miniconda.html#linux-installers) installed. May work on Windows or Mac but hasn't been tested there.
- Conda environments set up according to YAML files found in `envs`. For example, `conda env create --file envs/YAML-file.yaml`.
- Default command-line tools like `cut` and the `moreutils` package which can be installed on Ubuntu-like systems with `sudo apt-get install moreutils`.

## **Workflow overview:**

1. Denoised 16S and 18S separately with `DADA2` as implemented in `qiime2` according to the steps in `runscripts/00-denoising-workflow.sh` and using the raw data found at link below. If you want to reproduce this analysis, place raw reads downloaded from NCBI\* in the `00-raw/` folder. *To make subsequent annotation easier, Chloroplast sequence taxonomy strings were modified so they begin with "Chloroplast" instead of the less informative "Eukaryota".*.
2. Using Colette's R script (available [here](https://github.com/fletchec99/normalizing_16S_18S_tags)), merged 16S and 18S ASV tables, using a 5.76x correction factor for 18S. See [this paper](https://www.biorxiv.org/content/10.1101/866731v1.abstract) for information on why a correction is needed. The data associated with this correction is available [on this repository](https://github.com/jcmcnch/18S_sequencing_bias_determination_GA03_GP13).
3. Split cruises into two separate ASV tables, discarding blanks/mocks/duplicates.
4. These spreadsheets were then used as input for modelling, statistical analyses, CMAP, etc.

## Classification databases:

- Used SILVA138/PR2 4.12.0 databases available [here](https://osf.io/z8arq/).

## Data Quality Control and Cleanup:

- Reagent blanks prepared during this run had on average only 9 sequences despite an average sequencing depth of 48,000 sequences per non-blank sample. This suggests there was little reagent contamination in our samples.
- Mock communities were checked for 1-mismatches to known mock amplicon sequences, which could suggest denoising artifacts. The maximum value for these potential artifacts was 0.1% of mock reads, suggesting denoising worked well in general.
- S0273, S0362 both have very low sequence counts, and so were discarded. S0362-redo can substitute for S0362, but S0273 did not have a duplicate.
- S0252 is a strange sample - does not fit with a particular cast, so ignoring.
- S0336, S0448 are super-deep samples with some evidence of sequence contamination so ignoring.
- S0361 does not have any chloroplast sequences (deep sample ~1000m)

## Raw data:

- Sequence Read Archive information available [here](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA659851).
- Metadata file available [here](SRA-metadata/metadata-7716900-processed-ok.tsv).

## References:

Biller et al., [Marine microbial metagenomes sampled across space and time](https://www.nature.com/articles/sdata2018176). Scientific Data 5, 180176 (2018).

J. McNichol, P. M. Berube, S. J. Biller, J. A. Fuhrman, [Evaluating and Improving SSU rRNA PCR Primer Coverage via Metagenomes from Global Ocean Surveys](https://journals.asm.org/doi/10.1128/mSystems.00565-21). mSystems 00565-21 (2021).

## Other notes:

\* For easy downloading, I suggest using [this python package](https://github.com/wwood/kingfisher-download). 
