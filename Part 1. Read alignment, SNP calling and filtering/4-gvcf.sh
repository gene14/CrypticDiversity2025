## Aim: Used for calling variations with GATK
## Time: 2021-6-4
## Software used: GATK
## Author: Junchu Peng

# The script performs HaplotypeCaller from GATK on the input BAM files.
# BAM files are generated from aligning the paired-end FASTQ files to reference genome.
# The script generates GVCF files for each sample and logs the progress in separate files.

for sample in `cat list`
do
    echo "gatk HaplotypeCaller -R ref/genome.fa -ERC GVCF -I duplicate_remove/${sample}.rmdum.bam -O gvcf_output/${sample}.g.vcf 1> gvcf_output/${sample}.gvcf.gatk.gvcf.log 2>&1" >> gvcf_paralell.sh
done
