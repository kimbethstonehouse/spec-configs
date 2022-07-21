#!/bin/bash

echo '#!/bin/bash' > run-wavmo.sh
echo '#!/bin/bash' > check-output.sh

specinvoke -n | grep '\.\./' | sed 's/\.\.\//wavmo run --mount-root . \.\.\//g' >> run-wavmo.sh
specinvoke -n compare.cmd | grep specdiff >> check-output.sh
specinvoke -n compare.cmd | grep -o "> .*.cmp" | sed 's/>/cat/g' >> check-output.sh 

chmod +x run-wavmo.sh
chmod +x check-output.sh

echo "Time for wavmo: " 
time source ./run-wavmo.sh
time source ./run-wavmo.sh
time source ./run-wavmo.sh
./check-output.sh