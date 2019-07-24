FROM ubuntu:xenial
#
################################################################################
# conda installs
## miniconda from https://hub.docker.com/r/conda/miniconda3/dockerfile
RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes
ENV PATH /opt/conda/bin:$PATH
## fastp
RUN conda install -c bioconda fastp
## multiqc
#RUN conda install -c bioconda multiqc 
## samtools
RUN conda install -c bioconda samtools 


################################################################################
RUN pip install multiqc

# #################################
# # Python 2 and 3, plus packages

# RUN apt-get update && apt-get install -y \
#   wget \
#   unzip \
#   curl 


# # Configure environment
# ENV CONDA_DIR /opt/conda
# ENV PATH $CONDA_DIR/bin:$PATH

# # Install conda
# # RUN cd /tmp && wget https://repo.anaconda.com/miniconda/Miniconda2-4.5.11-Linux-x86_64.sh && \
# #    /bin/bash /tmp/miniconda.sh -b -p /opt/conda 

# #RUN cd /tmp && \
# #   mkdir -p $CONDA_DIR && \
# #   curl -s https://repo.continuum.io/miniconda/Miniconda3-4.3.21-Linux-x86_64.sh -o miniconda.sh && \
# #   /bin/bash miniconda.sh -f -b -p $CONDA_DIR && \
# #   rm miniconda.sh && \
# #    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
# #    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
# #    conda clean -tipsy

# # install multiqc
# ## dependencies
# ### python- in FROM
# ### conda- in FROM 
# # pip install multiqc




# # install cutadapt
# RUN pip install --user --upgrade cutadapt

# # install fastqc
# # fastqc requires java
# RUN apt-get update && apt-get install -y \
#   curl \
#   perl \
#   openjdk-8-jre-headless

# # Installs fastqc from compiled java distribution into /opt/FastQC
# ENV FASTQC_URL http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
# ENV FASTQC_VERSION 0.11.4
# ENV FASTQC_RELEASE fastqc_v${FASTQC_VERSION}.zip
# ENV DEST_DIR /opt/
# #http://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc
# # Make destination directory
# RUN mkdir -p $DEST_DIR

# # Download & extract archive - Repo includes binaries for linux
# WORKDIR /tmp

# # Do this in one command to avoid caching the zip file and its removal in separate layers
# RUN curl -SLO ${FASTQC_URL}/${FASTQC_RELEASE} && unzip ${FASTQC_RELEASE} -d ${DEST_DIR} && rm ${FASTQC_RELEASE}

# # Make the wrapper script executable
# RUN chmod a+x ${DEST_DIR}/FastQC/fastqc

# # Include it in PATH
# ENV PATH ${DEST_DIR}/FastQC:$PATH

# # install flexbar
# RUN conda install -c bioconda flexbar

# # install bowtie2
# #RUN conda install -c bowtie2

# # install samtools
# RUN apt-get update \
#     && apt-get install -y \
#         build-essential \
#         bzip2 \
#         curl \
#         zlib1g-dev \
#         libncurses5-dev

# ENV SAMTOOLS_VERSION 1.3.1

# WORKDIR /root
# RUN mkdir samtools \
#     && curl -fsSL https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2 \
#         | tar -jxC samtools --strip-components=1

# WORKDIR /root/samtools
# RUN ./configure \
#     && make all all-htslib \
#     && make install install-htslib

# # Clean Up
# RUN apt-get clean \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# # install deeptools
# RUN conda install -c bioconda deeptools

# RUN mkdir -p /opt/tools

# WORKDIR /opt/tools

# # install skewer
# RUN \
#   wget -c https://downloads.sourceforge.net/project/skewer/Binaries/skewer-0.2.2-linux-x86_64 && \
#   chmod +x skewer-0.2.2-linux-x86_64 && \
#   cp skewer-0.2.2-linux-x86_64 /usr/local/bin/skewer

# # install mosdepth
# RUN conda install -c bioconda mosdepth

# ENV version 2.18.26

# ADD https://github.com/broadinstitute/picard/releases/download/${version}/picard.jar /opt

# # install preseq
# RUN conda install -c bioconda preseq -y

# # install qualimap
# # Install libraries
# RUN \
#   apt-get update && apt-get install -y --no-install-recommends \
#     wget \
#   && rm -rf /var/lib/apt/lists/*

# # Setup ENV variables
# ENV \
#   PATH=$PATH:/opt/qualimap \
#   QUALIMAP_VERSION=2.2.1

# # Install BamQC
# RUN \
#   wget --quiet -O qualimap_v${QUALIMAP_VERSION}.zip \
#     https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v${QUALIMAP_VERSION}.zip \
#   && unzip qualimap_v${QUALIMAP_VERSION}.zip -d /opt/ \
#   && rm qualimap_v${QUALIMAP_VERSION}.zip \
#   && mv /opt/qualimap_v${QUALIMAP_VERSION} /opt/qualimap

# # Create UPPMAX directories
# RUN mkdir /pica /proj /scratch /sw

# # install samblaster
# RUN conda install -c bioconda samblaster

# # IDEAS
# # install GATK
# # install biobloomtools
# ## dependencies
# RUN apt-get install gcc
# #?boost?
# #?zlibdev?

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    build-essential \
    bzip2 \
    wget
