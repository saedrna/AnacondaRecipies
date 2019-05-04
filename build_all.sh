sudo apt install libgl1-mesa-dev \
    libglu1-mesa-dev \
    build-essential

conda config --add channels conda-forge
conda config --add channels saedrna
conda config --set anaconda_upload yes

conda activate base

conda-build assimp
conda-build boost-cpp
conda-build capstone
conda-build catch2
conda-build cereal
conda-build cgal-cpp
conda-build flann
conda-build geogram
conda-build geographiclib
conda-build glog
conda-build khronos-opencl-icd-loader
conda-build laszip
conda-build libgdal
conda-build libtiff
conda-build qhull
conda-build suitesparse
conda-build opengv
conda-build xerces-c

conda-build viennacl

conda-build coinutils
conda-build osi
conda-build clp
conda-build openmvg

conda-build pcl

conda-build open3d

conda-build ceres-solver

conda-build qt5-base
conda-build qt5-declarative
conda-build qt5-charts
conda-build qt5-graphicaleffects
conda-build qt5-imageformats
conda-build qt5-quickcontrols2
conda-build qt5-svg
conda-build qt5-tools
conda-build qt5-winextras
conda-build qt3d

conda-build opencv

conda-build openscenegraph
