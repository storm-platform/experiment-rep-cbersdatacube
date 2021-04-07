getdata:
	cwl-runner cwl/workflows/lulc-cubefiles-reference.cwl cwl/input/lulc-cubefiles-reference-job.yml
	mv cb4_features.json data/derived_data

createbrick:
	cwl-runner cwl/workflows/lulc-brick-creation.cwl cwl/input/lulc-brick-preparation-job.yml
	mv vrt rasters bricks cubes_vegetation_index data/derived_data

classifybrick:
	cwl-runner cwl/workflows/lulc-classification.cwl cwl/input/lulc-classification-job.yml
	mv lulc_maps/ data/derived_data/
	mv 01_ClassifyBrick_Generated.ipynb data/derived_data

replicate: getdata createbrick classifybrick
