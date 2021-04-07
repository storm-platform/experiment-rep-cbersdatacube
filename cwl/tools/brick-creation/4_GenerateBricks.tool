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

    p_input_raster_path:
        default: input_raster_path
        inputBinding:
            position: 3
            prefix: -p
        type: string

    input_raster_path:
        type: Directory
        inputBinding:
            position: 4

    p_input_raster_vegetation_index:
        default: input_raster_vegetation_index
        inputBinding:
            position: 5
            prefix: -p
        type: string

    input_raster_vegetation_index:
        type: Directory
        inputBinding:
            position: 6

    p_output_cubebrick:
        default: output_cubebrick
        inputBinding:
            position: 7
            prefix: -p
        type: string

    output_cubebrick:
        type: string
        inputBinding:
            position: 8

    p_collection_name:
        default: collection_name
        inputBinding:
            position: 9
            prefix: -p
        type: string

    collection_name:
        type: string
        inputBinding:
            position: 10

    kernel_spec:
        type: string
        inputBinding:
            prefix: -k
            position: 11

outputs:
    output_cubebrick:
        type: Directory
        outputBinding:
            glob: $(inputs.output_cubebrick)
