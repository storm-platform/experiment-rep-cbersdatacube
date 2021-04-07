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

    p_output_cubes_vegetation_index:
        default: output_cubes_vegetation_index
        inputBinding:
            position: 5
            prefix: -p
        type: string

    output_cubes_vegetation_index:
        type: string
        inputBinding:
            position: 6

    p_factor:
        default: factor
        inputBinding:
            position: 7
            prefix: -p
        type: string

    factor:
        type: int
        default: 10000
        inputBinding:
            position: 8

    p_na_values:
        default: na_values
        inputBinding:
            position: 9
            prefix: -p
        type: string

    na_values:
        type: int
        default: -9999
        inputBinding:
            position: 10

    kernel_spec:
        type: string
        inputBinding:
            prefix: -k
            position: 11

outputs:
    cubes_vegetation_index:
        type: Directory
        outputBinding:
            glob: $(inputs.output_cubes_vegetation_index)
