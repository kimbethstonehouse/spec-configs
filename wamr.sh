#!/bin/bash

echo '#!/bin/bash' > run.sh
echo '#!/bin/bash' > check.sh

specinvoke -n | grep '\.\./' | sed 's/\.\.\//wamr --dir=. \.\.\//g' >> run.sh
specinvoke -n compare.cmd | grep specdiff >> check.sh
specinvoke -n compare.cmd | grep -o "> .*.cmp" | sed 's/>/cat/g' >> check.sh 

chmod +x run.sh
chmod +x check.sh

{ time source ./run.sh; } |& grep "real" >> ~/spec-configs/wamr-"$1".out
{ time source ./run.sh; } |& grep "real" >> ~/spec-configs/wamr-"$1".out
{ time source ./run.sh; } |& grep "real" >> ~/spec-configs/wamr-"$1".out
./check.sh | grep -v "specdiff run completed" >> ~/spec-configs/wamr-"$1".out
echo "-------------------------" >> ~/spec-configs/wamr-"$1".out