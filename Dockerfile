# Get base image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system libraries required for python and R installations
RUN apt-get update && \
    apt-get install -y \
    --no-install-recommends \
    software-properties-common \
    dirmngr \
    build-essential \
    python3.9 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgmp-dev \
    nodejs

# Install common linux tools
RUN apt-get update && \
    apt-get install -y \
    --no-install-recommends \
    wget \
    curl \
    htop \
    less \
    nano \
    vim \
    git

# Install R version 4.1
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/"
RUN apt update && apt install -y r-base

# Install important R packages needed for scRNA-seq analysis and visualization
RUN Rscript -e "update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')"
RUN Rscript -e "install.packages(c('devtools', \
                                   'RColorBrewer', \
                                   'BiocManager', \
                                   'IRkernel', \
                                   'Seurat', \
                                   'rmarkdown', \
                                   'tidyverse', \
                                   'ggsci', \
                                   'sctransform', \
                                   'patchwork', \
                                   'harmony'), repos='https://ftp.gwdg.de/pub/misc/cran/')"
RUN Rscript -e "BiocManager::install(c('scran', \
                                       'scater', \
                                       'slingshot', \
                                       'clusterExperiment', \
                                       'tradeSeq', \
                                       'readxl'), version = '3.14')"

# Install important python packages needed for scRNA-seq analysis and visualization
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# repr patch to fix the html filtering bug introduced in R 4.1.1
RUN Rscript -e "library(devtools); install_github('renkun-ken/repr@fix-html-filter')"

RUN Rscript -e "IRkernel::installspec(user = FALSE)"

RUN apt-get clean -y && apt-get autoremove -y