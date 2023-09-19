# RISC-V-based-MYTH
This repository contains the whole summary of hands-on done by Abhinav Prakash (IS22MTECH14002) during the workshop RISC-V based MYTH and understanding the architecture of RISC-V 


## *Table of Contents*

* [Day 1: Introduction to RISC-V ISA and GNU compiler toolchain](#day-1)
    + [Introduction to RISC-V basic Keywords](#Introduction-to-RISC-V-basic-keywords)
    + [Signed and unsigned arithmetic operations](#Signed-and-unsigned-arithmetic-operations)
    
* [Day 2: Introduction to ABI and basic verification flow](#day-2)
    + [Application Binary interface (ABI)](#Application-Binary-interface-(ABI))
 
* [Day 3 - Digital Logic with TL-Verilog and Makerchip](#day-3)
    + [Combinational logic in TL-Verilog using Makerchip](#Combinational-logic-in-TL-Verilog-using-Makerchip)
      
* [Day 4 - Basic RISC-V CPU micro-architecture](#day-4)
    + [Microarchitecture and testbench for a simple RISC-V CPU](#Microarchitecture-and-testbench-for-a-simple-RISC-V-CPU)
    
* [DAY 5: Complete Pipelined RISC-V CPU micro-architecture/store](#Day-5)
    + [Pipelining the CPU](#Pipelining-the-CPU)




* [All commands of linux](#All-commands-of-linux)
* [Appendix](#Appendix)
* [References](#references)
* [Acknowledgement](#acknowledgement)
* [Accreditation](#Accreditation)
* [Inquiries](#inquiries)


## Day 1:
## Introduction to RISC-V ISA and GNU compiler toolchain
---
### Introduction to RISC-V basic Keywords
---

1. **Pseudo Instruction:** A mnemonic or symbolic representation used in assembly language programming that simplifies coding but is translated into one or more actual machine instructions by the assembler.

2. **Base Integer Instruction (RV32I):** The fundamental set of instructions in the RISC-V architecture is designed for 32-bit integer operations, forming the core of RISC-V instruction sets.

3. **Multiply Extension (RV32M):** An optional extension to the RISC-V architecture that adds hardware support for integer multiplication operations, enhancing computational capabilities.

4. **Single and Double precision floating point extensions (RV64F and RV64D):** Extensions to the RISC-V architecture that provide support for single-precision (RV64F) and double-precision (RV64D) floating-point arithmetic operations, enabling efficient handling of real numbers.

5. **Application Binary Interface (ABI):** A set of conventions and rules that govern the interaction between different software components, defining aspects such as function calling conventions, data representation, and system call interfaces.

6. **Memory allocation and stack pointer:** Memory allocation refers to reserving and managing memory space for variables and data structures. In contrast, a stack pointer is a register or memory location that keeps track of the top of the call stack, facilitating function calls and local variable storage in a program.

### Lab 1
- Writing a C code and running it in a compiler.
  
![image](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/5a30df08-d688-4d6e-9824-15d912d48b80)

- Now we will compile this in a RISC-V gcc compiler using this command (this command is in place of `gcc <filename>.c` in GCC compiler), which will generate `sum1ton.o` file.
```
riscv64-unknown-elf-gcc -o1 -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
``` 
- To get the Assembly code of our program, we use this command:

```
riscv64-unknown-elf-objdump -d sum1ton.o
riscv64-unknown-elf-objdump -d sum1ton.o | less
```
- This assembly code is generated in RISC-V architecture for the main function (having address 10184), which is byte addressable and takes 34 instructions to execute the main function [(1020c-10184)/4 = 22]

![image](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/199f8c69-b8d7-4d88-9fff-55ea172201b7)

- Now, instead of using `-o1` if we use `-ofast` it uses fewer instructions to execute the same program.

```
riscv64-unknown-elf-gcc -ofast -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
``` 

- Now, to debug the assembly code, we use the following commands.
```
spike pk sum1ton.o       //this command is in place of `./a.out` in GCC compiler, which gives the same answer as in the GCC compiler
spike -d pk sum1ton.o    // to open a debugger
until pc 0 10184         // to run PC until the address of the main function
reg 0 sp                 // command to find the content of the stack pointer
reg <core_no> <register name> // command to find the content of register

```
![Screenshot (2708)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/bf17be16-b4ad-450b-9be4-68bd491edfbe)

### Signed and unsigned arithmetic operations
---



## Day 2:
## Introduction to ABI and basic verification flow
---
### Application Binary interface (ABI)
---




## Day 3:
## Digital Logic with TL-Verilog and Makerchip
---
### Combinational logic in TL-Verilog using Makerchip
---






## Day 4:
## Basic RISC-V CPU micro-architecture
---
### Microarchitecture and testbench for a simple RISC-V CPU

---






## Day 5:
## Complete Pipelined RISC-V CPU micro-architecture/store
---
### Pipelining the CPU

---














## All commands of linux
---
- `leafpad <file_name>.c` Command to make a c file in leafpad.
- To run the .c file use `gcc <filename>.c`(if there are no errors in the code we will get an executable file with the default name a.out) then run this executable by executing `./a.out'.
- `cat <filename>.c` is used to display the contents of a file with a .c extension in the terminal
- `| less` combination is commonly used to paginate and view long text output one screen at a time.

## Appendix
---
- 
## References
---
- [RISC-V based MYTH](https://www.vlsisystemdesign.com/riscv-based-myth/?awt_a=5L_6&awt_l=H2Nw0&awt_m=3l0nDqaoscA8._6)



## Acknowledgement
---
Finally, I would like to express my sincere gratitude to [Kunal Ghosh](https://www.linkedin.com/in/kunal-ghosh-vlsisystemdesign-com-28084836/){Co-founder of VLSI System Design (VSD) Corp. Pvt. Ltd.} for help me in understanding the RISC-V architecture. The workshop was excellent and well-designed, this workshop taught me a lot of new things about the design RISC-V

## Accreditation
---

## Inquiries
---
- Connect with me at [LinkedIn](https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile)

