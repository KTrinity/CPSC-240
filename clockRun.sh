#Author Name: Lewis Lam
#Program Name: Clock
#Names of files in this program: clockDriver.cpp, clockControl.asm, clockRun.sh
#Course Number: CPSC 240
#Assignment Number: 4
#Scheduled delivery date: April 23, 2019
#Status: Complete
#Date of last modification: April 19, 2019

#Information about this module:
#This module purpose: Bash module for Clock
#File name of this module: clockRun.sh
#Compile this module: chmod +x clockRun.sh
#Link this module with other objects: N/A
#Execute: ./clockRun.sh
#/bin/bash

rm *.o
rm *.out

echo "This is program <Clock>"

echo "Compile C++ module clockDriver.cpp"
g++ -c -m64 -std=c++98 -o clockDriver.o clockDriver.cpp -fno-pie -no-pie

echo "Assemble the module clockControl.asm"
nasm -f elf64 -l array.lis -o clockControl.o clockControl.asm

echo "Link the 2 object files already created"
g++ -m64 -std=c++98 -o clock.out clockControl.o clockDriver.o -fno-pie -no-pie

echo "The bash script file is now closing."
