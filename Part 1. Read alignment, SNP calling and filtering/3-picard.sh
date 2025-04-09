for sample in `cat list1` ### list1 contains all individual names
do
java -Xmx4g -jar picard.jar MarkDuplicates I=4-bam_out/${sample}.sort.bam O=4-duplicate_remove/${sample}.rmdum.bam CREATE_INDEX=true REMOVE_DUPLICATES=true M=duplicate_remove/${sample}.marked_dup_metrics.txt
done