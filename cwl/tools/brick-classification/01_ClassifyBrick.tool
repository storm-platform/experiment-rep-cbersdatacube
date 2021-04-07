#!/usr/local/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: papermill

hints:
    DockerRequirement:
      dockerPull: m3nin0/rep-cbers-dc-r:0.1

inputs:
    notebook:
        type: File
        inputBinding:
            position: 1

    notebook_out:
        type: string
        inputBinding:
            position: 2

    p_memsize:
        default: memsize
        inputBinding:
            position: 3
            prefix: -p
        type: string

    memsize:
        type: int
        inputBinding:
            position: 4

    p_multicores:
        default: multicores
        inputBinding:
            position: 5
            prefix: -p
        type: string

    multicores:
        type: int
        inputBinding:
            position: 6

    p_num_trees:
        default: num_trees
        inputBinding:
            position: 7
            prefix: -p
        type: string

    num_trees:
        type: int
        inputBinding:
            position: 8

    p_smoothing:
        default: smoothing
        inputBinding:
            position: 9
            prefix: -p
        type: string

    smoothing:
        type: string
        inputBinding:
            position: 10

    p_shp_directory:
        default: shp_directory
        inputBinding:
            position: 11
            prefix: -p
        type: string

    shp_directory:
        type: Directory
        inputBinding:
            position: 12

    p_shp_filename:
        default: shp_filename
        inputBinding:
            position: 13
            prefix: -p
        type: string

    shp_filename:
        type: string
        inputBinding:
            position: 14

    p_shp_class_attribute:
        default: shp_class_attribute
        inputBinding:
            position: 15
            prefix: -p
        type: string

    shp_class_attribute:
        type: string
        inputBinding:
            position: 16

    p_bands:
        default: bands
        inputBinding:
            position: 17
            prefix: -p
        type: string

    bands:
        type: string
        inputBinding:
            position: 18

    p_bricks_dir:
        default: bricks_dir
        inputBinding:
            position: 19
            prefix: -p
        type: string

    bricks_dir:
        type: Directory
        inputBinding:
            position: 20

    p_bricks_names:
        default: bricks_names
        inputBinding:
            position: 21
            prefix: -p
        type: string

    bricks_names:
        type: string
        inputBinding:
            position: 22

    p_timeline:
        default: timeline
        inputBinding:
            position: 23
            prefix: -p
        type: string

    timeline:
        type: string
        inputBinding:
            position: 24

    p_output_dir:
        default: output_dir
        inputBinding:
            position: 25
            prefix: -p
        type: string

    output_dir:
        type: string
        inputBinding:
            position: 26

    kernel_spec:
        type: string
        inputBinding:
            prefix: -k
            position: 27

outputs:    
    notebook_generated:
        type: File
        outputBinding:
            glob: $(inputs.notebook_out)

    classification_files:
        type: Directory
        outputBinding:
            glob: $(inputs.output_dir)
