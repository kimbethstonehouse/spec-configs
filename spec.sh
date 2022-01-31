#!/bin/bash

SIZE = "$1"

# Working directory is spec-configs
cp test.cfg ~/cpu2017/config
cd ~/cpu2017
source shrc
runcpu --action runsetup --config test --size "$SIZE" --copies 1 --noreportable --iterations 1 fprate
runcpu --action runsetup --config test --size "$SIZE" --copies 1 --noreportable --iterations 1 intrate

# Unmodified WAVM
cd ~/wavmo
rm -rf build
mkdir build
cd build
cmake ..
make
cd ~/spec-configs

echo "wavmo "$SIZE"" > wavmo-"$SIZE".txt
echo "-------------------------" >> wavmo-"$SIZE".txt
source invoke.sh "$SIZE" wavmo

# WAMR with Orc JIT (lazy)
cd ~/wasm-micro-runtime/product-mini/platforms/linux
rm -rf build
mkdir build
cd build
cmake .. -DWAMR_BUILD_JIT=1
make
cd ~/spec-configs

echo "wamrl "$SIZE"" > wamrl-"$SIZE".txt
echo "-------------------------" >> wamrl-"$SIZE".txt
source invoke.sh "$SIZE" wamrl

# WAMR with MC JIT (AOT)
cd ~/wasm-micro-runtime/product-mini/platforms/linux
rm -rf build
mkdir build
cd build
cmake .. -DWAMR_BUILD_JIT=1 -DWAMR_BUILD_LAZY_JIT=0
make
cd ~/spec-configs

echo "wamr "$SIZE"" > wamr-"$SIZE".txt
echo "-------------------------" >> wamr-"$SIZE".txt
source invoke.sh "$SIZE" wamr

echo "" | mail -s ""$SIZE" benchmark results" -A ~/spec-configs/wavmo-"$SIZE".txt -A ~/spec-configs/wamrl-"$SIZE".txt -A ~/spec-configs/wamr-"$SIZE".txt kimbethstonehouse@gmail.com