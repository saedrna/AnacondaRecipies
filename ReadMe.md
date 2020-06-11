# Create Anaconda Environment
``` bash
# conda env create -n osketch -f environment.h2o.yml
conda env create -n openblas -f environment.openblas.yml
conda env create -n cuda -f environment.openblas.yml

conda activate [envname, e.g. openblas]

cd toolchains
robocopy ./ %CONDA_PREFIX% h2o.cmake
robocopy ./ %CONDA_PREFIX%/Library/plugins applocal.ps1
robocopy ./ %CONDA_PREFIX%/Library/plugins qtdeploy.ps1
robocopy ./ %CONDA_PREFIX% applocal.ps1
```
