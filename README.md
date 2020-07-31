This project bundles Conpair and dependencies into a Docker image which is then embedded within a DNAnexus applet.

Conpair: concordance and contamination estimator for tumor–normal pairs

Conpair is a fast and robust method dedicated for human tumor-normal studies to perform concordance verification (= samples coming from the same individual), as well as cross-individual contamination level estimation in whole-genome and whole-exome sequencing experiments. Importantly, our method of estimating contamination in the tumor samples is not affected by copy number changes and is able to detect contamination levels as low as 0.1%.

https://github.com/nygenome/Conpair

This image is based on GATK 4.x and contains:

- [GATK 4.x](https://github.com/broadinstitute/gatk) at /gatk
- [GATK 3.x](https://console.cloud.google.com/storage/browser/gatk-software/package-archive/gatk;tab=objects?pli=1&prefix=) at /gatk3
- [Conpair](https://github.com/nygenome/Conpair) at /conpair
- numpy
- scipy
- [GRCh38 human genome reference fasta](http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz) at /conpair/data/genomes/human_g1k_v38.fa
- GRCh38 sequence dictionary at /conpair/data/genomes/human_g1k_v38.dict
- GRCh38 fasta index at at /conpair/data/genomes/human_g1k_v38.fa.fai
