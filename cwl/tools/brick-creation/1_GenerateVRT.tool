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

    p_stac_file:
        default: stac_file
        inputBinding:
            position: 3
            prefix: -p
        type: string

    stac_file:
        type: File
        inputBinding:
            position: 4

    p_vrt_out_path:
        default: vrt_out_path
        inputBinding:
            position: 5
            prefix: -p
        type: string

    vrt_out_path:
        type: string
        inputBinding:
            position: 6

    kernel_spec:
        type: string
        inputBinding:
            prefix: -k
            position: 7

outputs:
    vrt_files:
        type: Directory
        outputBinding:
            glob: $(inputs.vrt_out_path)
