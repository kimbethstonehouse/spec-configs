#!/bin/bash

# Working directory is spec-configs
cp test.cfg ~/cpu2017/config
cd ~/cpu2017
source shrc
runcpu --action runsetup --config test --size "$1" --copies 1 --noreportable --iterations 1 fprate
runcpu --action runsetup --config test --size "$1" --copies 1 --noreportable --iterations 1 intrate

# Unmodified WAVM
cd ~/wavmo
rm -rf build
mkdir build
cd build
cmake ..
make
cd ~/spec-configs

echo "wavmo "$1"" > wavmo-"$1".out
echo "-------------------------" >> wavmo-"$1".out
source invoke.sh "$1" wavmo

# WAMR with Orc JIT (lazy)
cd ~/wasm-micro-runtime/product-mini/platforms/linux
rm -rf build
mkdir build
cd build
cmake .. -DWAMR_BUILD_JIT=1
make -j "${nproc}"
cd ~/spec-configs

echo "wamrl "$1"" > wamrl-"$1".out
echo "-------------------------" >> wamrl-"$1".out
source invoke.sh "$1" wamrl

# WAMR with MC JIT (AOT)
cd ~/wasm-micro-runtime/product-mini/platforms/linux
rm -rf build
mkdir build
cd build
cmake .. -DWAMR_BUILD_JIT=1 -DWAMR_BUILD_LAZY_JIT=0
make -j "${nproc}"
cd ~/spec-configs

echo "wamr "$1"" > wamr-"$1".out
echo "-------------------------" >> wamr-"$1".out
source invoke.sh "$1" wamr