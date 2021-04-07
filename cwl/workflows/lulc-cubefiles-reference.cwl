class: Workflow
cwlVersion: v1.0

inputs:
  #
  # Search parameters
  #
  bdc_stac_search_limit: int
  bdc_stac_search_bbox: string
  bdc_stac_search_datetime: string

  #
  # STAC service
  #
  bdc_stac_url: string
  bdc_access_token: string
  bdc_stac_collection: string

  #
  # output file
  #
  output_file: string

outputs:
  result_stac_retriever:
    type: File
    outputSource: stac_retriever/stac_features_json

steps:
  stac_retriever:
    in:
      bdc_stac_search_bbox: bdc_stac_search_bbox
      bdc_stac_search_limit: bdc_stac_search_limit
      bdc_stac_search_datetime: bdc_stac_search_datetime

      bdc_stac_url: bdc_stac_url
      bdc_access_token: bdc_access_token
      bdc_stac_collection: bdc_stac_collection

      output_file: output_file
    out:
    - stac_features_json
    run: ../tools/cubefiles-reference/01_STACRetriever.tool
