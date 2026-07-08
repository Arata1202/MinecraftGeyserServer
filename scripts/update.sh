#!/bin/bash

cp ./jar/Paper.jar ./
for file in ./jar/*.jar; do
    if [[ $(basename "$file") != "Paper.jar" ]]; then
        cp "$file" ./plugins/
    fi
done
