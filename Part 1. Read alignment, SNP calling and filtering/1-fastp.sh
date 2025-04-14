#!/bin/bash

# Language: Shell
# Aims: Filtering raw reads using the fastp tool
# Time: 2021-06-02

# Loop through the names listed in the file "list2"
for name in $(cat list2)
do
  # Use fastp tool to clean the raw reads and generate output files with a .clean suffix
  fastp -i ${name}.R1.fastq.gz -I ${name}.R2.fastq.gz \
        -o clean_data_by_fastp/${name}.clean.R1.fastq.gz \
        -O clean_data_by_fastp/${name}.clean.R2.fastq.gz \
        -h ${name}.clean.html
done
