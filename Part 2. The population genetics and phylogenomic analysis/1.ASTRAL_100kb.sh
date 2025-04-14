### AIM: to construct the ASTRAL species tree
### step1: Build a bed file of the entire genome with a window size of 100kb
mkdir bedfile
for i in {1..2770}
do
head -1 bedfile/window1.bed > bedfile/window${i}.bed
head -${i} windows_all.bed | tail -1 >> bedfile/window${i}.bed
done
### step2: Use vcftools to extract target sites, and then use vcf2phylip.sh to convert to phylip format
for i in {1..2770}
do
vcftools --vcf A_kansu_158.0_9.filt_with_out_DP3_150.recode.vcf --bed bedfile/window${i}.bed --out vcffile/A_kansu.window${i}  --recode --recode-INFO-all
python vcf2phylip.py -i vcffile/A_kansu.window${i}.recode.vcf --output-prefix phyfile/A_kansu.window${i} -f -n -b
done
### step3: Use iqtree to build a phylogenetic tree for each window files
for i in {1..2770}
do
echo "iqtree -s A_kansu.window${i}.min4.phy  -bb 1000 -o TB11,TB12,TB13" >> treefile_iqtree/1.sh
done

java -jar ./Astral/astral.5.7.3.jar -i all2770.tre -o species_quarter_support.tre -t 1 &2 > species_quarter_support.log