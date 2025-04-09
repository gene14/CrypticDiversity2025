#AIM : Estimate the demographic history by smc++
## version of software: SMC++ v1.15.4.dev18+gca077da.d20210316
## Step1: convert the vcf to smc files by vcf2smc 
for i in `cat lineage`
do
mkdir ${i}
### behind grep must follow a $ to avoid the wrong individual
### -l  Length of contig
indv=$(cat 11lineage_map |grep ${i}$ |awk '{print $1}' |tr -s "\n" "," |sed "s/,$//g")
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest vcf2smc --cores 12 -l 44987648  ${input}.vcf.gz ${i}.CHR01.smc.gz CHR01 ${i}:${indv}
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest vcf2smc --cores 12 -l 41871963  ${input}.vcf.gz ${i}.CHR02.smc.gz CHR02 ${i}:${indv}
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest vcf2smc --cores 12 -l 40933368  ${input}.vcf.gz ${i}.CHR03.smc.gz CHR03 ${i}:${indv}
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest vcf2smc --cores 12 -l 39305171  ${input}.vcf.gz ${i}.CHR04.smc.gz CHR04 ${i}:${indv}
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest vcf2smc --cores 12 -l 41487097  ${input}.vcf.gz ${i}.CHR05.smc.gz CHR05 ${i}:${indv}
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest vcf2smc --cores 12 -l 28089996  ${input}.vcf.gz ${i}.CHR06.smc.gz CHR06 ${i}:${indv}
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest vcf2smc --cores 12 -l 40580291  ${input}.vcf.gz ${i}.CHR07.smc.gz CHR07 ${i}:${indv}
mv *.smc.gz ${i}
done
### step2 estimate
### mutation rate was set 1e-8 per generation
for i in `cat lineage`
do
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest estimate --timepoints 50 3000000 --spline cubic --knots 10 -o ${i}/ 1e-8 ${i}/*.smc.gz
mv ${i}/model.final.json output1/${i}.mutation.1e8.final.json
done

### Step3: joint plot
### generation time was set as 1 years
docker run --rm -v $PWD:/mnt terhorst/smcpp:latest plot -g 1 --linear -x 100 4000000 join_all_lineage.mutation_1e8.pdf *.mutation.1e8.final.json