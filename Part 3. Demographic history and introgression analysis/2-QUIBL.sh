## AIMS：Using QUIBL to estimate the introgression and incomplete lineage sorting. 
for num in `seq 100`
do
rm -f 1-5k_input/5k_Select500_${num}_lineage.tre
touch 1-5k_input/5k_Select500_${num}_lineage.tre
for i in `seq 500`
do
sed -n "$[($i+3)*43+$num]p" Subset_iqtree.50snp.tre >> 1-5k_input/5k_Select500_${num}_lineage.tre
done
cat Random3.txt | sed "s/RANDOM/${num}/g" > 1-5k_input/5k_Select500_${num}.txt
python QuIBL.py 1-5k_input/5k_Select500_${num}.txt
done