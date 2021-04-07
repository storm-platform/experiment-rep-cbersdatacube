#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
import stac
import click


@click.group()
def cli():
    """
    :return:
    """
    pass


@cli.command(name="stac2json", help="Save a STAC Collection return in a JSON file")

@click.option('--bdc-stac-search-bbox', required=True, help='BDC STAC Search bbox')
@click.option('--bdc-stac-search-limit', required=True, help='BDC STAC Search limit')
@click.option('--bdc-stac-search-datetime', required=True, help='BDC STAC Search datetime')

@click.option('--bdc-stac-url', required=True, help='BDC STAC url')
@click.option('--bdc-stac-collection', required=True, help='Collection name (Ex. CB4_64_16D_STK-1)')
@click.option('--bdc-access-token', required=True, help='Personal Access Token of the BDC Auth')

@click.option('--output-file', required=True, help='output file')
def stac2json_cli(bdc_stac_search_bbox: str, 
                  bdc_stac_search_limit: int,
                  bdc_stac_search_datetime: str,
                  bdc_stac_url: str,
                  bdc_stac_collection: str,
                  bdc_access_token: str,
                  output_file: str):

    #
    # client instance
    #
    client = stac.STAC(bdc_stac_url, 
                    access_token=bdc_access_token)

    #
    # get stac-features
    #
    collection = client.collection(bdc_stac_collection)

    # west, south, east, north
    items = collection.get_items(filter = {
                                "bbox": bdc_stac_search_bbox, 
                                "datetime": bdc_stac_search_datetime,
                                "limit": bdc_stac_search_limit})

    #
    # export stac-features
    #
    with open(output_file, "w") as f:
        json.dump(items, f)


if __name__ == '__main__':
    stac2json_cli()
