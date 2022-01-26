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

echo "wavmo "$1"" > wavmo-"$1".txt
echo "-------------------------" >> wavmo-"$1".txt
source invoke.sh "$1" wavmo

# WAMR with Orc JIT (lazy)
cd ~/wasm-micro-runtime/product-mini/platforms/linux
rm -rf build
mkdir build
cd build
cmake .. -DWAMR_BUILD_JIT=1
make -j "${nproc}"
cd ~/spec-configs

echo "wamrl "$1"" > wamrl-"$1".txt
echo "-------------------------" >> wamrl-"$1".txt
source invoke.sh "$1" wamrl

# WAMR with MC JIT (AOT)
cd ~/wasm-micro-runtime/product-mini/platforms/linux
rm -rf build
mkdir build
cd build
cmake .. -DWAMR_BUILD_JIT=1 -DWAMR_BUILD_LAZY_JIT=0
make -j "${nproc}"
cd ~/spec-configs

echo "wamr "$1"" > wamr-"$1".txt
echo "-------------------------" >> wamr-"$1".txt
source invoke.sh "$1" wamr

echo "" | mail -s ""$1" benchmark results" -A wavmo-"$1".txt -A wamrl-"$1".txt -A wamr-"$1".txt kimbethstonehouse@gmail.com