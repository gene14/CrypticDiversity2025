for group in `cat grouplist`
do
for chr in `cat CHRname`
do
vcftools --vcf filter/A_kansu.raw.snp.0_9.filt_no_outgroup_chr1_7.recode.vcf --keep 1-lineage_input/${group}.keep --max-missing 1 --recode-INFO-all --max-meanDP 150 --min-meanDP 3 --recode --out 1-lineage_input/${group}.${chr} --chr ${chr}
bgzip 1-lineage_input/${group}.${chr}.recode.vcf  
glactools vcfm2acf --onlyGT --fai ref/genome.fa.fai 1-lineage_input/${group}.${chr}.recode.vcf.gz > 2-acf_out/${group}.${chr}.acf.gz
glactools acf2betascan --fold 2-acf_out/${group}.${chr}.acf.gz |gzip > 3-beta_input/${group}.${chr}.beta.txt.gz
python BetaScan/BetaScan.py -i 3-beta_input/${group}.${chr}.beta.txt.gz -fold -m 0.1 -o 4-betascan_out/${group}.${chr}.Pdefault_m01.betascores.txt
done
done
