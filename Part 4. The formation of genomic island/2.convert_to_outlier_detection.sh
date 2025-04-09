for i in `cat grouplist`
do
sed 's/NAMESTOCHANGE/${i}/g' 2.NAMESTOCHANGE_outlier_IBD_IBE.R > Rscript/${i}_outlier_IBD_IBE.R
done