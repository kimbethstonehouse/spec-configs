#!/bin/bash
TIME_COMPILATION="$1"

# Build unmodified WAVM
cd ~/wavmo && rm -rf build
mkdir build && cd build
cmake .. && make

# Build WAMR with Orc JIT (lazy)
cd ~/wasm-micro-runtime-lazy/product-mini/platforms/linux/
./build_jit.sh

# Build WAMR with MC JIT (AOT)
cd ~/wasm-micro-runtime/product-mini/platforms/linux/
./build_jit.sh

# Make sure we're running with the updated config
cp ~/spec-configs/test.cfg ~/cpu2017/config
cd ~/cpu2017
source shrc

for SIZE in test train refrate
do
    # Ask runcpu to set up the run directories
    runcpu --action runsetup --config test --size "$SIZE" --copies 1 --noreportable --iterations 1 fprate
    runcpu --action runsetup --config test --size "$SIZE" --copies 1 --noreportable --iterations 1 intrate

    # Copy the run script into the run directories
    cp ~/spec-configs/run-benchmark.sh ~/cpu2017/benchspec/CPU/999.specrand_ir/run/run_base_"$SIZE"_mytest-m32.0000
    cp ~/spec-configs/run-benchmark.sh ~/cpu2017/benchspec/CPU/505.mcf_r/run/run_base_"$SIZE"_mytest-m32.0000
    cp ~/spec-configs/run-benchmark.sh ~/cpu2017/benchspec/CPU/557.xz_r/run/run_base_"$SIZE"_mytest-m32.0000
    cp ~/spec-configs/run-benchmark.sh ~/cpu2017/benchspec/CPU/997.specrand_fr/run/run_base_"$SIZE"_mytest-m32.0000
    cp ~/spec-configs/run-benchmark.sh ~/cpu2017/benchspec/CPU/519.lbm_r/run/run_base_"$SIZE"_mytest-m32.0000
    cp ~/spec-configs/run-benchmark.sh ~/cpu2017/benchspec/CPU/508.namd_r/run/run_base_"$SIZE"_mytest-m32.0000

    # Run the benchmarks for each runtime
    for RUNTIME in wavmo wamrl wamr
    do
        echo "$RUNTIME "$SIZE"" > ~/spec-configs/"$RUNTIME"-"$SIZE".txt
        echo "-------------------------" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
    done

    for BENCHMARK in 999.specrand_ir 505.mcf_r 557.xz_r 997.specrand_fr 519.lbm_r 508.namd_r
    do
        cd ~/cpu2017/benchspec/CPU/"$BENCHMARK"/run/run_base_"$SIZE"_mytest-m32.0000
        for RUNTIME in wavmo wamrl wamr
        do
            echo "$BENCHMARK" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
            source run-benchmark.sh "$SIZE" "$RUNTIME" "$TIME_COMPILATION"
            echo "-------------------------" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
        done
    done

    # Email the results
    echo "" | mail -s ""$SIZE" benchmark results" -A ~/spec-configs/wavmo-"$SIZE".txt -A ~/spec-configs/wamrl-"$SIZE".txt -A ~/spec-configs/wamr-"$SIZE".txt kimbethstonehouse@gmail.com
done