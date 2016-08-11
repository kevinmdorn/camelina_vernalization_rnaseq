#!/bin/bash -l
# ----------------QSUB Parameters----------------- #
#PBS -l walltime=18:00:00,nodes=1:ppn=24,mem=62gb
#PBS -N camelina_RNAseq_CO46_samtools_strandparse
#PBS -e camelina_RNAseq_CO46_samtools_strandparse.error
#PBS -o camelina_RNAseq_CO46_samtools_strandparse.out
#PBS -M dorn@umn.edu
#PBS -m abe

# ----------------Load Modules-------------------- #
#samtools v 1.2
module load samtools

# ---------------------Commands------------------- #

cd ~/camelina/RNAseq/CO46/tophat_out

###CO46_RNAseq
#These reads are all of the CO46 trimmed reads from this experiment concatenated together to try and find sense/antisense start/stop points in the FLC loci 
# Sense (+) strand 

# SAM flag explainations (-f) 
#  http://broadinstitute.github.io/picard/explain-flags.html

# Read /2 is the one that corresponds to the orignial RNA molecule 

#5' ------------------3'   <- this is a transcript from the sense strand  
#   --->           <---
#    /2              /1
# -f  163             83


#                     83  <- SAM FLAG = read paired + read mapped in proper pair + read reverse strand + first in pair 
#                     /1
#                  <---
#3' ------------------5' <- this is the corresponding cDNA fragment (1st strand) 
#5' ------------------3' <- this is the corresponding cDNA fragment (2nd strand) 
#---> 
# 163 <- SAM FLAG = read paired + read mapped in proper pair + mate reverse strand + second in pair 

samtools view -b -f 163 CO46_RNAseq_sorted.bam > fwd1.bam
samtools index fwd1.bam

#2
samtools view -b -f 83 CO46_RNAseq_sorted.bam > fwd2.bam
samtools index fwd2.bam


# Combine alignments that originate on the forward strand.
samtools merge -f CO46_fwd.bam fwd1.bam fwd2.bam
samtools index CO46_fwd.bam




# Antisense (-) strand (rev) 

#5' ------------------3'   <- this is a transcript from the sense strand  
#   --->           <---
#    /1              /2
# -f  99             147


#                     147  <- SAM FLAG = read paired + read mapped in proper pair + read reverse strand + second in pair 
#                     /1
#                  <---
#3' ------------------5' <- this is the corresponding cDNA fragment (1st strand) 
#5' ------------------3' <- this is the corresponding cDNA fragment (2nd strand) 
#---> 
# 99 <- SAM FLAG = read paired + read mapped in proper pair + mate reverse strand + first in pair 


samtools view -b -f 99 CO46_RNAseq_sorted.bam > rev1.bam
samtools index rev1.bam

samtools view -b -f 147 -F 16 CO46_RNAseq_sorted.bam > rev2.bam
samtools index rev2.bam

#
# Combine alignments that originate on the reverse strand.
#
samtools merge -f CO46_rev.bam rev1.bam rev2.bam
samtools index CO46_rev.bam