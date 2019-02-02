#/blin/bash
#Author Name: Lewis Lam
#Program Name: Integer IO
#Assignment Number: 1

rm *.o
rm *.out

echo "This is program <Integer IO>"

echo "Assemble the module Integer IO.asm"
nasm -f elf64 -l intIO.lis -o intIO.o integerIO.asm

echo "Compile the C module IntegerIO.c"
gcc -c -m64 -Wall -l intIODriver.lis -o intIODriver.o integerIO.c -fno-pie -no-pie

echo "Link the two object files already created"
gcc -m64 -o intIO.out intIODriver.o intIO.o -fno-pie -no-pie

echo "The bash script file is now closing"
