#Author Name: Lewis Lam
#Program Name: Electric Circuit Processing
#Names of files in this program: ecpDriver.cpp, ecpControl.asm, ecpRun.sh
#Course Number: CPSC 240
#Assignment Number: 5
#Scheduled delivery date: April 23, 2019
#Status: Incomplete
#Date of last modification: April 29, 2019

#Information about this module:
#This module purpose: Bash module for ECP
#File name of this module: ecpRun.sh
#Compile this module: chmod +x ecpRun.sh
#Link this module with other objects: N/A
#Execute: ./ecpRun.sh
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

echo "Run the ECP Program"
./ecp.out
# change to ./ecp.out < $1 if you want to read from a file

echo "The bash script file is now closing."
