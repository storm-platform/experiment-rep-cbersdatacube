#!/usr/bin/env python3

import os

import numpy as np
import rasterio as rio


def create_vrt_from_stac_assets(assets: dict, assets_name_to_use: list, vrt_output_file: str):
    """Function to create GDAL VRT from STAC Assets
    Args:
        assets (dict): STAC-Assets dict (with href key)
        assets_name_to_use (list): List of assets to be insert in vrt
        vrt_output_file (str): Complete path and filename
    Returns:
        None
    """
    from osgeo import gdal

    # create href elements (vsicurl to allow gdal driver get elements without download complete image)
    assets_href = ["/vsicurl/" + assets[asset_name]['href'] for asset_name in assets_name_to_use]
    
    vrt_options = gdal.BuildVRTOptions(separate = True)
    vrt_gdal = gdal.BuildVRT(vrt_output_file, assets_href, options=vrt_options)
    vrt_gdal = None


def generate_multiple_vrt_from_stac_assets(features: list, assets_name_to_use: list, output_dir: str):
    """Function to create multiple GDAL VRT from STAC Features
    Args:
        assets (dict): STAC-Assets dict (with href key)
        assets_name_to_use (list): List of assets to be insert in vrt
        output_dir (str): Directory to generate VRTs
    Returns:
        None
    """

    import os
    os.makedirs(output_dir, exist_ok=True)

    for feature in features:
        feature_id = feature['id']
        feature_assets = feature['assets']
        feature_vrt_path = os.path.join(output_dir, f'{feature_id}.vrt')

        create_vrt_from_stac_assets(feature_assets, assets_name_to_use, feature_vrt_path)


def mask_raster_by_extents(raster_in, raster_out, bounds: tuple, multiple_bands = True) -> dict:
    """Crop raster by geometry extents. This function extracts the total bounds
    from geom data.
    
    Args:
        raster_in (str): Path to input raster file
        
        raster_out (str): Path where output raster will be written
        
        bounds (tuple): Tuple passed to the shapely.geometry.box function
        
        multiple_bands (bool): Flag to indicate the multi raster layer (brick) in function input
    Returns:
        None
    """

    from rasterio.mask import mask
    from shapely.geometry import box, mapping    
    
    _geom_convexhull = [mapping(box(*bounds))]
    
    with rio.open(raster_in) as src:
        out_image, out_transform = mask(src, _geom_convexhull, crop=True)
        out_meta = src.meta

    if multiple_bands:
        out_mutated_raster = None

        for dim in range(0, out_image.shape[0]):
            actual_dim = out_image[dim]
            actual_dim = actual_dim[~(actual_dim == out_meta['nodata']).all(axis=1)]
            actual_dim = actual_dim.T[~(actual_dim.T == out_meta['nodata']).all(axis = 1)].T
        
            if dim == 0:
                out_mutated_raster = np.zeros((out_image.shape[0], *actual_dim.shape))
            out_mutated_raster[dim] = actual_dim    
        out_image = out_mutated_raster

    # saving result
    out_meta.update(driver = "GTiff", 
                    height = out_image.shape[1], 
                    width = out_image.shape[2],
                    transform = out_transform)

    os.makedirs(os.path.split(raster_out)[0], exist_ok=True)
    with rio.open(raster_out, 'w', **out_meta) as out_dst:
        out_dst.write(out_image.astype('int16'))
