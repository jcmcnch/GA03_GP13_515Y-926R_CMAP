# Scripts needed to reproduce data processing steps for BioGEOTRACES GA03/GP13 amplicon sequences generated with 515Y/926R primers

General workflow:

1. Denoised 16S and 18S separately according to the steps in `runscripts/00-denoising-workflow.sh`.
2. Using Colette's R script (available [here](https://github.com/fletchec99/normalizing_16S_18S_tags)), merged 16S and 18S ASV tables, using a 5.76x correction factor for 18S. See [this paper](https://www.biorxiv.org/content/10.1101/866731v1.abstract) for information on why a correction is needed. The data associated with this correction is available [on this repository](https://github.com/jcmcnch/18S_sequencing_bias_determination_GA03_GP13).
3. Split out the two cruises, discarding blanks/mocks/duplicates.
4. These spreadsheets were then used as input for modelling, statistical analyses, CMAP, etc.

Classification databases:

- Used SILVA138/PR2 4.12.0 databases available [here](https://osf.io/z8arq/).

Raw data:

- Sequence Read Archive information available [here](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA659851).
- Metadata file available [here](SRA-metadata/metadata-7716900-processed-ok.tsv).

References:

Biller et al., Marine microbial metagenomes sampled across space and time. Scientific Data 5, 180176 (2018). [paper link](https://www.nature.com/articles/sdata2018176)

J. McNichol, P. M. Berube, S. J. Biller, J. A. Fuhrman, Evaluating and Improving SSU rRNA PCR Primer Coverage via Metagenomes from Global Ocean Surveys. bioRxiv, 2020.11.09.375543 (2020). [paper link](https://www.biorxiv.org/content/10.1101/2020.11.09.375543v1)
