#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from numba import jit


@jit(nopython=True)
def gndvi(nir, green):
    """Normalized Difference NIR/Green Green NDVI boosted with Numba

    See:
        https://www.indexdatabase.de/db/i-single.php?id=401
    """

    return (nir - green) / (nir + green)


@jit(nopython=True)
def ndwi2(green, nir):
    """Normalized Difference 857/1241 Normalized Difference Water Index boosted with Numba

    See:
        https://www.indexdatabase.de/db/i-single.php?id=546
    """

    return (green - nir) / (green + nir)


@jit(nopython=True)
def pvr(green, red):
    """Normalized Difference 550/650 Photosynthetic vigour ratio boosted with Numba

    See:
        https://www.indexdatabase.de/db/i-single.php?id=484
    """

    return (green - red) / (green + red)


@jit(nopython=True)
def gemi(red, nir):
    """Global Environment Monitoring Index boosted with Numba

    See:
        https://www.indexdatabase.de/db/i-single.php?id=25
    """

    red2 = red ** 2
    nir2 = nir ** 2
    
    eta = (2 * (nir2 - red2) + (1.5 * nir) + (0.5 * red)) / (nir + red + 0.5)

    return eta * (1 - 0.25*eta) - ((red - 0.125) / (1 - red))
