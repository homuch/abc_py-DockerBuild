FROM python:3.12.3-slim as base
RUN apt-get update && apt-get install -y make cmake gcc g++

FROM base as builder-abc
WORKDIR /usr/src/abc
COPY ./source/abc /usr/src/abc
RUN make ABC_USE_NO_READLINE=1 ABC_USE_PIC=1 libabc.a

FROM base as builder-pybind11
WORKDIR /usr/src/pybind11
COPY ./source/pybind11 /usr/src/pybind11
RUN cmake .
RUN make 
# RUN make install

FROM base as builder-abc_py
RUN apt-get install -y libboost-all-dev doxygen

SHELL ["/bin/bash", "-c"]

RUN echo $'\n\
export PYBIND11_DIR=/usr/src/pybind11 \n\
export ABC_DIR=/usr/src/abc \n\
export ARCH_FLAGS=$(/usr/src/abc/arch_flags)' >> ~/.bashrc

# WORKDIR /usr/src/pybind11
# COPY ./source/pybind11 /usr/src/pybind11
# RUN cmake .
# RUN make 
# RUN make install

WORKDIR /usr/src/abc_py
COPY --from=builder-abc /usr/src/abc /usr/src/abc
COPY --from=builder-pybind11 /usr/src/pybind11 /usr/src/pybind11
COPY ./source/abc_py /usr/src/abc_py
RUN . ~/.bashrc && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

WORKDIR /usr/src
RUN python3 -m venv /abc_py-venv && \
    . ~/.bashrc && \
    /abc_py-venv/bin/pip install abc_py/
# RUN apt-get remove -y make cmake gcc g++ libboost-all-dev doxygen
# RUN apt-get autoremove -y

FROM python:3.12.3-slim
COPY --from=builder-abc_py /abc_py-venv /abc_py-venv
ENV PATH="/abc_py-venv/bin:$PATH"
WORKDIR /root
CMD ["/bin/bash"]

