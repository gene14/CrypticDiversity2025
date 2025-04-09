Dsuite Dtrios -t grouptree.tre -n final1 A_kansu_158.0_9.filt_with_out_DP3_150.vcf.gz popmap158

Dsuite Fbranch -p 0.05 grouptree.tre popmap158_dquirtets_tree.txt
#### plot
dtools.py -n grouplevel_rename fbranch.grouplevel grouptree.tre