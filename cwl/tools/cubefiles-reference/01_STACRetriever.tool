#!/usr/local/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: cbersdatacube

hints:
    DockerRequirement:
      dockerPull: m3nin0/rep-cbers-dc-python:0.1

inputs:
    base_command:
        type: string
        default: stac2json
        inputBinding:
            position: 0

    bdc_stac_search_bbox:
        type: string
        inputBinding:
            position: 1
            prefix: --bdc-stac-search-bbox

    bdc_stac_search_limit:
        type: int
        inputBinding:
            position: 2
            prefix: --bdc-stac-search-limit

    bdc_stac_search_datetime:
        type: string
        inputBinding:
            position: 3
            prefix: --bdc-stac-search-datetime

    bdc_stac_url:
        type: string
        inputBinding:
            position: 5
            prefix: --bdc-stac-url

    bdc_stac_collection:
        type: string
        inputBinding:
            position: 6
            prefix: --bdc-stac-collection

    bdc_access_token:
        type: string
        inputBinding:
            position: 7
            prefix: --bdc-access-token

    output_file:
        type: string
        inputBinding:
            position: 8
            prefix: --output-file

outputs:
    stac_features_json:
        type: File
        outputBinding:
            glob: $(inputs.output_file)
