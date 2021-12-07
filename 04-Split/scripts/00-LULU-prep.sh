tail -n+2 210420_GA03_normalized_sequence_counts_reordered.tsv | cut -f1 > 210420_GA03_normalized_sequence_counts_reordered.ids
seqtk subseq ../02-PROKs/03-DADA2d/dna-sequences.fasta 210420_GA03_normalized_sequence_counts_reordered.ids > 210420_GA03_normalized_sequence_counts_reordered.fasta
seqtk subseq ../02-EUKs/08-DADA2d/dna-sequences.fasta 210420_GA03_normalized_sequence_counts_reordered.ids >> 210420_GA03_normalized_sequence_counts_reordered.fasta
