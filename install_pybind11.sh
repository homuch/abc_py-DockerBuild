#!/bin/bash

cd pybind11
cmake .
make
export PYBIND11_DIR=$(pwd)
cd ..

