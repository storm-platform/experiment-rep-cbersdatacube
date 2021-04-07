#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os

import numpy as np
import rasterio as rio

from loguru import logger


def generate_brick(files, 
                   bands_reference, 
                   brick_out_dir, 
                   brick_name_pattern):
    """Function to generate bricks
    
    Args:
        files (list): files to extract bands to create bricks
        
        bands_reference (list): List of bands name (Same order in raster layers)
        
        brick_out_dir (str): The Path where bricks will be saved
    
        brick_name_pattern (str): Filename pattern
    Returns:
        None
    """
    
    os.makedirs(brick_out_dir, exist_ok=True)

    # create a default profile to all generated bricks
    default_profile = rio.open(files[0]).profile.copy()
    default_profile.update(count = len(files))
        
    for band_name, band_index in zip(bands_reference,
                                         range(1, len(bands_reference) + 1)):
        brick_name = f"{brick_name_pattern}_{band_name}_brick.tif"

        logger.info(f"Generate brick {brick_name}")

        with rio.open(os.path.join(brick_out_dir, brick_name), 'w', 
                                          **default_profile) as brick_out:
            for file, idx in zip(files, range(1, len(files) + 1)):
                with rio.open(file) as src:
                    brick_out.write(src.read(band_index), idx)
