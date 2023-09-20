# RISC-V-based-MYTH
This repository contains the whole summary of hands-on done by Abhinav Prakash (IS22MTECH14002) during the workshop RISC-V based MYTH and understanding the architecture of RISC-V 


## *Table of Contents*

* [Day 1: Introduction to RISC-V ISA and GNU compiler toolchain](#day-1)
    + [Introduction to RISC-V basic Keywords](#Introduction-to-RISC-V-basic-keywords)
    + [Lab of compile and execute the C code in the RISC-V gnu toolchain](#Lab-of-compile-and-execute-the-C-code-in-the-RISC-V-gnu-toolchain)
    + [Lab of signed and unsigned arithmetic operations](#Lab-of-signed-and-unsigned-arithmetic-operations)
    
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

### Lab of compile and execute the C code in the RISC-V gnu toolchain
---
- Writing a C code and running it in a compiler.
  
![image](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/5a30df08-d688-4d6e-9824-15d912d48b80)

- Now we will compile this in a RISC-V gcc compiler using this command (this command is in place of `gcc <filename>.c` in GCC compiler), which will generate `sum1ton.o` file.
```
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
```

- To get the Assembly code of our program, we use this command:

```
riscv64-unknown-elf-objdump -d sum1ton.o
riscv64-unknown-elf-objdump -d sum1ton.o | less
```
- **NOTE** -To view the address of the subroutine (line main() or printf()) type `/main` (if main()) or `/printf`(if printf()). To quit type `:q`. 
- This assembly code is generated in RISC-V architecture for the main function (having address 10184), which is byte addressable and takes 15 instructions to execute the main function [(101c0-10184)/4 = f]
  
![image](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/ba6fb5a7-acd2-4f34-b242-312b2a910374)


- Now, instead of using `-O1` if we use `-Ofast`, it uses only 12 instructions [(101e0-101b0)/4 = c] to execute the same program.

```
riscv64-unknown-elf-gcc -ofast -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
```
![image](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/ed747e68-3d52-4fd9-a71b-5e138963b1ce)


- Now, to debug the assembly code, we use the following commands.
```
spike pk sum1ton.o       //this command is in place of `./a.out` in the GCC compiler, which gives the same answer as in the GCC compiler
spike -d pk sum1ton.o    // to open a debugger
until pc 0 100b0         // to run PC until the address of the main function
reg 0 a2                 // command to find the content of the content of register a2
reg 0 sp                 // command to find the content of the stack pointer
reg <core_no> <register name> // command to find the content of register

```
![Screenshot (2711)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/0ded7e0b-09d2-43d3-be6f-ed0a4a7ba407)


#### Explanation of the commands :

- **-O1/-Ofast** - This flag specifies the optimization level to be used during compilation. In this case, the level is set to 1, which represents a basic level of optimization. Higher optimization levels (like -O2 or -O3) can potentially result in more optimized and faster code, but they might also increase compilation time.-Ofast is an optimization level flag used in GCC (GNU Compiler Collection) to enable aggressive optimizations that go beyond the optimizations performed by -O3.

- **-mabi=lp64** - Specify integer and floating-point calling convention. ABI-string contains two parts: the size of integer types and the registers used for floating-point types. "lp64" ABI stands for "Long and Pointer 64-bit," indicating that long integers and pointers are 64 bits in size.

- **-march=rv64i** - Generate code for given RISC-V ISA. ISA strings must be lower-case. Examples include ‘rv64i’, ‘rv32g’, ‘rv32e’, and ‘rv32imaf’. In this case, "rv64i" specifies a 64-bit RISC-V architecture with the "i" extension, which denotes the base integer instruction set.

- **-o sum1ton_O1.o** - This flag indicates the name of the output file after compilation. In this case, the compiled code will be saved as "sum1ton_O1.o".

- **sum1ton.c** - This is the source code file that you want to compile. In this case, it's named "sum1ton.c".

- **riscv64-unknown-elf-objdump** - This is the command-line utility used for examining the contents of object files, executables, and libraries. It can provide information about the disassembled machine code, symbol tables, and more.

- **-d**  This flag specifies that the disassembly mode should be used. In other words, you are requesting to see the disassembled machine code instructions corresponding to the binary content in the object file.

- **sum1ton_O1.o** - This is the object file that you want to disassemble. It contains the compiled machine code generated from the "sum1ton.c" source code file using the specified compiler options.

- **spike** - Spike is a RISC-V ISA simulator that emulates the behavior of a RISC-V processor. It's used to run RISC-V binary programs on a host machine, simulating how those programs would execute on actual RISC-V hardware.

- **pk** - The "proxy kernel" (pk) is a small user-mode runtime environment that provides a basic set of functionalities needed to execute programs in the Spike simulator. It serves as a minimal operating system interface for the simulated environment. The proxy kernel handles basic interactions with the simulated environment, such as managing memory, handling system calls, and providing essential runtime support.

- **-d (in spike command)** - indicates spike in debug mode. Debug mode enables you to closely monitor and interact with the simulated program's execution, making it useful for analyzing code behavior, identifying issues, and stepping through instructions.

- **until pc 0 10184** - continue executing the program until the program counter reaches address 10184.

- **reg 0 sp** - Inquire about the value stored in register., in this case it is stack pointer (sp)

### Lab of signed and unsigned arithmetic operations
---
#### Unsigned
- Consider the C code, demonstrating the maximum unsigned number the RV64I can store.

- To compile and execute the C code in the RISC-V gnu toolchain, use these commands
```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o unsigned.o unsigned.c 
spike  pk unsigned.o
```
![Screenshot (2712)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/9f469ff4-8a0b-44c8-8966-d4310ed7d34c)

- Line 1 will execute and give the result of (2^64)-1.
- Line 2 will execute and give the result of (2^64)-1 instead of (2^127)-1 since the maximum unsigned value that can be stored in the 64 bit register is (2^64)-1.
- Line 3 will execute and give the result of 0 instead of -(2^64) since the minimum unsigned value that can be stored in the 64-bit register is 0.
- Line 4 will execute and give the result of 0 instead of (2^64)-1.
- Line 5 will execute and give the result of 0 instead of -(2^64) since the minimum unsigned value that can be stored in the 64-bit register is 0.
- Line 6 will execute and give the result of 1024 since the value of max is less than (2^64)-1.

#### Signed
- Consider the C code, demonstrating the maximum and minimum signed number the RV64I can store.


- To compile and execute the C code in the RISC-V gnu toolchain, use these commands
```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o signed.o signed.c 
spike  pk signed.o
```
![Screenshot (2713)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/f357b7c9-1b10-42c2-9a61-67e0d9e1deae)

## Day 2:
## Introduction to ABI and basic verification flow
---
### Application Binary interface (ABI)
---
![Screenshot (2716)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/0b1e2429-1103-4dfc-b263-1947cc521a69)




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
- [RISC-V Commands](https://gcc.gnu.org/onlinedocs/gcc/RISC-V-Options.html)
- [RISC-V Installation](https://github.com/kunalg123/riscv_workshop_collaterals/blob/master/run.sh)



## Acknowledgement
---
Finally, I would like to express my sincere gratitude to [Kunal Ghosh](https://www.linkedin.com/in/kunal-ghosh-vlsisystemdesign-com-28084836/){Co-founder of VLSI System Design (VSD) Corp. Pvt. Ltd.} for help me in understanding the RISC-V architecture. The workshop was excellent and well-designed, this workshop taught me a lot of new things about the design RISC-V

## Accreditation
---

## Inquiries
---
- Connect with me at [LinkedIn](https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile)

