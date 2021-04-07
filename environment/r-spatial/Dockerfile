FROM jupyter/minimal-notebook@sha256:736e3fbb2ba49592bd6d9a8af3add4a8379dcb53a7faa1cf17982f73f8b34165

ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gdal-bin git \
    htop \
    locales \
    lbzip2 \
    libfftw3-dev \
    libcairo2-dev \
    libgdal-dev libgeos-dev libgit2-dev libgsl0-dev \
    libgl1-mesa-dev  libglu1-mesa-dev \
    libhdf4-alt-dev libhdf5-dev \
    libjq-dev \
    libnetcdf-dev \
    libpq-dev libproj-dev libprotobuf-dev \
    libsqlite3-dev libssl-dev \
    libudunits2-dev libunwind-dev \
    netcdf-bin \
    postgis protobuf-compiler \
    rsync \
    sqlite3 \
    texlive-latex-base tk-dev \
    unixodbc-dev \
    vim \
    wget \
    qpdf \
    texlive-fonts-extra \
    ghostscript \
    pandoc

#
# configure papermill
#
RUN pip3 install papermill

#
# Configure locale
#
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt install gnupg2 software-properties-common -y \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt update -y \
    && apt-get install -y --no-install-recommends \
        r-base \
        r-base-dev \
        r-recommended \
        littler

#
# add littler in path
#

# based on: https://github.com/rocker-org/rocker/commit/9a8c555427dd572d3778d3af31e3e55a37c8fb70
RUN ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r \
    && ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r \
    && install.r docopt

#
# install geospatial dependencies
#

# based on: https://github.com/rocker-org/geospatial
RUN install2.r --error \
    classInt \
    deldir \
    geoR geosphere gstat \
    hdf5r \
    mapdata maptools \
    ncdf4 \
    proj4 \
    RColorBrewer RNetCDF \
    raster rgdal rgeos rlas \
    sf sp spacetime spatstat spdep

COPY sits-env.R sits-env.R 

#
# install sits
#
RUN wget https://raw.githubusercontent.com/e-sensing/sits/v0.10.0/DESCRIPTION \
    && sed -i -e 's/wtss/Rwtss/g' DESCRIPTION && sed -i -e 's/sits_Rwtss.R/sits_wtss.R/' DESCRIPTION \
    && Rscript sits-env.R \
    && rm sits-env.R DESCRIPTION

COPY config.yaml /usr/local/lib/R/site-library/sits/extdata/config.yml

USER $NB_UID
