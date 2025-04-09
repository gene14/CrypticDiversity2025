# CrypticDiversity-2025

Welcome to the **Standing genetic variation and introgression shape the cryptic radiation of *Aquilegia* in the mountains of Southwest China** project. This repository contains the scripts and workflows used to explore the genomic mechanisms underlying the rapid formation of cryptic diversity in *Aquilegia* species from the Southwest China. 

## Part 1: Read Alignment, SNP Calling, and Filtering

(1) **1-fastp.sh**: Cleans raw sequencing reads using the `fastp` tool. The output files are appended with a `.clean` suffix.

(2) **2-bwa.sh**: Maps cleaned reads (`.fastq.gz` files) to the reference genome using BWA.

(3) **3-picard.sh**: Uses `MarkDuplicates` from Picard to identify and remove duplicate reads from the aligned BAM files.

(4) **4-gvcf.sh**: Executes GATK's `HaplotypeCaller` on the input BAM files to generate GVCF files.

(5) **5-merge.sh**: Merges individual GVCF files into a single VCF file.

(6) **6-filtering.sh**: Filters the merged VCF file using `GATK` and `VCFtools` to obtain high-quality variant calls.

## Part 2. The population genetics and phylogenomic analysis

**(7) 1.ASTRAL_100kb.sh**: Constructs the species tree using `IQ-TREE` and `ASTRAL` based on 100kb windows.

**(8) 2.tsne.py**: Python script for t-SNE analysis on unlinked SNPs to visualize population structure.

## Part 3. Demographic history and introgression analysis

**(9)** **1-smcpp.sh**: Estimates the demographic history using `smc++`, incorporating both variant and invariant SNPs.

**(10) 2-QUIBL.sh:** Estimates introgression and incomplete lineage sorting (ILS) among lineages using `QUIBL`.****

(**11)** **3-Dsuite.sh**: Quantifies the proportions of introgression among lineages with `Dsuite`.****

## Part 4. The formation of genomic island

**(12)** **1.PBS_deltaFST.R:** a R script to screen and plot the outliers based on population branch statistics and deltaFst

**(13)** **2.convert_to_outlier_detection.sh** and **2.NAMESTOCHANGE_outlier_IBD_IBE.R**: to calculate the IBD and IBE effect of each outlier based on GLMM. 

**(14)** **3.Balancing_selection.sh:**  Screens loci under balancing selection using the `betascan` tool.

**(15) 4.cor_among_all.R:** Explores correlations among genomic divergence, diversity, genetic architecture, and introgression events.

**(16) 5.cor_fst_pi_GN_RR_da.R:** Investigates the link between genomic diversity and selection by analyzing correlations between diversity metrics and genomic architecture over time, proxied by da.

**(17) 6.FST_dxy_outliers_poplevel.R:** Compares genomic islands between sympatric and allopatric population pairs, focusing on FST and dxy metrics.

## Part 5. The formation of loci of the morphologically conservative

**(18) 1.vcftools_mac.sh:** Uses `VCFtools` to identify fixed divergent SNPs between morphological species.

**(19) 2.da_ILS_introgression.R:** Generates density plots of *d*a values in *Aquilegia kansuensis* and *Aquilegia rockii* using 5-kb windows to analyze introgression and ILS.

















