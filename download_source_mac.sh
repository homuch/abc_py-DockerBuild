#!/bin/bash

# Check if the "./source" directory exists, if so, remove it
if [ -d "./source" ]; then
    rm -rf "./source"
fi

# Create the "./source" directory
mkdir -p "./source"

# Download pybind11 using curl and unzip it
curl -L https://github.com/pybind/pybind11/archive/refs/tags/v2.12.0.zip -o ./pybind11.zip
unzip ./pybind11.zip -d ./pybind11-tmp
mv ./pybind11-tmp/pybind11* ./source/pybind11
rm -rf ./pybind11-tmp

# Download abc using curl and unzip it
curl -L https://github.com/berkeley-abc/abc/archive/refs/heads/master.zip -o ./abc.zip
unzip ./abc.zip -d ./abc-tmp
mv ./abc-tmp/abc* ./source/abc
rm -rf ./abc-tmp

# Download abc_py using curl and unzip it
curl -L https://github.com/homuch/abc_py/archive/refs/heads/master.zip -o ./abc_py.zip
unzip ./abc_py.zip -d ./abc_py-tmp
mv ./abc_py-tmp/abc_py* ./source/abc_py
rm -rf ./abc_py-tmp

# Remove the downloaded zip files
rm -f ./*.zip