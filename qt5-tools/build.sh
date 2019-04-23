#!/bin/bash
qmake CONFIG+=release
make all -j$CPU_COUNT
make install
