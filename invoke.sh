#!/bin/bash

SIZE = "$1"
RUNTIME = "$2"

cp ~/spec-configs/"$RUNTIME".sh ~/cpu2017/benchspec/CPU/999.specrand_ir/run/run_base_"$SIZE"_mytest-m32.0000
cp ~/spec-configs/"$RUNTIME".sh ~/cpu2017/benchspec/CPU/505.mcf_r/run/run_base_"$SIZE"_mytest-m32.0000
cp ~/spec-configs/"$RUNTIME".sh ~/cpu2017/benchspec/CPU/557.xz_r/run/run_base_"$SIZE"_mytest-m32.0000
cp ~/spec-configs/"$RUNTIME".sh ~/cpu2017/benchspec/CPU/997.specrand_fr/run/run_base_"$SIZE"_mytest-m32.0000
cp ~/spec-configs/"$RUNTIME".sh ~/cpu2017/benchspec/CPU/519.lbm_r/run/run_base_"$SIZE"_mytest-m32.0000
cp ~/spec-configs/"$RUNTIME".sh ~/cpu2017/benchspec/CPU/508.namd_r/run/run_base_"$SIZE"_mytest-m32.0000

cd ~/cpu2017/benchspec/CPU/999.specrand_ir/run/run_base_"$SIZE"_mytest-m32.0000
echo "999.specrand_ir" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
source "$RUNTIME".sh "$SIZE"

cd ../../../505.mcf_r/run/run_base_"$SIZE"_mytest-m32.0000
echo "505.mcf_r" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
source "$RUNTIME".sh "$SIZE"

cd ../../../557.xz_r/run/run_base_"$SIZE"_mytest-m32.0000
echo "557.xz_r" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
source "$RUNTIME".sh "$SIZE"

cd ../../../997.specrand_fr/run/run_base_"$SIZE"_mytest-m32.0000
echo "997.specrand_fr" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
source "$RUNTIME".sh "$SIZE"

cd ../../../519.lbm_r/run/run_base_"$SIZE"_mytest-m32.0000
echo "519.lbm_r" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
source "$RUNTIME".sh "$SIZE"

cd ../../../508.namd_r/run/run_base_"$SIZE"_mytest-m32.0000
echo "508.namd_r" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
source "$RUNTIME".sh "$SIZE"
