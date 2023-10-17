#!/bin/bash

echo "Type file name (without ext)"

read fileName

nasm -felf64 $fileName.asm -o $fileName.o
ld -o $fileName $fileName.o
./$fileName

