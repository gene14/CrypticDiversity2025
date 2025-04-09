# 7.3 call SNP/Indel by gatk with genotypeGVCFs program
gatk --java-options "-Xmx100G -XX:+UseParallelGC -XX:ParallelGCThreads=30" GenotypeGVCFs -R ref/genome.fa --variant cryptic_diversity.merge.g.vcf -O cryptic_diversity.merged_gvcf.vcf
## 8.1 Extracting SNP
gatk --java-options "-Xmx100G -XX:+UseParallelGC -XX:ParallelGCThreads=30" SelectVariants -R ref/genome.fa -V cryptic_diversity.merged_gvcf.vcf --select-type SNP -O cryptic_diversity.merge.raw.snp.vcf
## 8.2 Filtering SNP
gatk --java-options "-Xmx100G -XX:+UseParallelGC -XX:ParallelGCThreads=30" VariantFiltration -R ref/genome.fa -V cryptic_diversity.merge.raw.snp.vcf --filter-expression "QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name 'Filter' -O cryptic_diversity.merge.raw.snp.filt.vcf
## 8.3 Generating high quality SNP
gatk --java-options "-Xmx100G -XX:+UseParallelGC -XX:ParallelGCThreads=30" SelectVariants -R ref/genome.fa -V cryptic_diversity.merge.raw.snp.filt.vcf --exclude-filtered -O cryptic_diversity.merge.raw.snp.pass.vcf
### 9.1 filtering by the VCFtools
vcftools --gzvcf cryptic_diversity.merged_gvcf.vcf.gz --out cryptic_diversity_158_in_invariant --recode --recode-INFO-all --min-meanDP 3 --max-meanDP 150 --minQ 30 --remove-indels --max-missing 0.9 --keep list158 --max-alleles 2 
vcftools --gzvcf  cryptic_diversity.merge.raw.snp.pass.vcf --out cryptic_diversity_158.0_9.filt_no_out_DP3_150 --recode --recode-INFO-all --min-meanDP 3 --max-meanDP 150 --minQ 30 --remove-indels --max-missing 0.9 --keep list158 --max-alleles 2 --min-alleles 2 --maf 0.05
