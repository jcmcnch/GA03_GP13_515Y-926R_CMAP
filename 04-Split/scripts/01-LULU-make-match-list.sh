#!/bin/bash -i
conda activate blast-env
mkdir -p blast-db/

if [[ ${#1} -eq 0 ]] ; then
	    echo 'Please enter the path to your fasta file that corresponds to your ASV table.'
	        exit 0
fi

cp $1 blast-db
filestem=`basename $1 .fasta`

#First produce a blastdatabase with the OTUs
makeblastdb -in blast-db/$1 -parse_seqids -dbtype nucl
# Then blast the OTUs against the database
blastn -db blast-db/$1 -outfmt '6 qseqid sseqid pident' -out blast-db/$filestem.match_list.tsv -qcov_hsp_perc 80 -perc_identity 84 -query blast-db/$1
