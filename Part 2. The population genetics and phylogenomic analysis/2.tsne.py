## Python
## Time: 2021-6-3
## Used for t-sne analysis based on unlink SNP
import pandas as pd
from sklearn.manifold import TSNE
from bioinfokit.visuz import cluster
## import the SNP data which is transformed to the 012 format by vcftools
## df = pd.read_csv('snp.012',sep='\t')
### df3 = pd.read_csv("input_file3",sep=" ")
df2 = pd.read_csv("snp.012",sep=" ")
tsne_em = TSNE(n_components=2, perplexity=30.0, n_iter=1000, verbose=1).fit_transform(df2)
## Plot without color
cluster.tsneplot(score=tsne_em)
## Import population or group informations
color_class <- pd.read_csv("color.list")
color_class2 = color_class['color.list'].to_numpy()
color_subpop = pd.read_csv("color_by_subpop")
color_subpop2 = color_subpop['color_sub'].to_numpy()
## Plot with color
cluster.tsneplot(score=tsne_em, colorlist=color_class2, colordot=('#264653', '#697A21', '#E76F51', '#287271', '#B8B42D' , '#A73B2D'), legendanchor=(1.15, 1) , figtype='pdf', figname='kansu_158_tsne_col_6')
