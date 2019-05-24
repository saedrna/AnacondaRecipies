conda config --add channels conda-forge
conda config --add channels saedrna
conda config --set anaconda_upload yes

conda-build purge

# conda-build alembic
# conda-build armadillo
# conda-build assimp
# conda-build boost-cpp
# conda-build capstone
# conda-build catch2
# conda-build cereal
# conda-build cgal-cpp
# conda-build flann
# conda-build geogram
# conda-build geographiclib
# conda-build glog
# conda-build gmm
# conda-build gsl
# conda-build jama
# conda-build khronos-opencl-icd-loader
# conda-build laszip
# conda-build libgdal
# conda-build libtiff
# conda-build opengv
# conda-build qhull
# conda-build suitesparse
# conda-build superlu
# conda-build tbb
# conda-build tnt
# conda-build xerces-c
# conda-build geos

conda-build ceres-solver
# conda-build geotiff
# conda-build openimageio
# conda-build viennacl

# conda-build coinutils
# conda-build osi
# conda-build clp
# conda-build openmvg

# conda-build open3d
# conda-build opencv
# conda-build openscenegraph
# conda-build pcl
# conda-build pdal

conda-build isis3