# gatk 4 is not supported by Conpair.  GenomeAnalysisTK.jar is removed  see: https://github.com/nygenome/Conpair/issues/11
# Legacy GATK3 builds are available here: https://console.cloud.google.com/storage/browser/gatk-software/package-archive/gatk;tab=objects?pli=1&prefix=
# I'm staring with a GATK 4.x base and adding the single GATK 3.x jar file to support Conpair
FROM broadinstitute/gatk:4.1.8.1

# install dependencies (GATK3: jdk-8, R   Conpair: python3, numpy, scipi)
RUN apt-get update -yq

## If using the ubuntu base
# RUN apt-get install -y openjdk-8-jdk python3 python-numpy python-scipy git

## if using the broadinstitute/gatk base (includes python3 and R)
RUN apt-get install -y git python-numpy python-scipy

# Install GATK 3.x
RUN mkdir /gatk3
WORKDIR /gatk3
RUN gsutil cp gs://gatk-software/package-archive/gatk/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef.tar.bz2 GenomeAnalysisTK-3.8-1.tar.bz2
RUN tar xjf GenomeAnalysisTK-3.8-1.tar.bz2 --strip-components=1 --warning=no-unknown-keyword --no-same-owner GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar
RUN rm GenomeAnalysisTK-3.8-1.tar.bz2

# download Conpair
RUN git clone https://github.com/nygenome/Conpair.git /conpair

# Conpair environment variables
ENV CONPAIR_DIR=/conpair
ENV GATK_JAR=/gatk3/GenomeAnalysisTK.jar
ENV PYTHONPATH=${PYTHONPATH}:${CONPAIR_DIR}/modules/
ENV PATH=${PATH}:${CONPAIR_DIR}/scripts

# install reference genomes
RUN mkdir -p /conpair/data/genomes
WORKDIR /conpair/data/genomes

# download reference genome
ADD http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz .
RUN gunzip hg38.fa.gz
RUN mv hg38.fa human_g1k_v38.fa

# create fai and dict files
# Conpair link is dead http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference
# Cache of above Conpair link doesn't work in GATK 4.x https://webcache.googleusercontent.com/search?q=cache:NC47SB-ZBqIJ:https://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference+&cd=1&hl=en&ct=clnk&gl=us
# this works using GATK 4.x https://gatk.broadinstitute.org/hc/en-us/articles/360035531652-FASTA-Reference-genome-format
RUN gatk CreateSequenceDictionary -R human_g1k_v38.fa
RUN samtools faidx human_g1k_v38.fa

# reset workdir to image default
WORKDIR /gatk
