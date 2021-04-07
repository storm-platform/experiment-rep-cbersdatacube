#!/bin/bash

conda install -c conda-forge gdal --yes
pip install psycopg2 \
    ipykernel \
    geopandas \
    rasterio \
    papermill \
    loguru \
    numba
