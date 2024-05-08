#!/bin/bash

cd abc 
make ABC_USE_NO_READLINE=1 ABC_USE_PIC=1 libabc.a
export ABC_DIR=$(pwd)
export ARCH_FLAGS=$($ABC_DIR/arch_flags)
cd ..