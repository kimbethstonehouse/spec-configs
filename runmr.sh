#!/bin/bash

echo '#!/bin/bash' > run-wamr.sh
echo '#!/bin/bash' > check-output.sh

specinvoke -n | grep '\.\./' | sed 's/\.\.\//wamr --dir=. \.\.\//g' >> run-wamr.sh
specinvoke -n compare.cmd | grep specdiff >> check-output.sh
specinvoke -n compare.cmd | grep -o "> .*.cmp" | sed 's/>/cat/g' >> check-output.sh 

chmod +x run-wamr.sh
chmod +x check-output.sh

echo "Time for wamr: "
time source ./run-wamr.sh
time source ./run-wamr.sh
time source ./run-wamr.sh
./check-output.sh
