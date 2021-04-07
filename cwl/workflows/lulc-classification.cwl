class: Workflow
cwlVersion: v1.0

inputs:
  # General
  notebook: File
  notebook_out: string

  #
  # Computational resources
  #
  memsize: int
  multicores: int

  #
  # classification definitions
  #
  num_trees: int

  #
  # post-processing definition
  #
  smoothing: string

  #
  # samples
  #
  shp_filename: string
  shp_directory: Directory
  
  shp_class_attribute: string

  #
  # bricks configurations
  #
  bands: string
  timeline: string
  bricks_names: string
  bricks_dir: Directory

  output_dir: string
  kernel_spec: string

outputs:
  result_notebook_generated:
    type: File
    outputSource: classify_brick/notebook_generated

  result_classification_files:
    type: Directory
    outputSource: classify_brick/classification_files

steps:
  classify_brick:
    in:
      notebook: notebook
      notebook_out: notebook_out

      memsize: memsize
      multicores: multicores

      num_trees: num_trees

      smoothing: smoothing

      shp_filename: shp_filename
      shp_directory: shp_directory

      shp_class_attribute: shp_class_attribute

      bands: bands
      timeline: timeline
      bricks_dir: bricks_dir
      bricks_names: bricks_names

      output_dir: output_dir
      kernel_spec: kernel_spec
    out:
    - notebook_generated
    - classification_files
    run: ../tools/brick-classification/01_ClassifyBrick.tool
