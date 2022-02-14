#!/bin/bash

SIZE="$1"
RUNTIME="$2"
TIME_COMPILATION="$3"

echo '#!/bin/bash' > specinvoke.sh

if [ "$RUNTIME" == "wavm" ] || [ "$RUNTIME" == "wavmo" ]
then
    specinvoke -n | grep '\.\./' | sed "s/\.\.\//"$RUNTIME" run "$TIME_COMPILATION" --mount-root . \.\.\//g" >> specinvoke.sh
else
    specinvoke -n | grep '\.\./' | sed "s/\.\.\//"$RUNTIME" "$TIME_COMPILATION" --dir=. \.\.\//g" >> specinvoke.sh
fi

chmod +x specinvoke.sh

if [ -z "$TIME_COMPILATION" ]
then
    echo '#!/bin/bash' > specdiff.sh
    specinvoke -n compare.cmd | grep specdiff >> specdiff.sh
    specinvoke -n compare.cmd | grep -o "> .*.cmp" | sed 's/>/cat/g' >> specdiff.sh
    chmod +x specdiff.sh
else
    specinvoke -n | grep -o "> .*.out" | sed 's/> //g' > specdiff.sh
fi

for x in 1 2 3
do
    { time -p source ./specinvoke.sh; } |& grep "real" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
    if [ -z "$TIME_COMPILATION" ]
    then
        ./specdiff.sh | grep -v "specdiff run completed" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
    else
        COMPILE_TIME=0
        RUN_TIME=0

        while read -r LINE
        do 
            if cat "$LINE" | grep -q "Compile time: "
            then
                COMPILE_TIME=$(echo "$COMPILE_TIME" $(cat "$LINE" | grep "Compile time: " | sed "s/Compile time: //g" | sed "s/ s//g") | awk '{print $1 + $2}')
            fi

            if cat $LINE | grep -q "Run time: "
            then
                RUN_TIME=$(echo "$RUN_TIME" $(cat "$LINE" | grep "Run time: " | sed "s/Run time: //g" | sed "s/ s//g") | awk '{print $1 + $2}')
            fi
        done < specdiff.sh

        echo "compile	"$COMPILE_TIME"s" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
        echo "run	"$RUN_TIME"s" >> ~/spec-configs/"$RUNTIME"-"$SIZE".txt
    fi
done