#!/bin/bash

cp ~/spec-configs/"$2".sh ~/cpu2017/benchspec/CPU/999.specrand_ir/run/run_base_"$1"_mytest-m32.0000
cp ~/spec-configs/"$2".sh ~/cpu2017/benchspec/CPU/505.mcf_r/run/run_base_"$1"_mytest-m32.0000
cp ~/spec-configs/"$2".sh ~/cpu2017/benchspec/CPU/557.xz_r/run/run_base_"$1"_mytest-m32.0000
cp ~/spec-configs/"$2".sh ~/cpu2017/benchspec/CPU/997.specrand_fr/run/run_base_"$1"_mytest-m32.0000
cp ~/spec-configs/"$2".sh ~/cpu2017/benchspec/CPU/519.lbm_r/run/run_base_"$1"_mytest-m32.0000
cp ~/spec-configs/"$2".sh ~/cpu2017/benchspec/CPU/508.namd_r/run/run_base_"$1"_mytest-m32.0000

cd ~/cpu2017/benchspec/CPU/999.specrand_ir/run/run_base_"$1"_mytest-m32.0000
echo "999.specrand_ir" >> ~/spec-configs/"$2"-"$1".txt
source "$2".sh "$1"

cd ../../../505.mcf_r/run/run_base_"$1"_mytest-m32.0000
echo "505.mcf_r" >> ~/spec-configs/"$2"-"$1".txt
source "$2".sh "$1"

cd ../../../557.xz_r/run/run_base_"$1"_mytest-m32.0000
echo "557.xz_r" >> ~/spec-configs/"$2"-"$1".txt
source "$2".sh "$1"

cd ../../../997.specrand_fr/run/run_base_"$1"_mytest-m32.0000
echo "997.specrand_fr" >> ~/spec-configs/"$2"-"$1".txt
source "$2".sh "$1"

cd ../../../519.lbm_r/run/run_base_"$1"_mytest-m32.0000
echo "519.lbm_r" >> ~/spec-configs/"$2"-"$1".txt
source "$2".sh "$1"

cd ../../../508.namd_r/run/run_base_"$1"_mytest-m32.0000
echo "508.namd_r" >> ~/spec-configs/"$2"-"$1".txt
source "$2".sh "$1"
