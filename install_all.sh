#!/bin/bash

apt-get update && apt-get install -y make cmake libboost-all-dev doxygen
cd abc 
make ABC_USE_NO_READLINE=1 ABC_USE_PIC=1 libabc.a
cd ../pybind11
cmake .
make
cd ../abc_py

export PYBIND11_DIR=/source/pybind11
export ABC_DIR=/source/abc
export ARCH_FLAGS=$($ABC_DIR/arch_flags)

mkdir -p build
cd build
cmake ..
make
cd ../..