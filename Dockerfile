FROM gcc:latest as builder
WORKDIR /source

RUN apt-get update && apt-get install -y make cmake libboost-all-dev doxygen

COPY source/install_abc.sh /source/install_abc.sh
COPY source/abc /source/abc
RUN chmod a+x install_abc.sh && ./install_abc.sh

COPY source/install_pybind11.sh /source/install_pybind11.sh
COPY source/pybind11 /source/pybind11
RUN chmod a+x install_pybind11.sh && ./install_pybind11.sh

COPY source/abc_py /source/abc_py
RUN cd abc_py && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cd /source && \
    rm *.sh

FROM python:3.12.3-slim
COPY --from=builder /source/ /usr/src
WORKDIR /usr/src
RUN echo "\
export PYBIND11_DIR=/usr/src/pybind11 \
export ABC_DIR=/usr/src/abc \
export ARCH_FLAGS=$($ABC_DIR/arch_flags)" >> ~/.bashrc
RUN source ~/.bashrc
RUN pip install abc_py/

CMD ["/bin/bash"]

