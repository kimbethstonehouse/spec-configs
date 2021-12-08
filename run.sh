#!/bin/bash

echo '#!/bin/bash' > run-wavm.sh
echo '#!/bin/bash' > check-output.sh

specinvoke -n | grep '\.\./' | sed 's/\.\.\//wavm run --mount-root . \.\.\//g' >> run-wavm.sh
specinvoke -n compare.cmd | grep specdiff >> check-output.sh
specinvoke -n compare.cmd | grep -o "> .*.cmp" | sed 's/>/cat/g' >> check-output.sh 

chmod +x run-wavm.sh
chmod +x check-output.sh

echo "Time for wavm: "
time source ./run-wavm.sh
time source ./run-wavm.sh
time source ./run-wavm.sh
./check-output.sh