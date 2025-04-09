#!/bin/bash

# Version of bwa-gtz: 0.7.17-r1188
# Version of samtools: 1.12; Using htslib 1.12; Copyright (C) 2021 Genome Research Ltd.
# Aims: Mapping fastq.gz file to a reference genome
# Time: 2021-06-03
# Modified from: Xiangguang Ma
# Author: Junchu Peng 

# Loop through the names listed in the file "list2"
for sample in $(cat list2)
do
  # Align the paired-end data with BWA, convert to BAM, and sort the resulting BAM file.
  bwa-gtz mem -t 50 \
    -R "@RG\tID:${sample}\tSM:${sample}\tPL:illumina" \
    ref/genome.fa \
    clean_data_by_fastp/${sample}.clean.R1.fastq.gz \
    clean_data_by_fastp/${sample}.clean.R2.fastq.gz \
  | samtools view -bh \
  | samtools sort -@ 50 -m 2G \
    -o bwa_output/${sample}.sort.bam
done
