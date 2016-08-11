#!/bin/bash -l
#PBS -l walltime=72:00:00,nodes=1:ppn=24,mem=248gb
#PBS -N Camelina_Joelle_RNAseq_tophat
#PBS -q ram256g
#PBS -e Camelina_Joelle_RNAseq_tophat.error
#PBS -o Camelina_Joelle_RNAseq_tophat.out

#tophat v2.0.13
#bowtie2 v2.2.4

module load bowtie2
module load tophat

cd ~/camelina/RNAseq/joelle

tophat \
~/camelina/ref_genome/Cs_genome_v2 \
joelle_cat_R1.fastq joelle_cat_R2.fastq \
-G ~/camelina/ref_genome/Cs_genes_v2_annot.gff3 \
--library-type fr-firststrand \
-p 22 \
-r 0 \
--mate-std-dev 50 \
-i 20 \
-I 20000 \
--rg-sample Joelle