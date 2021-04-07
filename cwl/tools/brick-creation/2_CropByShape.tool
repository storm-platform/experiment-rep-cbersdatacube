#!/usr/local/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: papermill

hints:
    DockerRequirement:
      dockerPull: m3nin0/rep-cbers-dc-python:0.1

inputs:
    notebook:
        type: File
        inputBinding:
            position: 1

    notebook_out:
        type: string
        inputBinding:
            position: 2

    p_shp_directory:
        default: shp_directory
        inputBinding:
            position: 3
            prefix: -p
        type: string

    shp_directory:
        type: Directory
        inputBinding:
            position: 4

    p_shp_filename:
        default: shp_filename
        inputBinding:
            position: 5
            prefix: -p
        type: string

    shp_filename:
        type: string
        inputBinding:
            position: 6

    p_input_vrts:
        default: input_vrts
        inputBinding:
            position: 7
            prefix: -p
        type: string

    input_vrts:
        type: Directory
        inputBinding:
            position: 8

    p_output_raster_path:
        default: output_raster_path
        inputBinding:
            position: 9
            prefix: -p
        type: string

    output_raster_path:
        type: string
        inputBinding:
            position: 10

    kernel_spec:
        type: string
        inputBinding:
            prefix: -k
            position: 11

outputs:
    rasters_cropped_files:
        type: Directory
        outputBinding:
            glob: $(inputs.output_raster_path)
