FROM jupyter/datascience-notebook@sha256:95be59f50f191ea515bafb9cff737d19c49a07bfa21033947dd52041c6a4f56b

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libudunits2-dev \
    libpq-dev \
    libgdal-dev \
    gdal-bin \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY spatial-env.sh spatial-env.sh
RUN ./spatial-env.sh

USER $NB_UID
RUN conda install --yes nb_conda

# install extra functions package
COPY setup.py setup.py
COPY rep_cbers_cube rep_cbers_cube

RUN python setup.py install
