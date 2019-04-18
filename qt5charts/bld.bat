qmake CONFIG+=release
if errorlevel 1 exit 1

jom release
if errorlevel 1 exit 1

jom install
if errorlevel 1 exit 1
