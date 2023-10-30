#!/bin/bash

echo "Type file name (without extension)"
read fileName
echo "Type mode (64,32,16,8)"
read mode


nasm -felf$mode $fileName.asm -o debug$fileName.o
ld -o $fileName debug$fileName.o

#./$fileName

gdb $fileName


