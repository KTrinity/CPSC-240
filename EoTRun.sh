#Author name: Lewis Lam
#Program name: End of Transmission
#Names of files in this programming: EoTDriver.cpp, EoT.asm, EoTRun.sh
#Course number: CPSC 240
#Assignment Number: 2
#Scheduled delivery date: February 18, 2019
#Status: In Progress
#Date of last modification: Feb 7, 2019
#Information about this module:
#This module purpose: Bash file to provide instruction on how to compile each file and link their respective objects into an executable file
#File name of this module: EoTRun.sh
#Compile this module: N/A
#Link this module with other objects: N/A
#Execute: ./EoT.out
#/bin/bash

rm *.o
rm *.out

echo "This is program <End of Transmission>"
nasm -f elf64 -l EoT.lis -o EoT.o EoT.asm

echo "Compile the C++ module EoT.cpp"
g++ -c -m64 -std=c++98 -o EoTDriver.o EoTDriver.cpp

echo "Link the two object files already created"
g++ -m64 -std=c++98 -o EoT.out EoTDriver.o EoT.o

echo "The bash script file is now closing"
