#!/usr/local/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

inputs:
  # step 1
  stac_file: File
  notebook_out: string
  vrt_out_path: string
  notebook_step1: File
  kernel_spec_step1: string

  # step 2
  notebook_step2: File
  
  shp_filename: string
  shp_directory: Directory

  kernel_spec_step2: string
  notebook_out_step2: string
  output_raster_path: string

  # step 3
  notebook_step3: File

  kernel_spec_step3: string
  notebook_out_step3: string
  output_cubes_vegetation_index: string

  factor: int
  na_values: int

  # step 4
  notebook_step4: File

  output_cubebrick: string
  kernel_spec_step4: string
  notebook_out_step4: string

  collection_name: string

outputs:
  result_generate_vrt_tiles:
    type: Directory
    outputSource: generate_vrt_tiles/vrt_files

  result_crop_region_by_roi:
    type: Directory
    outputSource: crop_region_by_roi/rasters_cropped_files

  result_generate_cube_index:
    type: Directory
    outputSource: generate_cube_index/cubes_vegetation_index

  result_generate_bricks:
    type: Directory
    outputSource: generate_bricks/output_cubebrick

steps:
  generate_vrt_tiles:
    in:
      stac_file: stac_file
      notebook: notebook_step1
      vrt_out_path: vrt_out_path
      notebook_out: notebook_out
      kernel_spec: kernel_spec_step1
    out:
    - vrt_files
    run: ../tools/brick-creation/1_GenerateVRT.tool

  crop_region_by_roi:
    in:
      notebook: notebook_step2
      notebook_out: notebook_out_step2

      shp_filename: shp_filename
      shp_directory: shp_directory
      input_vrts: generate_vrt_tiles/vrt_files

      output_raster_path: output_raster_path

      kernel_spec: kernel_spec_step2
    out:
    - rasters_cropped_files
    run: ../tools/brick-creation/2_CropByShape.tool

  generate_cube_index:
    in:
      notebook: notebook_step3
      kernel_spec: kernel_spec_step3
      notebook_out: notebook_out_step3

      factor: factor
      na_values: na_values

      input_raster_path: crop_region_by_roi/rasters_cropped_files
      output_cubes_vegetation_index: output_cubes_vegetation_index

    out:
    - cubes_vegetation_index
    run: ../tools/brick-creation/3_GenerateCubeIndex.tool

  generate_bricks:
    in:
      notebook: notebook_step4
      kernel_spec: kernel_spec_step4
      notebook_out: notebook_out_step4

      collection_name: collection_name
      output_cubebrick: output_cubebrick

      input_raster_path: crop_region_by_roi/rasters_cropped_files
      input_raster_vegetation_index: generate_cube_index/cubes_vegetation_index

    out:
    - output_cubebrick
    run: ../tools/brick-creation/4_GenerateBricks.tool
