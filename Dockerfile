FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

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

RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/"
RUN apt update && apt install -y r-base

RUN Rscript -e "update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')"
RUN Rscript -e "install.packages(c('devtools', \
                                   'RColorBrewer', \
                                   'BiocManager', \
                                   'IRkernel', \
                                   'remotes', \
                                   'rmarkdown', \
                                   'tidyverse'), repos='https://ftp.gwdg.de/pub/misc/cran/')"
RUN Rscript -e "remotes::install_github(repo = 'satijalab/seurat', ref = 'develop')"
RUN Rscript -e "BiocManager::install(c('scran', \
                                       'scater', \
                                       'slingshot', \
                                       'clusterExperiment', \
                                       'tradeSeq'), version = '3.13')"

WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

RUN Rscript -e "IRkernel::installspec(user = FALSE)"

COPY . /app

RUN apt-get clean -y && apt-get autoremove -y