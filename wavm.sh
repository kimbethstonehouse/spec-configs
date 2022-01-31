#!/bin/bash

SIZE = "$1"

echo '#!/bin/bash' > run.sh
echo '#!/bin/bash' > check.sh

specinvoke -n | grep '\.\./' | sed 's/\.\.\//wavm run --mount-root . \.\.\//g' >> run.sh
specinvoke -n compare.cmd | grep specdiff >> check.sh
specinvoke -n compare.cmd | grep -o "> .*.cmp" | sed 's/>/cat/g' >> check.sh 

chmod +x run.sh
chmod +x check.sh

{ time source ./run.sh; } |& grep "real" >> ~/spec-configs/wavm-"$SIZE".txt
{ time source ./run.sh; } |& grep "real" >> ~/spec-configs/wavm-"$SIZE".txt
{ time source ./run.sh; } |& grep "real" >> ~/spec-configs/wavm-"$SIZE".txt
./check.sh | grep -v "specdiff run completed" >> ~/spec-configs/wavm-"$SIZE".txt
echo "-------------------------" >> ~/spec-configs/wavm-"$SIZE".txt