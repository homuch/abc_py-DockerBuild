#!/bin/bash

if [ -d "./source" ]; then
    rm -rf "./source"
fi

mkdir -p "./source"

wget -O ./pybind11.zip https://github.com/pybind/pybind11/archive/refs/tags/v2.12.0.zip

unzip ./pybind11.zip -d ./pybind11-tmp
mv ./pybind11-tmp/pybind11* ./source/pybind11
rm -rf ./pybind11-tmp

wget -O ./abc.zip https://github.com/berkeley-abc/abc/archive/refs/heads/master.zip

unzip ./abc.zip -d ./abc-tmp
mv ./abc-tmp/abc* ./source/abc
rm -rf ./abc-tmp

wget -O ./abc_py.zip https://github.com/homuch/abc_py/archive/refs/heads/master.zip

unzip ./abc_py.zip -d ./abc_py-tmp
mv ./abc_py-tmp/abc_py* ./source/abc_py
rm -rf ./abc_py-tmp

rm -f ./*.zip
