FROM jeszyman/bioinformatics-toolkit

# install multiqc
## dependencies
### python- in FROM
### conda- in FROM 
# pip install multiqc

RUN conda install -c bioconda multiqc -y


# install cutadapt
RUN pip install --user --upgrade cutadapt

# install fastqc
# FASTQC
ENV URL=http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
ENV ZIP=fastqc_v0.11.5.zip

RUN wget $URL/$ZIP -O $DST/$ZIP && \
  unzip - $DST/$ZIP -d $DST && \
  rm $DST/$ZIP && \
  cd $DST/FastQC && \
  chmod 755 fastqc && \
  ln -s $DST/FastQC/fastqc /usr/local/bin/fastqc

# install fastp
RUN conda install -c bioconda fastp

# install flexbar
RUN conda install -c bioconda flexbar

# install bowtie2
#RUN conda install -c bowtie2

# install samtools
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        bzip2 \
        curl \
        zlib1g-dev \
        libncurses5-dev

ENV SAMTOOLS_VERSION 1.3.1

WORKDIR /root
RUN mkdir samtools \
    && curl -fsSL https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2 \
        | tar -jxC samtools --strip-components=1

WORKDIR /root/samtools
RUN ./configure \
    && make all all-htslib \
    && make install install-htslib

# Clean Up
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install deeptools
RUN conda install -c bioconda deeptools

RUN mkdir -p /opt/tools

WORKDIR /opt/tools

# install skewer
RUN \
  wget -c https://downloads.sourceforge.net/project/skewer/Binaries/skewer-0.2.2-linux-x86_64 && \
  chmod +x skewer-0.2.2-linux-x86_64 && \
  cp skewer-0.2.2-linux-x86_64 /usr/local/bin/skewer

# install mosdepth
RUN conda install -c bioconda mosdepth

ENV version 2.18.26

ADD https://github.com/broadinstitute/picard/releases/download/${version}/picard.jar /opt

# install preseq
RUN conda install -c bioconda preseq -y

# install qualimap
# Install libraries
RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    wget \
  && rm -rf /var/lib/apt/lists/*

# Setup ENV variables
ENV \
  PATH=$PATH:/opt/qualimap \
  QUALIMAP_VERSION=2.2.1

# Install BamQC
RUN \
  wget --quiet -O qualimap_v${QUALIMAP_VERSION}.zip \
    https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v${QUALIMAP_VERSION}.zip \
  && unzip qualimap_v${QUALIMAP_VERSION}.zip -d /opt/ \
  && rm qualimap_v${QUALIMAP_VERSION}.zip \
  && mv /opt/qualimap_v${QUALIMAP_VERSION} /opt/qualimap

# Create UPPMAX directories
RUN mkdir /pica /proj /scratch /sw

# install samblaster
RUN conda install -c bioconda samblaster

# IDEAS
# install GATK
# install biobloomtools
## dependencies
RUN apt-get install gcc
#?boost?
#?zlibdev?
