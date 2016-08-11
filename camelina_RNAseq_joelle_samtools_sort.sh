#!/bin/bash -l
# ----------------QSUB Parameters----------------- #
#PBS -l walltime=18:00:00,nodes=1:ppn=24,mem=62gb
#PBS -N camelina_RNAseq_joelle_samtools_sort
#PBS -e camelina_RNAseq_joelle_samtools_sort.error
#PBS -o camelina_RNAseq_joelle_samtools_sort.out
#PBS -M dorn@umn.edu
#PBS -m abe

# ----------------Load Modules-------------------- #
#samtools v 1.2
module load samtools

# ---------------------Commands------------------- #
cd ~/camelina/RNAseq/joelle/tophat_out

samtools sort accepted_hits.bam joelle_RNAseq_sorted