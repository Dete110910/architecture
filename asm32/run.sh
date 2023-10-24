#/!bin/bash
echo "Write the files name (without extension)"
read fileName

nasm -f elf32 $fileName.asm -o $fileName.o
ld -m elf_i386 $fileName.o -o $fileName

./$fileName
