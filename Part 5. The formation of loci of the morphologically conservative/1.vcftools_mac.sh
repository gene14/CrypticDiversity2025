## Using the vcftools to screen the fixed divergent SNP between morphological species
#vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 108 --keep ecal_map --out ecal_non_ref --recode --recode-INFO-all
#vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 0 --max-non-ref-ac 0 --keep ecal_map --out ecal_only_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 126 --keep rockii_map --out rockii_non_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 0 --max-non-ref-ac 0 --keep rockii_map --out rockii_only_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 82 --keep kan_map --out kan_non_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 0 --max-non-ref-ac 0 --keep kan_map --out kan_only_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 68 --keep SW_map --out SW_non_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 0 --max-non-ref-ac 0 --keep SW_map --out SW_only_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 40 --keep NE_map --out NE_non_ref --recode --recode-INFO-all
vcftools --gzvcf A_kansu_158.0_9.filt_no_out_DP3_150.vcf.recode.vcf.gz --max-mac 0 --non-ref-ac 0 --max-non-ref-ac 0 --keep NE_map --out NE_only_ref --recode --recode-INFO-all
