#Author Name: Lewis Lam
#Program Name: Final Exam Part 2
#Scheduled delivery date: May 6, 2019

#/bin/bash

rm *.o
rm *.out

echo "This is program <ECP>"

echo "Compile C++ module ecpDriver.cpp"
g++ -c -m64 -std=c++98 -o ecpDriver.o ecpDriver.cpp -fno-pie -no-pie

echo "Assemble the module ecpControl.asm"
nasm -f elf64 -l array.lis -o ecpControl.o ecpControl.asm

echo "Link the 2 object files already created"
g++ -m64 -std=c++98 -o ecp.out ecpControl.o ecpDriver.o -fno-pie -no-pie

echo "The bash script file is now closing."
