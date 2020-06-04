# Create Anaconda Environment
``` bash
conda env create -n osketch -f environment.h2o.yml
conda env create -n openblas -f environment.openblas.yml

cd toolchains
robocopy ./ %CONDA_PREFIX% h2o.cmake
robocopy ./ %CONDA_PREFIX%/Library/plugins applocal.ps1
robocopy ./ %CONDA_PREFIX%/Library/plugins qtdeploy.ps1
robocopy ./ %CONDA_PREFIX% applocal.ps1
```