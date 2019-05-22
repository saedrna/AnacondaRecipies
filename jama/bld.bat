mkdir -p %LIBRARY_PREFIX%/include/jama/
robocopy ./ %LIBRARY_PREFIX%/include/jama/ *.h
