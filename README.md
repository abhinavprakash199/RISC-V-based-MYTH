# RISC-V-based-MYTH
This repository contains the whole summary of the hands-on work done by Abhinav Prakash (IS22MTECH14002) during the workshop on RISC-V-based MYTH, understanding and coding the piplened RISC-V micro-architecture using TL-Verilog. Understand in detail about machine code, the different ISA of RISC-V, the Instruction Fretch to Write Back process, and coding the optimized architecture. of RICS-V.

## *Table of Contents*

* [Day 1: Introduction to RISC-V ISA and GNU compiler toolchain](#day-1)
    + [Introduction to RISC-V basic Keywords](#Introduction-to-RISC-V-basic-keywords)
    + [Lab of compile and execute the C code in the RISC-V gnu toolchain](#Lab-of-compile-and-execute-the-C-code-in-the-RISC-V-gnu-toolchain)
    + [Lab of signed and unsigned arithmetic operations](#Lab-of-signed-and-unsigned-arithmetic-operations)
    
* [Day 2: Introduction to ABI and basic verification flow](#day-2)
    + [Application Binary interface (ABI)](#Application-Binary-interface-(ABI))
    + [RISC-V instruction set architecture](#RISC-V-instruction-set-architecture)
    + [Lab of using ABI function calls](#Lab-of-using-ABI-function-calls)
    + [Labs of RISC-V Basic Verification flow using iverilog](#Labs-of-RISC-V-Basic-Verification-flow-using-iverilog)
 
* [Day 3 - Digital Logic with TL-Verilog and Makerchip](#day-3)
    + [TL-Verilog and Makerchip IDE](#TL-Verilog-and-Makerchip-IDE)
    + [Lab of Combinational logic in TL-Verilog using Makerchip](#Lab-of-Combinational-logic-in-TL-Verilog-using-Makerchip)
    + [Lab of Sequential logic in TL-Verilog using Makerchip](#Lab-of-Sequential-logic-in-TL-Verilog-using-Makerchip)
    + [Lab of Pipelined Pythagorean](#Lab-of-Pipelined-Pythagorean)
    + [Lab of Counter and 1 Cycle Pipeline Calculator](#Lab-of-Counter-and-1-Cycle-Pipeline-Calculator)
    + [Lab of 2 Cycle Pipeline Calculator](#Lab-of-Counter-and-Pipeline-Calculator)
    + [Validity and Clock Gating](#Validity-and-Clock-Gating)
    + [Lab of Pipelined Pythagorean with validity](#Lab-of-Pipelined-Pythagorean-with-validity)
    + [Lab of Distance Accumulator](#Lab-of-Distance-Accumulator)
    + [Lab of 2 Cycle Pipeline Calculator with Validity](#Lab-of-2-Cycle-Pipeline-Calculator-with-Validity)
    + [Lab of Calculator with Single Value Memory](#Lab-of-Calculator-with-Single-Value-Memory)
          
* [Day 4 - Basic RISC-V CPU micro-architecture](#day-4)
    + [Designing Microarchitecture of simple RISC-V CPU](#Designing-Microarchitecture-of-simple-RISC-V-CPU)
    + [RISC-V CPU Implementation Steps](#RISC-V-CPU-Implementation-Steps)
    	- [1. Next Program Counter(PC) Logic](#1-Next-Program-Counter-Logic)
        - [2. Instruction Fetch Logic](#2-Instruction-Fetch-Logic)
        - [3. Instruction Decode Logic](#3-Instruction-Decode-Logic)
        - [4. Register File Read Logic](#4-Register-File-Read-Logic)
        - [5. Arithmetic Logic Unit Implementation](#5-Arithmetic-Logic-Unit-Implementation)
        - [6. Register File Write Logic](#6-Register-File-Write-Logic)
        - [7. Branch Instruction Logic](#7-Branch-Instruction-Logic)
        - [Testbench](#Testbench)
    + [Final TL Verilog Code of designed RISC-V Architecture](#Final-TL-Verilog-Code-of-designed-RISC-V-Architecture)	

    
* [DAY 5: Complete Pipelined RISC-V CPU micro-architecture/store](#Day-5)
    + [Pipelining the CPU](#Pipelining-the-CPU)
    + [Design of Pipeline 3 instruction per cycle of RISC-V CPU micro-architecture](#Design-of-Pipeline-3-instruction-per-cycle-of-RISC-V-CPU-micro-architecture)
    + [Design of Pipeline 1 instruction per cycle of RISC-V CPU micro-architecture](#Design-of-Pipeline-1-instruction-per-cycle-of-RISC-V-CPU-micro-architecture)
    + [Completing Instruction Decode](#Completing-Instruction-Decode)
    + [Completing ALU Design](#Completing-ALU-Design)
    + [Adding Load/Store Instructions](#Adding-Load/Store-Instructions)
    + [Designing of Data Memory](#Designing-of-Data-Memory)
    + [Adding Jump Instruction](#Adding-Jump-Instruction)
    + [Final Design of Pipelined and Optimized RISC-V CPU micro-architecture](#Final-Design-of-Pipelined-and-Optimized-RISC-V-CPU-micro-architecture)
 
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

- Now we will compile this in a RISC-V gcc compiler using this command (this command is in place of `gcc <filename>.c` in GCC compiler), which will generate a `sum1ton.o` file.
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

- **-o sum1ton.o** - This flag indicates the name of the output file after compilation. In this case, the compiled code will be saved as "sum1ton_O1.o".

- **sum1ton.c** - This is the source code file that we want to compile. In this case, it's named "sum1ton.c".

- **riscv64-unknown-elf-objdump** - This is the command-line utility used for examining the contents of object files, executables, and libraries. It can provide information about the disassembled machine code, symbol tables, and more.

- **-d**  This flag specifies that the disassembly mode should be used. In other words, we request to see the disassembled machine code instructions corresponding to the binary content in the object file.

- **sum1ton.o** - This is the object file we want to disassemble. It contains the compiled machine code generated from the "sum1ton.c" source code file using the specified compiler options.

- **spike** - Spike is a RISC-V ISA simulator that emulates the behavior of a RISC-V processor. It runs RISC-V binary programs on a host machine, simulating how those programs would execute on actual RISC-V hardware.

- **pk** - The "proxy kernel" (pk) is a small user-mode runtime environment that provides a basic set of functionalities needed to execute programs in the Spike simulator. It serves as a minimal operating system interface for the simulated environment. The proxy kernel handles basic interactions with the simulated environment, such as managing memory, handling system calls, and providing essential runtime support.

- **-d (in spike command)** - indicates spike in debug mode. Debug mode enables us to closely monitor and interact with the simulated program's execution, making it useful for analyzing code behavior, identifying issues, and stepping through instructions.

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
<p align="center">
    <img src="![Screenshot (2716)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/b15e04c5-d479-40c9-ad87-cf538bda1f5e"


- A **double word** is twice the size of a word. In RISC-V, for example, in RV32, a double word is 8 bytes (64 bits), whereas a word is 4 bytes (32 bits), and in RV64, a double word is 16 bytes (128 bits), whereas a word is 8 bytes(64 bits).
- An **edianess** refers to how multi-byte data is stored in memory. In a big-endian system, the most significant byte is stored at the lowest memory address, while in a little-endian system, the least significant byte is stored at the lowest memory address. RISC-V supports both big-endian and little-endian modes.
- The **RV32I has 32-bit registers**, and the **RV64I has 64-bit registers**. But both the **RV32I and RV64I have only 32 registers**, and the **size of the instructions is 32 bits only**.

#### Load Instruction 
- Here we load the value of the RISC-V x8 register in the main memory address from 16 to the next 8 byte (total 64-bit data, same as the size of x8, each of size 8bit), and from x23 is the reference main memory register having value 0 to which we will add 16 to go to the desired address.

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/f2e8aea9-45fd-4f05-ac4b-5d35927a3ee6"

#### Add Instruction
- Here, we add 24 and 8 and store the value in the RISC-V x8 register (64-bit for RV64I).

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/62592c13-570d-48c6-92ee-a2736a447bf8"

#### Store Instruction 
- Here, we store the value from the RISC-V x8 register to the main memory address from 8 to the next 8byte (total 64-bit data, same as the size of x8, each of size 8bit), and from x23 is the reference main memory register having value 0 to which we will add 8 to go to the desired address.

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/093377e2-0472-43b6-8342-1d43bcbcc063"

- Here, all the registers (rd,rs1,rs2) are of 5 bits and this is the reason **RISC-5 has only 32 registers**(2^5)

- ABI set of rules governing how software components interact at the binary level, and dose the instruction calls through this particular 32 registers.

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/7451eb78-4a81-409d-bca0-302ae9c0a6bc"

### RISC-V instruction set architecture
---
In the RISC-V instruction set architecture, instructions are categorized into different formats based on their opcode and operand types. Single-letter abbreviations denote these formats. Here's an explanation of each type:

- **R-Type (Register Type)** - These instructions involve operations that operate on two source registers and store the result in a destination register. They include arithmetic, logical, and bitwise operations. The typical format is *opcode rd, rs1, rs2*. Eg `add x8, x24,x8`
- **I-Type (Immediate Type)** - These instructions have an immediate (constant) value as one of their operands, and they work with a source register to perform operations like arithmetic, logical, and memory operations. The typical format is *opcode rd, rs1, imm*. Eg `ld x8, 16(x23)`

- **S-Type (Store Type)** - S-type instructions are used for storing data in memory. They combine a source register, a destination address (base register), and an immediate offset to determine where the data should be stored. The typical format is *opcode rs2, imm(rs1)*. Eg `sd x8, 8(x23)`

### Lab of using ABI function calls
---
- The flow chart of the function performed by ASM(Assembly code) code is shown below :

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/6b8a9e52-c94d-450d-9a25-875755212dfc"

- To illustrate the ABI, the C code shown above will send the values to the ASM code through the function load,in registers a0 and a1, and the ASM code will perform the function and return the value to the C code in register a0 and the value is displayed by the C code.
  

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/f1383fb6-18c9-46ff-816a-745a8734f4ec"

- We the ASM(Assembly code) code to add numbers from 1 to 9 in `load.s` file

![Screenshot (2730)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/906201a4-6acd-458c-982e-53587dacd378)
```
.section .text
.global load
.type load, @function

load:
	add 	a4, a0, zero  // Initialize sum register a4 with 0x0
	add 	a2, a0, a1    // store count of 10 in register a2. Register a1 is loaded with 0xa (decimal 10) from main program
	add	a3, a0, zero  // initialize intermediate sum register a3 by 0
loop:	add 	a4, a3, a4    // Incremental addition
	addi 	a3, a3, 1     // Increment intermediate register by 1	
	blt 	a3, a2, loop  // If a3 is less than a2, branch to label named <loop>
	add	a0, a4, zero  // Store final result to register a0 so that it can be read by main program
	ret
```

- Now, to run the files in RISC-V, we use these commands:

```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o count_1to9.o count_1to9.c load.s
riscv64-unknown-elf-objdump -d count_1to9.o | less
spike pk count_1to9.o
```

- Finally, we got the output
- 
![Screenshot (2733)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/3e77bf5f-82b9-4257-b10d-f3ce84221ae8)
![Screenshot (2732)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/53124ed4-3d67-429a-8051-185c559fbf13)

### Labs of RISC-V Basic Verification flow using iverilog
---
- Now, we will see to run the C program in RISC-V CPU(till now we have done simulations)
- We have RISCV CPU written in Verilog but we will be doing lays in tl-Verilog 
- For verification of the RISC-V CPU the C code will be converted into an HEX file and it will be given to the RISC-V CPU and the output will be displayed and verified. The block diagram is shown below :
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/5e14aac8-eeb2-4c89-9f9a-0b8ba6ab4b85"

- Now to clon all the RISC-V Core files we use
```
git clone https://github.com/kunalg123/riscv_workshop_collaterals.git
```
- `picorv32.v` is the Verilog code of one of the RISC-V CPU Cores.
- `testbench.v` is the testbench  to verify the RISC-V CPU Core.
- `rv32im.sh` is a shell script file to convert it to a hex file, load it to picorv32 memory and load .c and .s file, run it and generate .hex file, and iVerilog will dup out the .vvp file and simulate it.

- Now, to run the file, we use
```
chmod 777 rv32im.sh
./rv32im.sh  
```
- This will generate a `firmware.hex` file, which contains a C program in HEX format. These are the final binary files generated by assembled and loaded into the memory with the help  of the test bench, and read by the RISC-V CPU. 
- This `firmware32.hex` is the final generated bitstreams which are loaded into the memory with the help  of the testbench and read by the RISC-V CPU.

![Screenshot (2740)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/b6d113b2-0a9c-43ba-b90f-e5ede332e8c7)

![Screenshot (2736)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/1a2fa1e5-1995-46a5-ac64-1ad86c040eee)

![Screenshot (2735)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/2dd4d696-871c-4e3f-8ed2-ee6e87d5f10e)

![Screenshot (2737)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/cf7b2490-3797-423e-9a89-a944ae53cfb3)


## Day 3:
## Digital Logic with TL-Verilog and Makerchip
---
### TL-Verilog and Makerchip IDE
---

Here we will be designing different logic gates, combinational circuits, and sequential circuits using TL-Verilog and Makerchip.

#### Makerchip IDE
Makerchip IDE is a user-friendly integrated development environment for digital design and hardware description languages (HDLs) like TL Verilog, SystemVerilog, Verilog, and VHDL. It enables users to design, simulate, and test digital circuits and systems visually, with real-time simulation capabilities for catching errors early and refining designs efficiently. It serves as a valuable tool for both beginners and experienced digital designers, fostering innovation in digital electronics. [Open Makerchip IDE](https://makerchip.com/sandbox/)

#### Transaction Level(TL) - Verilog

TL-Verilog is a hardware description language developed by Redwood EDA. It extends Verilog with transaction-level modeling (TL-X), offering more efficient and concise design representation while remaining compatible with standard Verilog. It simplifies syntax, eliminates the need for legacy Verilog features, and is tailored for modeling hardware. TL-Verilog is designed for the design process, making it easier to write and edit Verilog code with fewer bugs. It is particularly useful for transaction-level design, where transactions move through a microarchitecture steered by flow components. TL-Verilog is well-supported by the Makerchip platform.

#### Identifier and Types in TL Verilog

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/a791b326-c1b3-4d0b-bcee-03f91e7ea8b7"

TL-Verilog uses strict naming semantics. The first token must start with two alpha characters. Identifiers can have three types of delimitation or casing.
1. **`$lower_case`** - Pipe signal
Signal names are written in lowercase letters, preceded by a "$" symbol. These signals are possibly related to some form of data pipeline or flow. 
```verilog
$input_data
$output_buffer
$data_processing
```
2. **`$CamelCase`** - State signal
Signal names are written in all uppercase letters, possibly to indicate that these signals are treated as keywords or constants.   
```verilog
$IdleState
$ProcessingState
$ErrorState
```   
3. **`$Upper_CASE`** - Keyword signal
Signal names are written in all uppercase letters, possibly to indicate that these signals are treated as keywords or constants
```verilog
$ENABLED
$MAX_LIMIT
$ERROR_CODE
```
#### TL Verilog Syntex
```verilog
\m5_TLV_version 1d: tl-x.org
\m5
   
   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   
   //...
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

```
- **`\m5_TLV_version 1d: tl-x.org`** - This directive specifies the file format(`/m5_TLV`) of TL-Verilog version(`1d` is late) and references the website (`tl-x.org`) where we can find more information about TL-Verilog. `\m5` is enabling the macro preprocessing using a macro language m5
- **`\m5`** - This directive is followed by some comments.
- **`\SV`** - The code switches to SystemVerilog (SV) mode with the `\SV` directive.
- **`m5_makerchip_module`** - It defines a module named m5_makerchip_module. This encapsulates the top-level design and includes random stimulus support and Verilator configuration. To expand the macro we can see "NAV-TLV" file in Makerchip IDE.
- **`\TLV`** - The code switches back to TL-Verilog (TLV) mode with the `\TLV` directive.
- **`$reset = *reset`** - It assigns the signal reset($reset) of TL Verilog to the reset(*reset) value of of System Verilog in \SV part. This indicates that $reset is derived from the *reset signal in the TL-Verilog domain.
- **`*passed = *cyc_cnt > 40`** - The code asserts the first condition to control simulation termination. If the value of `*cyc_cnt` (cycle count) exceeds 40, `*passed` is set to true, which could be used as a simulation success condition, and the simulation will stop after that because the m5 module returns pass when output is given.
- **`*failed = 1'b0`** - The code asserts the second condition to control simulation termination. `*failed` is set to 0 (false), indicating that the simulation has not failed.
  


- **NOTE** - Unlike Verilog, there is no need to declare $in and $out ports. In Maketrchip, three space indentations must be preserved.

### Lab of Combinational logic in TL-Verilog using Makerchip 
---
#### Logic Gates
- TL Verilog code for logic gates
```verilog
   $out = !$in;               // OR gate
   $out_and = $in1 && $in2;   // AND gate
   $out_or = $in1 || $in2;    // OR gate
   $out_xor = $in1 ^ $in2;    // XOR gate
```
![Screenshot (2795)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/fc8f9348-1031-4d3b-ac28-396e2ffe71fc)
[MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/058hKX#)
- We are getting an error *$in1 is used but never assigned* because we have not assigned `$in1` with any value, and it generates random values and hence can be ignored.
- We are also getting a warning that *$out is assigned but never used* because `$out` is a floating wire getting an output. So, we can ignore or use ``BOGUS_USE($out)` to silence the warning.

#### Vector Addition, 2:1 Multiplexer and 2:1 Vector Multiplexer
- TL Verilog codes 
```verilog   
   $out_add[5:0] = $in1a[4:0] + $in2a[4:0];           // vector addition
   $out_mux = $sel ? $in1m : $in0m;                   // 2:1 MUX
   $out_vecmux[7:0] = $sel ? $in1v[7:0] : $in0v[7:0]; //2:1 Vector Multiplexer
   ```
![Screenshot (2794)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/cb1c8bb1-249e-4b50-a636-042f141d9575)
[MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/08qhA6)

#### Calculator 
- TL Verilog codes of Calculator
```verilog
   $op[1:0] = $rand2[1:0];  //$randX (where X is a number) generates a random value of X, which is the variable name.
   
   $val1[31:0] = $rand3[2:0];         
   $val2[31:0] = $rand4[3:0];         //Opcode	Function
   $sum[31:0] = $val1+$val2;          //2'b00	Addition
   $diff[31:0] = $val1-$val2;         //2'b01	Subtraction
   $prod[31:0] = $val1*$val2;         //2'b10	Multiplication
   $div[31:0] = $val1/$val2;          //2'b11	Division
   
   $out[31:0] = $op[1] ? ($op[0] ? $div : $prod):($op[0] ? $diff : $sum);
```
![Screenshot (2796)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/57fdac15-a982-4d07-94ff-c3c184701ebc)
[MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/0RghWW#)
- We are getting an error *$rand3 is used but never assigned* because we have not assigned `$rand3` with any value bit its generating random value of 3 bit hence can be ignored.

 
### Lab of Sequential logic in TL-Verilog using Makerchip
---
#### Fibonacci Series

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/4d07128c-f1d5-4601-b0db-e91f864be879"

The TL-Verilog code for fibonacci series

```verilog
   $num[31:0] = $reset ? 1 : (>>1$num + >>2$num);
   // >>1$num - Previous number
   // >>2$num - Previous to previous number
```
![Screenshot (2797)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/9ae6b2dd-1337-4808-9d55-21974adf4ace)
[MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/0Lgh9D)
 
#### Counter
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/f40d26da-07df-4531-9362-fd539d2500fc"

The TL-Verilog code for Counter

```verilog
   $cnt[31:0] = $reset ? 0 : (>>1$cnt + 1);
```
![Screenshot (2798)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/e1285664-9691-4e1b-bd46-99cb38f425cd)
[MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/0KOhW7)

#### Sequential Calculator

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/be639c52-6624-480f-be6b-ba6350aa4253"

The TL-verilog code for sequential calculator

```verilog
   \m5_TLV_version 1d: tl-x.org
\m5
   
\SV
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   
   $op[1:0] = $rand2[1:0];  //$randX (where X is a number) generates a random value of X, which is the variable name.
      
   $val1[31:0] = >>1$out[31:0];         
   $val2[31:0] = $rand4[3:0];         //Opcode	Function
   $sum[31:0] = $val1+$val2;          //2'b00	Addition
   $diff[31:0] = $val1-$val2;         //2'b01	Subtraction
   $prod[31:0] = $val1*$val2;         //2'b10	Multiplication
   $div[31:0] = $val1/$val2;          //2'b11	Division
   
   $out[31:0] = reset ? 32'b0: ($op[1] ? ($op[0] ? $div : $prod):($op[0] ? $diff : $sum));
      
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
```

![Screenshot (2804)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/310e5165-3c6f-428b-bd02-d93b63042756)
[MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/0DRhAR#)

### Lab of Pipelined Pythagorean
---

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/21fb925d-0480-4602-bea0-54dd52bfab3c"
	    
- The TL-Verilog code of Pipelined Pythagorean
  
```verilog
\m5_TLV_version 1d: tl-x.org
\m5
  
\SV
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
   `include "sqrt32.v"
\TLV
   $reset = *reset;
   
   |calc                //     | - Represent the code below are pipeline.
      @1                //    @ - Represents the pipelined stage number.
         $aa_sq[31:0] = $aa[3:0] * $aa[3:0];
         $bb_sq[31:0] = $bb[3:0] * $bb[3:0];
      @2
         $cc_sq[31:0] = $aa_sq + $bb_sq;
      @3
         $out[31:0] = sqrt($cc_sq);
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

```
![Screenshot (2803)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/1288fb8f-745f-4175-a2dd-8f55f0dc8a0c)
- [MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/0BghK1)

### Lab of Counter and 1 Cycle Pipeline Calculator
---

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/4fa10630-b78c-4833-bd53-2de6b540b548"

- The counter counts no or clock and gives output in cnt whenever reset is 1.
```verilog
\m5_TLV_version 1d: tl-x.org
\m5
  
\SV
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
   `include "sqrt32.v"
\TLV
   $reset = *reset;
   $op[1:0] = $random[1:0];
   $val2[31:0] = $rand2[3:0];
   
   |calc
      @1
         $reset = *reset;
         $val1[31:0] = >>1$out;
         $sum[31:0] = $val1+$val2;
         $diff[31:0] = $val1-$val2;
         $prod[31:0] = $val1*$val2;
         $div[31:0] = $val1/$val2;
         $out[31:0] = $reset ? 32'h0 : ($op[1] ? ($op[0] ? $div : $prod):($op[0] ? $diff : $sum));
         
         $cnt[31:0] = $reset ? 0 : (>>1$cnt + 1); 

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

```
![Screenshot (2806)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/151839de-f09d-40a3-abd4-02062a7bcb09)
- [MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/066hm4#)

### Lab of 2-Cycle Pipeline Calculator
---
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/9796ed8c-f051-46f1-9c6f-a31c14634829"

- The TL-Verilog code of 2-Cycle Pipeline Calculator

```verilog
\m5_TLV_version 1d: tl-x.org
\m5
  
\SV
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
   `include "sqrt32.v"
\TLV
   $reset = *reset;
   $op[1:0] = $rand2[1:0];
   $val2[31:0] = $rand4[3:0];
   
   |calc
      @1
         $reset = *reset;
         $val1[31:0] = >>2$out;
         $sum[31:0] = $val1+$val2;
         $diff[31:0] = $val1-$val2;
         $prod[31:0] = $val1*$val2;
         $div[31:0] = $val1/$val2;
         $valid = $reset ? 32'b0 : (>>1$valid + 1);
      @2
         $out[31:0] = ($reset | ~($valid))  ? 32'h0 : ($op[1] ? ($op[0] ? $div : $prod):($op[0] ? $diff : $sum));
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
```
- Here `$valid` is just toggling when reset is 0 (active low reset) and just plays the role of second conformation for the 2nd clock cycle mux that 1st stage as completed the output(if it is not there the circuit will work fine) 
![Screenshot (2817)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/742662c1-483a-4213-8361-7b8cecc2aa78)

- [MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/0VmhyK#)

### Validity and Clock Gating
---
#### Validity
Validity is a concept used to indicate whether data or transactions are valid and ready for processing. It's represented by a signal, often named valid, which can have two values: 1 (true) to indicate that the data is valid, or 0 (false) to indicate that the data is not valid or not ready. Validity signals help manage data flow, synchronization, and correctness in transaction-level hardware descriptions. They ensure that data is processed only when it's in a valid state, helping to maintain the integrity of the design.

#### Clock Gating
 clock gating is a technique used to optimize the power efficiency of digital integrated circuits. It involves inserting logic gates into the clock network to selectively disable or "gate" the clock signal to certain areas of the chip when they are not in use. This helps reduce dynamic power consumption by preventing unnecessary clock toggling in idle or unused portions of the circuit. Clock gating is a common practice in modern chip design to improve energy efficiency without sacrificing performance.
 
### Lab of Pipelined Pythagorean with validity
---
- Here, we are enabling a valid bit when rand_valif = 3 
```verilog

\m4_TLV_version 1d: tl-x.org
\SV
   `include "sqrt32.v";
   
   m4_makerchip_module
\TLV
   
   // Stimulus
   |calc
      @0
         $valid = & $rand_valid[1:0];  // Valid with 1/4 probability
                                       // (& over two random bits).
   
   // DUT (Design Under Test)
   |calc
      ?$valid
         @1
            $aa_sq[7:0] = $aa[3:0] ** 2;
            $bb_sq[7:0] = $bb[3:0] ** 2;
         @2
            $cc_sq[8:0] = $aa_sq + $bb_sq;
         @3
            $cc[4:0] = sqrt($cc_sq);


   // To Print output in log
   |calc
      @3
         \SV_plus
            always_ff @(posedge clk) begin
               if ($valid)
                  \$display("sqrt((\%2d ^ 2) + (\%2d ^ 2)) = \%2d", $aa, $bb, $cc);
            end

\SV
   endmodule
```
- Here we use `?$valid` means valid bit high, then only its content is executed.

![Screenshot (2811)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/773422e5-77db-4659-af49-cb74f7a4c292)
- [MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0rkfAhzwA/0r0hzX#)

### Lab of Distance Accumulator
---
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/8f4d3c8f-5e7a-416c-a663-21be68cdc9fc"

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/29b7196e-cf0c-4821-89ca-126591a0be6f"
	    
- TL Verilog codes to add logic of 2 Cycle Pipeline Calculator with Validity Distance Accumulator

```verilog
   |calc
      @1
         $reset = *reset;
      ?$valid
         @1
            $aa_sq[31:0] = $aa[3:0] * $aa;
            $bb_sq[31:0] = $bb[3:0] * $bb;
         @2
            $cc_sq[31:0] = $aa_sq + $bb_sq;
         @3
            $cc[31:0] = sqrt($cc_sq);
      @4
         $tot_dist[63:0] = $reset ? 64'b0 : ($valid ?
                (>>1$tot_dist + $cc) : $RETAIN);  
                      //$RETAIN = >>$tot_dist
   endmodule

```
![Screenshot (2823)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/c5cacea1-c7df-4871-a05f-a3a99d0a4f74)

- [MICROCHIP PROJECT URL](https://makerchip.com/sandbox/0n5fGhJR7/0Lghr1)

### Lab of 2 Cycle Pipeline Calculator with Validity
---
- Now instead of assigning an output value of 0 in every clock cycle, we are going to use validity.
- We OR the reset with a valid signal to use the logic enabled during the reset.

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/acdde9aa-17b3-4a1e-96c2-407644043e0e"
	    
- TL Verilog codes to add logic of 2 Cycle Pipeline Calculator with Validity
  
```verilog
   $reset = *reset;
   $op[1:0] = $rand2[1:0];
   $val2[31:0] = $rand4[3:0];
   
   |calc
      @1
         $reset = *reset;
         $val1[31:0] = >>2$out;
         $val2[31:0] = $rand2[3:0];
         $valid = $reset ? 0 : >>1$valid+1;
         $valid_or_reset = $valid || $reset; 
      ?$valid_or_reset
         @1
            $sum[31:0] = $val1+$val2;
            $diff[31:0] = $val1-$val2;
            $prod[31:0] = $val1*$val2;
            $div[31:0] = $val1/$val2;
            
         @2
            $out[31:0] = $reset  ? 32'h0 : ($op[1] ? ($op[0] ? $div : $prod):($op[0] ? $diff : $sum));
   

```
![Screenshot (2822)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/d962709c-e573-4952-a806-6dc6a630c0c4)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0yPfNhM9A/0vghPJ#)
- [CHECK SOLUTION](https://myth.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2Fstevehoover%2FRISC-V_MYTH_Workshop%2Fmaster%2Fcalculator_shell.tlv#)
- [REFERENCE SOLUTION](https://myth.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2Fstevehoover%2FRISC-V_MYTH_Workshop%2Fmaster%2Freference_solutions.tlv#)

### Lab of Calculator with Single Value Memory
---
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/b5d7ea27-7502-4a14-ae0d-cb68ffa0f8df"

- TL Verilog codes to add logic of Calculator with Single Value Memory
  
```verilog
|calc
      @1
         $reset = *reset;
         $val1 [31:0] = >>2$out;
         $val2 [31:0] = $rand2[3:0];
         $valid = $reset ? 1'b0 : >>1$valid + 1'b1 ;
         $valid_or_reset = $valid || $reset;

      ?$vaild_or_reset
         @1   
            $sum [31:0] = $val1 + $val2;
            $diff[31:0] = $val1 - $val2;
            $prod[31:0] = $val1 * $val2;
            $div[31:0] = $val1 / $val2;

         @2   
            $mem[31:0] = $reset ? 32'b0 :
                         ($op[2:0] == 3'b101) ? $val1 : >>2$mem ;

            $out [31:0] = $reset ? 32'b0 :
                          ($op[2:0] == 3'b000) ? $sum :
                          ($op[2:0] == 3'b001) ? $diff :
                          ($op[2:0] == 3'b010) ? $prod :
                          ($op[2:0] == 3'b011) ? $quot :
                          ($op[2:0] == 3'b100) ? >>2$mem : >>2$out ;

```
![Screenshot (2820)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/12d5dc34-6111-40ca-b9e9-3503db2d826c)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0yPfNhM9A/0Lghg1#)

## Day 4:
## Basic RISC-V CPU micro-architecture
---
### Designing Microarchitecture of simple RISC-V CPU
---
The basic RISC-V CPU block diagram

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/59fdaf69-868e-401b-8e24-d7c7db91d255"

1. **Program Counter (PC)**: Keeps track of the memory address of the next instruction to be executed in the CPU.
2. **Instruction Decoder**: Interprets machine instructions, generates control signals, and directs CPU components to execute the instruction.
3. **Instruction Memory**: Stores program instructions in binary form and is read-only.
4. **Data Memory**: Stores data used by the program and can be both read from and written to.
5. **ALU (Arithmetic Logic Unit)**: Performs arithmetic and logical operations like addition, subtraction, and bitwise operations.
6. **Read Register File**: Holds registers for data storage and is used for reading data specified by instructions.
7. **Write Register File**: Stores the results of operations back into registers for future use in the program.

### RISC-V CPU Implementation Steps
---
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/06c51a01-9774-4472-ada8-f372ee5b3817"

- [CHECK SOLUTION](https://myth.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2Fstevehoover%2FRISC-V_MYTH_Workshop%2Fmaster%2Frisc-v_shell.tlv#)
- [REFERENCE SOLUTION](https://myth.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2Fstevehoover%2FRISC-V_MYTH_Workshop%2Fmaster%2Freference_solutions.tlv#)
### 1-Next Program Counter Logic

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/f87bb674-ddb6-400b-af62-0786e2d688f6"

- TL Verilog codes to add logic of PC
```verilog
|cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? 32'b0 : (>>1$pc + 32'd4);

   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
```
![Screenshot (2829)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/51c749f0-0e61-4daa-851d-4d75eaed9a6d)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0lYfoh9Or/01jh4B)

### 2-Instruction Fetch Logic

- We uncommented `//m4+imem(@1)` and `//m4+cpu_viz(@4)` compile and observed the log errors.

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/6491d711-6cb0-401a-be54-030a93ef8783"

- Based on the instruction we assemble and its array size, we specify the appropriate no of Intex bits `M4_IMEM_INTEX_CNT`.
- Since we are driving to the address from the PC and the pc is a byte address(we will assume that the PC is properly aligned to the instruction boundary and the lower 2 bits of the PC are 0).
- Instruction memory will drive out a signal `$imem_rd_data`.
```verilog
   |cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? 32'b0 : (>>1$pc + 32'd4);
      @1
         // Instruction Fetch
         $imem_rd_en = !$reset;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_INDEX_CNT+1:2];     // $imem_rd_addr is going to m4+imem(@1) vinding the vakue of that address    
         $instr[31:0] = $imem_rd_en ? $imem_rd_data[31:0]: 32'b0;             // and returning it in $imem_rd_data[31:0]
         `BOGUS_USE($instr)                         //`BOGUS_USE is a system verilog single argument macro to silence the warning is assigned but never used.        
      
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   |cpu
      m4+imem(@1)    // Args: (read stage)              // m4+imem(@1) is the instantiated System verilog code, can be seen in NAV-TLV in MakerChip IDE 
      //m4+rf(@1, @1)  // Args: (read stage, write stage) - if equal, no register bypass is required
      //m4+dmem(@4)    // Args: (read/write stage)
      //m4+myth_fpga(@0)  // Uncomment to run on fpga

   m4+cpu_viz(@4)    // For visualisation, argument should be at least equal to the last stage of CPU logic. @4 would work for all labs.

```
![Screenshot (2860)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/62d93432-0345-4f88-aaa3-8ff7c38d08de)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0ERfWhw5Y/0WnhWl#)

### 3-Instruction Decode Logic
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/3ae8c4cd-dc35-4da8-a82b-b424b3e70d12"

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/51b2a656-5f93-49e7-9ea6-47fa94347f3c"

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/57bdfaf1-2692-4a5a-a380-3f0f34234fd6"

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/38fd9226-2f2d-453c-809e-c89f6684a74f"
 
- TL Verilog codes to add logic of Instruction Decode.
  
```verilog
   |cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? 32'b0 : (>>1$pc + 32'd4);
      @1
         // Instruction Fetch
         $imem_rd_en = !$reset;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_INDEX_CNT+1:2];     // $imem_rd_addr is going to m4+imem(@1) vinding the vakue of that address    
         $instr[31:0] = $imem_rd_en ? $imem_rd_data[31:0]: 32'b0;             // and returning it in $imem_rd_data[31:0]
      @1
         //Instruction Decode
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||   // ==? is used to compare the binary don't cares
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b11100;
         
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:7]} :
                      $is_b_instr ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0} :
                      $is_u_instr ? {$instr[31:12], 12'b0} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                                    32'b0;
         $opcode[6:0] = $instr[6:0];
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
            
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
            
         $funct7_valid = $is_r_instr ;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
            
         $dec_bits[10:0] = {$funct7[5], $funct3, $opcode};
         $is_beq = $dec_bits ==? 11'bx_000_1100011;
         $is_bne = $dec_bits ==? 11'bx_001_1100011;
         $is_blt = $dec_bits ==? 11'bx_100_1100011;
         $is_bge = $dec_bits ==? 11'bx_101_1100011;
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         $is_add = $dec_bits ==? 11'b0_000_0110011;
         `BOGUS_USE($is_beq $is_beq $is_bne $is_blt $is_bge $is_bltu $is_bgeu $is_addi $is_add)
         //`BOGUS_USE is a system verilog single argument macro to silence the warning is assigned but never used.    
```
![Screenshot (2861)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/37379430-3e5c-4aed-86e0-890278b29fa5)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0ERfWhw5Y/0X6hz0)

### 4-Register File Read Logic
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/b28744cd-4a9e-4400-a0fe-8be961f27be9"

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/124b6695-27e9-4b77-a48c-1e4ba3830923"

- TL Verilog codes to add logic of Register File Read.
  
```verilog
      @1
         //Register File Read
         $rf_rd_en1 = $rs1_valid;
         $rf_rd_index1[4:0] = $rs1;  //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data1 of 32 bit, which is the value stored in that register
         $rf_rd_en2 = $rs2_valid;
         $rf_rd_index2[4:0] = $rs2;   //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data2 of 32 bit, which is the value stored in that register
         $src1_value[31:0] = $rf_rd_data1;
         $src2_value[31:0] = $rf_rd_data2;
         `BOGUS_USE($src1_value $src1_value)
         
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   
   |cpu
      m4+imem(@1)    // Args: (read stage)
      m4+rf(@1, @1)  // Args: (read stage, write stage) - if equal, no register bypass is required
      //m4+dmem(@4)    // Args: (read/write stage)
      //m4+myth_fpga(@0)  // Uncomment to run on fpga

   m4+cpu_viz(@4)    // For visualisation, argument should be at least equal to the last stage of CPU logic. @4 would work for all labs.
```
![Screenshot (2862)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/822c5a2d-3581-44b1-8620-2affe99b7a83)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0ERfWhw5Y/03lhEO)

### 5-Arithmetic Logic Unit Implementation
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/12925ae3-0d53-488a-8749-610deff62e55"

- TL Verilog codes to add logic of ALU
```verilog
   @1
      //ALU
      $result[31:0] = $is_addi ? $src1_value + $imm :
                         $is_add ? $src1_value + $src2_value :
                         32'bx ;
```
![Screenshot (2863)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/1fbb515c-d0c7-4b90-b931-10786851d88c)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0ERfWhw5Y/076hJX#)

### 6-Register File Write Logic
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/1d96f724-fc33-40fd-87c7-a9f227ea9191"

- TL Verilog codes to add logic of Register File Write.
- 
```verilog
      @1
         //Register File Write                  // $rd_valid = 1 when ISA have rd its instruction 
         $rf_wr_en = $rd_valid && $rd != 5'b0;  // if $rd_valid =0 or $rd =0 then then $rf_wr_en is 0
         $rf_wr_index[4:0] = $rd;                              // $rd=0(because x0 register of RISC-V always stores vale 32'b0 so can't be rewritten ) 
         $rf_wr_data[31:0] = $result;       // $result is coming from ALU and getting stored in $rf_wr_index[4:0] address of RISC-V register         
                                            // having value $rf_wr_data   
```
![Screenshot (2854)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/dbe08cc8-335c-44df-a14c-cf54b33a1edf)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0ERfWhw5Y/08qhKm#)

### 7-Branch Instruction Logic
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/c5cea9dc-bfa2-4c88-83b2-77beb1235596"
	    
- TL Verilog codes to add logic of Branch Instructions.
	    
```verilog
   |cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? 32'd0 : (>>1$taken_branch ? >>1$br_tgt_pc :  (>>1$pc+32'd4));
      @1
         //Branch Instructions
         $taken_branch = $is_beq ? ($src1_value == $src2_value):               //BEQ (Branch if Equal)
                         $is_bne ? ($src1_value != $src2_value):               //BNE (Branch if Not Equal)  
                         $is_blt ? (($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31])):    // BLT (Branch if Less Than)
                         $is_bge ? (($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31])):   //BGE (Branch if Greater Than or Equal)
                         $is_bltu ? ($src1_value < $src2_value):              //BLTU (Branch if Less Than Unsigned)
                         $is_bgeu ? ($src1_value >= $src2_value):             //BGEU (Branch if Greater Than or Equal Unsigned)
                                    1'b0;
         
         $br_tgt_pc[31:0] = $pc + $imm;    // $br_tgt_pc will add the value of %pc value and $imm value which has the stored value of  differnece of target address and current address
         
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
  
   |cpu
      m4+imem(@1)    // Args: (read stage)
      m4+rf(@1, @1)  // Args: (read stage, write stage) - if equal, no register bypass is required
      //m4+dmem(@4)    // Args: (read/write stage)
      //m4+myth_fpga(@0)  // Uncomment to run on fpga

   m4+cpu_viz(@4)    // For visualization, the argument should be equal to the last stage of CPU logic. @4 would work for all labs.
```
![Screenshot (2865)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/22386bfd-9492-4249-9911-63b9f0d877c4)

- [MICROCHIP PROJECT URL](https://myth.makerchip.com/sandbox/0PNf4h03q/0j2hvQ)

### Testbench
- Tell Makerchip when simulate passes by monitoring the value of register x10 containing the sum (within@1). It will return the passed message in log file if register x10 contains the correct sum value.
```verilog
*passed = |cpu/xreg[15]>>5$value == (1+2+3+4+5+6+7+8+9);
```
![Screenshot (2868)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/dab1a539-2329-4f22-993c-52b4712e3e97)

### Final TL Verilog Code of designed RISC-V Architecture
---

- [MICROCHIP FINAL PROJECT URL](https://myth.makerchip.com/sandbox/0PNf4h03q/00ghLV#)

```verilog
\m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/RISC-V_MYTH_Workshop
   
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/RISC-V_MYTH_Workshop/master/tlv_lib/risc-v_shell_lib.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV

   // /====================\
   // | Sum 1 to 9 Program |
   // \====================/
   //
   // Program for MYTH Workshop to test RV32I
   // Add 1,2,3,...,9 (in that order).
   //
   // Regs:
   //  r10 (a0): In: 0, Out: final sum
   //  r12 (a2): 10
   //  r13 (a3): 1..10
   //  r14 (a4): Sum
   // 
   // External to function:
   m4_asm(ADD, r10, r0, r0)             // Initialize r10 (a0) to 0.
   // Function:
   m4_asm(ADD, r14, r10, r0)            // Initialize sum register a4 with 0x0
   m4_asm(ADDI, r12, r10, 1010)         // Store count of 10 in register a2.
   m4_asm(ADD, r13, r10, r0)            // Initialize intermediate sum register a3 with 0
   // Loop:
   m4_asm(ADD, r14, r13, r14)           // Incremental addition
   m4_asm(ADDI, r13, r13, 1)            // Increment intermediate register by 1
   m4_asm(BLT, r13, r12, 1111111111000) // If a3 is less than a2, branch to label named <loop>
   m4_asm(ADD, r10, r14, r0)            // Store final result to register a0 so that it can be read by main program
   
   // Optional:
   // m4_asm(JAL, r7, 00000000000000000000) // Done. Jump to itself (infinite loop). (Up to 20-bit signed immediate plus implicit 0 bit (unlike JALR) provides byte address; last immediate bit should also be 0)
   m4_define_hier(['M4_IMEM'], M4_NUM_INSTRS)

   |cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? 32'd0 : (>>1$taken_branch ? >>1$br_tgt_pc :  (>>1$pc+32'd4));
      @1
         // Instruction Fetch
         $imem_rd_en = !$reset;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_INDEX_CNT+1:2];     // $imem_rd_addr is going to m4+imem(@1) vinding the vakue of that address    
         $instr[31:0] = $imem_rd_en ? $imem_rd_data[31:0]: 32'b0;             // and returning it in $imem_rd_data[31:0]
      @1
         //Instruction Decode
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||   // ==? is used to compare the binary don't cares
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b11100;
         
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:7]} :
                      $is_b_instr ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0} :
                      $is_u_instr ? {$instr[31:12], 12'b0} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                                    32'b0;
         $opcode[6:0] = $instr[6:0];
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
            
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
            
         $funct7_valid = $is_r_instr ;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
            
         $dec_bits[10:0] = {$funct7[5], $funct3, $opcode};
         $is_beq = $dec_bits ==? 11'bx_000_1100011;
         $is_bne = $dec_bits ==? 11'bx_001_1100011;
         $is_blt = $dec_bits ==? 11'bx_100_1100011;
         $is_bge = $dec_bits ==? 11'bx_101_1100011;
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         $is_add = $dec_bits ==? 11'b0_000_0110011;
      @1
         //Register File Read
         $rf_rd_en1 = $rs1_valid;
         $rf_rd_index1[4:0] = $rs1;  //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data1 of 32 bit, which is the value stored in that register
         $rf_rd_en2 = $rs2_valid;
         $rf_rd_index2[4:0] = $rs2;   //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data2 of 32 bit, which is the value stored in that register
         $src1_value[31:0] = $rf_rd_data1;
         $src2_value[31:0] = $rf_rd_data2;
      @1
         //ALU
         $result[31:0] = $is_addi ? $src1_value + $imm :
                         $is_add ? $src1_value + $src2_value :
                         32'bx ;
      @1
         //Register File Write                  // $rd_valid = 1 when ISA have rd its instruction 
         $rf_wr_en = $rd_valid && $rd != 5'b0;  // if $rd_valid =0 or $rd =0 then then $rf_wr_en is 0
         $rf_wr_index[4:0] = $rd;                              // $rd=0(because x0 register of RISC-V always stores vale 32'b0 so can't be rewritten ) 
         $rf_wr_data[31:0] = $result;       // $result is coming from ALU and getting stored in $rf_wr_index[4:0] address of RISC-V register         
                                            // having value $rf_wr_data   
      @1
         //Branch Instructions
         $taken_branch = $is_beq ? ($src1_value == $src2_value):               //BEQ (Branch if Equal)
                         $is_bne ? ($src1_value != $src2_value):               //BNE (Branch if Not Equal)  
                         $is_blt ? (($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31])):    // BLT (Branch if Less Than)
                         $is_bge ? (($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31])):   //BGE (Branch if Greater Than or Equal)
                         $is_bltu ? ($src1_value < $src2_value):              //BLTU (Branch if Less Than Unsigned)
                         $is_bgeu ? ($src1_value >= $src2_value):             //BGEU (Branch if Greater Than or Equal Unsigned)
                                    1'b0;                 
         $br_tgt_pc[31:0] = $pc + $imm;    // $br_tgt_pc will add the value of %pc value and $imm value which has the stored value of  differnece of target address and current address
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
   *failed = 1'b0;
   
   // Macro instantiations for:
   //  o instruction memory
   //  o register file
   //  o data memory
   //  o CPU visualization
   |cpu
      m4+imem(@1)    // Args: (read stage)
      m4+rf(@1, @1)  // Args: (read stage, write stage) - if equal, no register bypass is required
      //m4+dmem(@4)    // Args: (read/write stage)
      //m4+myth_fpga(@0)  // Uncomment to run on fpga

   m4+cpu_viz(@4)    // For visualisation, argument should be at least equal to the last stage of CPU logic. @4 would work for all labs.
\SV
   endmodule

```


### Block Diagram of the designed RISC-V Architecture
![Screenshot (2866)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/94d9904f-2719-42f9-8c67-f64bd6eaa4f9)

### Waveform for designed RISC-V Architecture
![Screenshot (2867)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/ae9f8197-e176-4d74-9dba-641e25c5ef35)

### Implemented design of RISC-V Architecture
![Screenshot (2876)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/624524d4-60e5-4236-bac0-718f9d69419a)

## Day 5:
## Complete Pipelined RISC-V CPU micro-architecture/store
---
### Pipelining the CPU
---
Pipelining is a fundamental concept in modern processor design, including the RISC-V architecture. It involves breaking down the execution of instructions into a series of overlapping stages, allowing for faster and more efficient processing. While pipelining offers significant performance advantages, it also introduces certain hazards that must be managed.

#### Pipeline Hazards
1. **Data Hazards:** These occur when an instruction depends on the result of a previous instruction that hasn't completed its execution yet. Data hazards can lead to pipeline stalls or the need for forwarding logic to resolve dependencies.
2. **Control Hazards:** Control hazards happen when a decision about the next instruction is unclear, such as due to branches or jumps. These hazards can lead to pipeline flushes or speculative execution to minimize the impact.
3. **Structural Hazards:** Structural hazards arise when multiple instructions need access to the same hardware resource simultaneously, like memory or registers. This can be resolved through resource allocation and scheduling.
4. **Pipeline Bubbles:** Hazards can result in pipeline stalls, which leave certain stages idle, reducing the overall efficiency of the pipeline.

### Design of Pipeline 3 instruction per cycle of RISC-V CPU micro-architecture
---

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/877a5d5a-1ac1-4653-b078-2b08de3c408e"

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/b2339a2e-aaaf-4511-a715-f056488421f1"

- Here, we are planning the architecture so that it operates every third cycle of the clock.
  
```verilog
\m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/RISC-V_MYTH_Workshop
   
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/RISC-V_MYTH_Workshop/master/tlv_lib/risc-v_shell_lib.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV

   // /====================\
   // | Sum 1 to 9 Program |
   // \====================/
   //
   // Program for MYTH Workshop to test RV32I
   // Add 1,2,3,...,9 (in that order).
   //
   // Regs:
   //  r10 (a0): In: 0, Out: final sum
   //  r12 (a2): 10
   //  r13 (a3): 1..10
   //  r14 (a4): Sum
   // 
   // External to function:
   m4_asm(ADD, r10, r0, r0)             // Initialize r10 (a0) to 0.
   // Function:
   m4_asm(ADD, r14, r10, r0)            // Initialize sum register a4 with 0x0
   m4_asm(ADDI, r12, r10, 1010)         // Store count of 10 in register a2.
   m4_asm(ADD, r13, r10, r0)            // Initialize intermediate sum register a3 with 0
   // Loop:
   m4_asm(ADD, r14, r13, r14)           // Incremental addition
   m4_asm(ADDI, r13, r13, 1)            // Increment intermediate register by 1
   m4_asm(BLT, r13, r12, 1111111111000) // If a3 is less than a2, branch to label named <loop>
   m4_asm(ADD, r10, r14, r0)            // Store final result to register a0 so that it can be read by main program
   
   // Optional:
   // m4_asm(JAL, r7, 00000000000000000000) // Done. Jump to itself (infinite loop). (Up to 20-bit signed immediate plus implicit 0 bit (unlike JALR) provides byte address; last immediate bit should also be 0)
   m4_define_hier(['M4_IMEM'], M4_NUM_INSTRS)

   |cpu
      @0
         $reset = *reset;
         $start = (>>1$reset && !$reset);         //Start is to provide first $valid pulse   
         $valid = $reset ?  1'b0 : ($start || >>3$valid );      // This valid is going to be high every third clock cycle which will allow the pipeline to take the next input
         
         $pc[31:0] = >>1$reset ? 32'd0 : (>>3$valid_taken_branch ? >>3$br_tgt_pc :  (>>3$pc+32'd4)); 
      @1                                                        // Here we are taking the output of the previous pipeline value of $valid_taken_branch, 3$br_tgt_pc and >>3$pc and increment pc every three clock cycle.      
         // Instruction Fetch
         $imem_rd_en = !$reset;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_INDEX_CNT+1:2];     // $imem_rd_addr is going to m4+imem(@1) finding the value of that address    
         $instr[31:0] = $imem_rd_en ? $imem_rd_data[31:0]: 32'b0;               // and returning it in $imem_rd_data[31:0]
      @1
         //Instruction Decode
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||   // ==? is used to compare the binary don't cares
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b11100;
         
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:7]} :
                      $is_b_instr ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0} :
                      $is_u_instr ? {$instr[31:12], 12'b0} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                                    32'b0;
         $opcode[6:0] = $instr[6:0];
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
            
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
            
         $funct7_valid = $is_r_instr ;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
            
         $dec_bits[10:0] = {$funct7[5], $funct3, $opcode};
         $is_beq = $dec_bits ==? 11'bx_000_1100011;
         $is_bne = $dec_bits ==? 11'bx_001_1100011;
         $is_blt = $dec_bits ==? 11'bx_100_1100011;
         $is_bge = $dec_bits ==? 11'bx_101_1100011;
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         $is_add = $dec_bits ==? 11'b0_000_0110011;
      @2
         //Register File Read
         $rf_rd_en1 = $rs1_valid;
         $rf_rd_index1[4:0] = $rs1;  //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data1 of 32 bit, which is the value stored in that register
         $rf_rd_en2 = $rs2_valid;
         $rf_rd_index2[4:0] = $rs2;   //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data2 of 32 bit, which is the value stored in that register
         $src1_value[31:0] = $rf_rd_data1;
         $src2_value[31:0] = $rf_rd_data2;
      @3
         //ALU
         $result[31:0] = $is_addi ? $src1_value + $imm :
                         $is_add ? $src1_value + $src2_value :
                         32'bx ;
      @3
         //Register File Write                  // $rd_valid = 1 when ISA have rd its instruction 
         $rf_wr_en_1 = $rd_valid && $rd != 5'b0;  // if $rd_valid =0 or $rd =0 then then $rf_wr_en is 0
         $rf_wr_en = $rf_wr_en_1 && $valid;
         $rf_wr_index[4:0] = $rd;                              // $rd=0(because x0 register of RISC-V always stores vale 32'b0 so can't be rewritten ) 
         $rf_wr_data[31:0] = $result;       // $result is coming from ALU and getting stored in $rf_wr_index[4:0] address of RISC-V register         
                                            // having value $rf_wr_data   
      @3
         //Branch Instructions
         $taken_branch = $is_beq ? ($src1_value == $src2_value):               //BEQ (Branch if Equal)
                         $is_bne ? ($src1_value != $src2_value):               //BNE (Branch if Not Equal)  
                         $is_blt ? (($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31])):    // BLT (Branch if Less Than)
                         $is_bge ? (($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31])):   //BGE (Branch if Greater Than or Equal)
                         $is_bltu ? ($src1_value < $src2_value):              //BLTU (Branch if Less Than Unsigned)
                         $is_bgeu ? ($src1_value >= $src2_value):             //BGEU (Branch if Greater Than or Equal Unsigned)
                                    1'b0;                 
         $br_tgt_pc[31:0] = $pc + $imm;        // $br_tgt_pc will add the value of %pc value and $imm value which has the stored value of  differnece of target address and current address
         $valid_taken_branch = ($valid && $taken_branch) ;  // after every 3 clock cycle when $valid is hihen and $taken_branch is high then $valid_taken_branch is high.
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
   *failed = 1'b0;
   
   // Macro instantiations for:
   //  o instruction memory
   //  o register file
   //  o data memory
   //  o CPU visualization
   |cpu
      m4+imem(@1)    // Args: (read stage)
      m4+rf(@2, @3)  // Args: (read stage, write stage) - if equal, no register bypass is required
      //m4+dmem(@4)    // Args: (read/write stage)
      //m4+myth_fpga(@0)  // Uncomment to run on fpga

   m4+cpu_viz(@4)    // For visualisation, argument should be at least equal to the last stage of CPU logic. @4 would work for all labs.
\SV
   endmodule
```
![Screenshot (2854)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/f4297a86-992e-4676-b468-bf48a227de30)

- [MICROCHIP FINAL PROJECT URL]()
### Design of Pipeline 1 instruction per cycle of RISC-V CPU micro-architecture
---
Here also if there will be any branch instruction we will skip 3 clock cycle 

```verilog
\m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/RISC-V_MYTH_Workshop
   
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/RISC-V_MYTH_Workshop/master/tlv_lib/risc-v_shell_lib.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV

   // /====================\
   // | Sum 1 to 9 Program |
   // \====================/
   //
   // Program for MYTH Workshop to test RV32I
   // Add 1,2,3,...,9 (in that order).
   //
   // Regs:
   //  r10 (a0): In: 0, Out: final sum
   //  r12 (a2): 10
   //  r13 (a3): 1..10
   //  r14 (a4): Sum
   // 
   // External to function:
   m4_asm(ADD, r10, r0, r0)             // Initialize r10 (a0) to 0.
   // Function:
   m4_asm(ADD, r14, r10, r0)            // Initialize sum register a4 with 0x0
   m4_asm(ADDI, r12, r10, 1010)         // Store count of 10 in register a2.
   m4_asm(ADD, r13, r10, r0)            // Initialize intermediate sum register a3 with 0
   // Loop:
   m4_asm(ADD, r14, r13, r14)           // Incremental addition
   m4_asm(ADDI, r13, r13, 1)            // Increment intermediate register by 1
   m4_asm(BLT, r13, r12, 1111111111000) // If a3 is less than a2, branch to label named <loop>
   m4_asm(ADD, r10, r14, r0)            // Store final result to register a0 so that it can be read by main program
   
   // Optional:
   // m4_asm(JAL, r7, 00000000000000000000) // Done. Jump to itself (infinite loop). (Up to 20-bit signed immediate plus implicit 0 bit (unlike JALR) provides byte address; last immediate bit should also be 0)
   m4_define_hier(['M4_IMEM'], M4_NUM_INSTRS)

   |cpu
      @0
         $reset = *reset;
         //$start = (>>1$reset && !$reset);         //Start is to provide first $valid pulse   
         //$valid = $reset ?  1'b0 : ($start || >>3$valid );      // This valis is going to be high every third clock cycle whcih will allow the pipeline to take the next input
         
         $pc[31:0] = >>1$reset ? 32'd0 : (>>3$valid_taken_branch ? >>3$br_tgt_pc : >>1$pc + 32'd4); 
                                                              // Here we are taking the output of previour piplened value of $valid_taken_branch, 3$br_tgt_pc and >>3$pc      
      @3
         $valid = !(>>1$valid_taken_branch || >>2$valid_taken_branch);      // here valid will be high when we get a branch instruction and SKIP 2 STAGE IN PIPELINE
      @1   
         //$inc_pc[31:0] = $pc + 32'd4 ;
         // Instruction Fetch
         $imem_rd_en = !$reset;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_INDEX_CNT+1:2];     // $imem_rd_addr is going to m4+imem(@1) vinding the vakue of that address    
         $instr[31:0] = $imem_rd_en ? $imem_rd_data[31:0]: 32'b0;               // and returning it in $imem_rd_data[31:0]
      @1
         //Instruction Decode
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||   // ==? is used to compare the binary don't cares
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b11100;
         
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:7]} :
                      $is_b_instr ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0} :
                      $is_u_instr ? {$instr[31:12], 12'b0} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                                    32'b0;
         $opcode[6:0] = $instr[6:0];
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
            
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
            
         $funct7_valid = $is_r_instr ;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
            
         $dec_bits[10:0] = {$funct7[5], $funct3, $opcode};
         $is_beq = $dec_bits ==? 11'bx_000_1100011;
         $is_bne = $dec_bits ==? 11'bx_001_1100011;
         $is_blt = $dec_bits ==? 11'bx_100_1100011;
         $is_bge = $dec_bits ==? 11'bx_101_1100011;
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         $is_add = $dec_bits ==? 11'b0_000_0110011;
      @2
         //Register File Read
         $rf_rd_en1 = $rs1_valid && >>2$result ; //if two-stage back result and ISA has rs1 register then only read the value from ISA
         $rf_rd_index1[4:0] = $rs1;  //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data1 of 32-bit, which is the value stored in that register
         $rf_rd_en2 = $rs2_valid && >>2$result;   //if two-stage back result and ISA has rs2 register then only read the value from ISA
         $rf_rd_index2[4:0] = $rs2;   //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data2 of 32-bit, which is the value stored in that register
         $src1_value[31:0] = >>1$rf_wr_en && (>>1$rf_wr_index == $rs1) ? (>>1$result) : $rf_rd_data1;   //if the previous destination register address matches the source register address and if the previous instruction result was written in the RISC V register($rf_wr_en is high) then only store the last result of the result else result date coming out from m4+rf
         $src2_value[31:0] = >>1$rf_wr_en && (>>1$rf_wr_index == $rs2) ? (>>1$result) : $rf_rd_data2;  //if the previous destination register address matches the source register address and if the previous instruction result was written in the RISC V register ($rf_wr_en is high) then only store the last result of the result else result date coming out from m4+rf
                                                                  // $rf_wr_index = $rd; $rf_rd_index1 = rs1 ; $rf_rd_index2 = rs2 
      @3
         //ALU
         $result[31:0] = $is_addi ? $src1_value + $imm :
                         $is_add ? $src1_value + $src2_value :
                         32'bx ;
      @3
         //Register File Write                  // $rd_valid = 1 when ISA have rd its instruction 
         $rf_wr_en_1 = $rd_valid && $rd != 5'b0;  // if $rd_valid =0 or $rd =0 then then $rf_wr_en is 0
         $rf_wr_en = $rf_wr_en_1 && $valid;
         $rf_wr_index[4:0] = $rd;                              // $rd=0(because x0 register of RISC-V always stores vale 32'b0 so can't be rewritten ) 
         $rf_wr_data[31:0] = $result;       // $result is coming from ALU and getting stored in $rf_wr_index[4:0] address of RISC-V register         
                                            // having value $rf_wr_data   
      
      @3
         //Branch Instructions
         $taken_branch = $is_beq ? ($src1_value == $src2_value):               //BEQ (Branch if Equal)
                         $is_bne ? ($src1_value != $src2_value):               //BNE (Branch if Not Equal)  
                         $is_blt ? (($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31])):    // BLT (Branch if Less Than)
                         $is_bge ? (($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31])):   //BGE (Branch if Greater Than or Equal)
                         $is_bltu ? ($src1_value < $src2_value):              //BLTU (Branch if Less Than Unsigned)
                         $is_bgeu ? ($src1_value >= $src2_value):             //BGEU (Branch if Greater Than or Equal Unsigned)
                                    1'b0;                 
         $br_tgt_pc[31:0] = $pc + $imm;        // $br_tgt_pc will add the value of %pc value and $imm value which has the stored value of  difference of target address and current address
         $valid_taken_branch = ($valid && $taken_branch) ;  // after every 3 clock cycle when $valid is hihen and $taken_branch is high then $valid_taken_branch is high.
         
         
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
   *failed = 1'b0;
   
   // Macro instantiations for:
   //  o instruction memory
   //  o register file
   //  o data memory
   //  o CPU visualization
   |cpu
      m4+imem(@1)    // Args: (read stage)
      m4+rf(@2, @3)  // Args: (read stage, write stage) - if equal, no register bypass is required
      //m4+dmem(@4)    // Args: (read/write stage)
      //m4+myth_fpga(@0)  // Uncomment to run on FPGA

   m4+cpu_viz(@4)    // For visualization, the argument should equal the last stage of CPU logic. @4 would work for all labs.
\SV
   endmodule
```
![Screenshot (2889)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/d084c50e-324e-4c77-a2e1-e7798fce8a56)

- [MICROCHIP FINAL PROJECT URL](https://myth.makerchip.com/sandbox/0PNf4h03q/00ghLV#)
### Completing Instruction Decode
---

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/e58af229-0a41-4ae8-a2e0-9fa0daf16aef"

- Previously, we only added add and branch instructions in the Instruction Decode, so now we will add other instructions also.

```verilog
      @1   //Instruction Decode previously done
         $dec_bits[10:0] = {$funct7[5], $funct3, $opcode};
         $is_beq = $dec_bits ==? 11'bx_000_1100011;                     
         $is_bne = $dec_bits ==? 11'bx_001_1100011;                       //BNE (Branch if Not Equal)
         $is_blt = $dec_bits ==? 11'bx_100_1100011;                       // BLT (Branch if Less Than)    
         $is_bge = $dec_bits ==? 11'bx_101_1100011;                        //BGE (Branch if Greater Than or Equal)
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;                       //BLTU (Branch if Less Than Unsigned)
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;                       //BGEU (Branch if Greater Than or Equal Unsigned)
         $is_addi = $dec_bits ==? 11'bx_000_0010011;                       // addi (Add Immediate)
         $is_add = $dec_bits ==? 11'b0_000_0110011;                        // add (Add two registers)   

            //Instruction Decode added
	 $is_load = $dec_bits ==? 11'bx_xxx_0000011;                    // all load instructions(LB(Load Byte),LH(Load Halfword),LW(Load Word),LBU(Load Byte Unsigned),LHU(Load Halfword Unsigned))
         $is_sb = $dec_bits ==? 11'bx_000_0100011;                      //SB (Store Byte)Stores the lowest byte of a register into memory.
         $is_sh = $dec_bits ==? 11'bx_001_0100011;                      //SH  (Store Halfword)Stores the lowest 16 bits of a register into memory.
         $is_sw = $dec_bits ==? 11'bx_010_0100011;                       // SW (Store Word)Stores a 32-bit value from a register into memory.
         $is_slti = $dec_bits ==? 11'bx_010_0010011;                     // SLTI (Set Less Than Immediate)Sets a target register to 1 if the source register is less than a signed immediate value; otherwise, sets it to 0.
         $is_sltiu = $dec_bits ==? 11'bx_011_0010011;                    // SLTIU (Set Less Than Immediate Unsigned)Sets a target register to 1 if the source register is less than an unsigned immediate value; otherwise, sets it to 0.       
         $is_xori = $dec_bits ==? 11'bx_100_0010011;                     // XORI (XOR Immediate) Performs a bitwise XOR operation between a register and an immediate value, storing the result in a target register.
         $is_ori = $dec_bits ==? 11'bx_110_0010011;                      // ORI (OR Immediate)Performs a bitwise OR operation between a register and an immediate value, storing the result in a target register.
         $is_andi = $dec_bits ==? 11'bx_111_0010011;                     // ANDI (AND Immediate) Performs a bitwise AND operation between a register and an immediate value, storing the result in a target register.
         $is_slli = $dec_bits ==? 11'b0_001_0010011;                     // ANDI (AND Immediate) Performs a bitwise AND operation between a register and an immediate value, storing the result in a target register.
         $is_srli = $dec_bits ==? 11'b0_101_0010011;                     // SRLI (Shift Right Logical Immediate) Performs a logical right shift on a source register by a specified immediate value and stores the result in a target register.
         $is_srai = $dec_bits ==? 11'b1_101_0010011;                     // SRLI (Shift Right Logical Immediate) Performs a logical right shift on a source register by a specified immediate value and stores the result in a target register.
         $is_sub = $dec_bits ==? 11'b1_000_0110011;                     // SUB (Subtract) Subtracts the value of one register from another and stores the result in a target register.
         $is_sll = $dec_bits ==? 11'b0_001_0110011;                     // SLL (Shift Left Logical) Performs a logical left shift on the value in one register by the number of bits specified in another register and stores the result in a target register.
         $is_slt = $dec_bits ==? 11'b0_010_0110011;                     // SLT (Set Less Than) Sets a target register to 1 if the value in one register is less than the value in another register; otherwise, sets it to 0.
         $is_sltu = $dec_bits ==? 11'b0_011_0110011;                     // SLTU (Set Less Than Unsigned) Sets a target register to 1 if the value in one register is less than the value in another register (unsigned comparison); otherwise, sets it to 0.
         $is_xor = $dec_bits ==? 11'b0_100_0110011;                      // XOR (Bitwise XOR) Performs a bitwise XOR operation between two registers and stores the result in a target register.
         $is_srl = $dec_bits ==? 11'b0_101_0110011;                     // XOR (Bitwise XOR) Performs a bitwise XOR operation between two registers and stores the result in a target register.
         $is_sra = $dec_bits ==? 11'b1_101_0110011;                     // SRA (Shift Right Arithmetic) Arithmetic right shift of a register value. It preserves the sign bit.
         $is_or = $dec_bits ==? 11'b0_110_0110011;                      // OR (Bitwise OR) Performs a bitwise OR operation between two registers and stores the result in a target register.  
         $is_and = $dec_bits ==? 11'b0_111_0110011;                     // OR (Bitwise OR) Performs a bitwise OR operation between two registers and stores the result in a target register.
         $is_lui = $dec_bits ==? 11'bx_xxx_0110111;                   // LUI (Load Upper Immediate) Loads a 16-bit immediate value into the upper bits of a register. Lower bits are set to zero. 
         $is_auipc = $dec_bits ==? 11'bx_xxx_0010111;                  // AUIPC (Add Upper Immediate to PC) Adds a 16-bit immediate value to the current instruction's address. The result is stored in a register.
         $is_jal = $dec_bits ==? 11'bx_xxx_1101111;                    // JAL (Jump and Link) Unconditionally jumps to a target address. Saves the return address in a register.            
         $is_jalr = $dec_bits ==? 11'bx_000_1100111;                   // JALR (Jump and Link Register) Jumps to an address in a register. Saves the return address in a register.  
         $is_jump = $is_jal || $is_jalr ;                             // Jump (J) Unconditionally jumps to a specified target address.
```        

### Completing ALU Design

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/37ff59cd-17ad-4aed-84c9-6322238cb66a"

- Here we have added the core to execute some left Instruction of ALU.
	    
```verilog
      @3
         $sltu_rslt[31:0] = $src1_value < $src2_value;  // variable declared for $is_slt Instruction
         $sltiu_rslt[31:0]  = $src1_value < $imm;       // variable declared for $is_slti Instruction
         
         $result[31:0] =
              $is_addi ? $src1_value + $imm :
              $is_add ? $src1_value + $src2_value :
              $is_andi ? $src1_value & $imm :
              $is_ori  ? $src1_value | $imm :
              $is_xori ? $src1_value ^ $imm :
              $is_slli ? $src1_value << $imm[5:0] :
              $is_srli ? $src1_value >> $imm[5:0] :
              $is_and ? $src1_value & $src2_value :
              $is_or ? $src1_value | $src2_value :
              $is_xor ? $src1_value ^ $src2_value :
              $is_sub ? $src1_value - $src2_value :
              $is_sll ? $src1_value << $src2_value[4:0] :
              $is_srl ? $src1_value >> $src2_value[4:0] :
              $is_sltu ? $src1_value < $src2_value :
              $is_sltiu ? $src1_value < $imm :
              $is_lui ? {$imm[31:12], 12'b0} :
              $is_auipc ? $pc + $imm : 
              $is_jal ? $pc + 32'd4 :
              $is_jalr ? $pc + 32'd4 :
              $is_srai ? {{32{$src1_value[31]}}, $src1_value} >> $imm[4:0] :
              $is_slt ? ($src1_value[31] == $src2_value[31]) ? $sltu_rslt : {31'b0, $src1_value[31]} :
              $is_slti ? ($src1_value[31] == $imm[31]) ? $sltiu_rslt : {31'b0, $src1_value[31]} :
              $is_sra ? {{32{$src1_value[31]}}, $src1_value} >> $src2_value[4:0] :
              $is_load || $is_s_instr ? $src1_value + $imm :            // if there is load instruction or S-type(only type of ISA which have store instruction) ISA then result will be  $src1_value + $imm which is address of the main memory
              32'bx ;
```
### Adding Load/Store Instructions
--- 
- In Load Instruction in RISC-V loads the register rd(destination register) with the data stores in the rs1(address) + immediate from the main memory.
- In Store Instruction in RISC-V stores the value in register rd(destination register) to the address of register rs1(address) +immediate of main memory.
#### Load Instructions
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/f2fd89eb-f16d-48d4-86b1-2d48494bfda7"

- TL Verilog code for logic of Load Instructions.
  
```verilog
      @0
         $pc[31:0] = >>1$reset ? 32'd0 :
                       (>>3$valid_taken_branch ? >>3$br_tgt_pc :                 //If we get a valid load in the third last cycle, skip the pc increment for 
                            (>>3$valid_load ? >>3$pc+32'd4 :                     // 2 times else do whatever it was doing before.
                                    (>>1$pc + 32'd4));  
                      // changed from $pc[31:0] = >>1$reset ? 32'd0 : (>>3$valid_taken_branch ? >>3$br_tgt_pc : >>1$pc + 32'd4);   
      @3             // changed from $valid = !(>>1$valid_taken_branch || >>2$valid_taken_branch)      
         $valid = !(>>1$valid_taken_branch || >>2$valid_taken_branch || >>1$valid_load || >>2$valid_load );  // if we get branch or load instruction then $valid is high and it skip 2 cycle
         $valid_load = $valid && $is_load ; // $valid_load is high only when we get a valid high, and there is a load instruction in the pipeline
                 
```
#### Store Instructions
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/a4cd2176-983e-4abf-b202-cbfb796bdc83"
	    
- TL Verilog code for logic of Store Instructions.
- 
```verilog
    @3                      // changed from $rf_wr_en = $rf_wr_en_1 && $valid;                   // Here ($rf_wr_en_1 = $rd_valid && $rd != 5'b0)
        $rf_wr_en = $rf_wr_en_1 && ($valid ||>>2$valid_load); // $rf_wr_en is enable write when load instruction was there before two-cycle
        $rf_wr_index[4:0] = >>2$valid_load ? >>2$rd : $rd ;
        $rf_wr_data[31:0] = >>2$valid_load ? >>2$ld_data : $result;      // if there is a load instruction, then load the data in the data in $rf_wr_data  else normal working of the pipeline   
                           //  changed from $rf_wr_data[31:0] = $result;                ``
```
### Designing of Data Memory
---
<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/374abde9-6a03-46b3-8bde-a51caf185fcd"

- We need to uncomment the macro(`m4+dmem(@4)`) of data memory instantiation, which provides the immediate data memory. It has 16 entities, each 32-bit wide 
```verilog
      @4
         $dmem_wr_en = $is_s_instr && $valid ; //$dmem_wr_en of is enable pin to m4+dmem(@4)  // $valis is high and S-type(only type of ISA which have store instruction) ISA 
         $dmem_addr[3:0] = $result[5:2];      // sending the address of data memory through which we need data.//Here we are only supporting the word operations and the address is a byte
                                              // address so we assume it's aligned such that the lower 2 bits of $result can be ignored (because only 16 entries are possible, so main memory has only 4 bit address)
         $dmem_wr_data[31:0] = $src2_value ;   // to write data in memory address
         $dmem_rd_en = $is_load ;             // enable pin to read the data if load instruction came
         $ld_data[31:0] = $dmem_rd_data ;   // taking output from memory and giving it back
```

- So we assigned Machine code to load and store the data in the main memory
```
   m4_asm(SW, r0, r10, 100)   // stores the value in r10 in address 4 of main memory(r0+4) after the loop completes
   m4_asm(LW, r15, r0, 100)   //Again we will load the value from the same address 4 in the r15 register
   // we need to change the coding in the passed to check the r15 register instead of the r10 ( *passed = |cpu/xreg[15]>>5$value == (1+2+3+4+5+6+7+8+9);)

```

### Adding Jump Instruction
- There are two types of jump instruction.
1. **JAL(jump and link):** Jump to an address "(PC+imm)"
2. **JALR(jump and link to register):** Jump to address "src1+imm"

<p align="center">
    <img src="https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/2b113d11-b362-487a-a710-da5d923b0da3"

- - TL Verilog code for logic of Jump Instructions.
```verilog
     @0              // previously was  $pc[31:0] = >>1$reset ? 32'd0 : (>>3$valid_taken_branch ? >>3$br_tgt_pc : (>>3$valid_load ? >>3$pc+32'd4 : (>>1$pc + 32'd4)); 
        $pc[31:0] = >>1$reset ? 32'd0 :
                       (>>3$valid_taken_branch ? >>3$br_tgt_pc :
                             (>>3$valid_load ? >>3$pc+32'd4 :
                                   ((>>3$valid_jump && >>3$is_jal) ? >>3$br_tgt_pc :   // $br_tgt_pc is used again for JAL (PC+imm) which was previously used for branch instruction(PC +imm)
                                           (>>3$valid_jump && >>3$is_jalr) ? >>3$jalr_tgt_pc :
                                                  (>>1$pc + 32'd4)); 
     @3
        $valid = !(>>1$valid_taken_branch || >>2$valid_taken_branch
                     || >>1$valid_load || >>2$valid_load 
                          || >>1$valid_jump || >>2$valid_jump) ;
        $valid_jump = $valid && $is_jump;
        $jalr_tgt_pc[31:0] = $src1_value + $imm ; // if Jump to address "src1+imm"
```

### Final Design of Pipelined and Optimized RISC-V CPU micro-architecture
---
#### Final TL Verilog Code of the designed RISC-V CPU micro-architecture
- [FINAL MAKERCHIP PROJECT LINK](https://myth.makerchip.com/sandbox/0PNf4h03q/00ghLV#)
```verilog
\m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/RISC-V_MYTH_Workshop
   
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/RISC-V_MYTH_Workshop/master/tlv_lib/risc-v_shell_lib.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV

   // /====================\
   // | Sum 1 to 9 Program |
   // \====================/
   //
   // Program for MYTH Workshop to test RV32I
   // Add 1,2,3,...,9 (in that order).
   //
   // Regs:
   //  r10 (a0): In: 0, Out: final sum
   //  r12 (a2): 10
   //  r13 (a3): 1..10
   //  r14 (a4): Sum
   // 
   // External to function:
   m4_asm(ADD, r10, r0, r0)             // Initialize r10 (a0) to 0.
   // Function:
   m4_asm(ADD, r14, r10, r0)            // Initialize sum register a4 with 0x0
   m4_asm(ADDI, r12, r10, 1010)         // Store count of 10 in register a2.
   m4_asm(ADD, r13, r10, r0)            // Initialize intermediate sum register a3 with 0
   // Loop:
   m4_asm(ADD, r14, r13, r14)           // Incremental addition
   m4_asm(ADDI, r13, r13, 1)            // Increment intermediate register by 1
   m4_asm(BLT, r13, r12, 1111111111000) // If a3 is less than a2, branch to label named <loop>
   m4_asm(ADD, r10, r14, r0)            // Store final result to register a0 so that it can be read by main program
   m4_asm(SW, r0, r10, 100)
   m4_asm(LW, r15, r0, 100)
   
   // Optional:
   // m4_asm(JAL, r7, 00000000000000000000) // Done. Jump to itself (infinite loop). (Up to 20-bit signed immediate plus implicit 0 bit (unlike JALR) provides byte address; last immediate bit should also be 0)
   m4_define_hier(['M4_IMEM'], M4_NUM_INSTRS)

   |cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? 32'd0 :
                        (>>3$valid_taken_branch ? >>3$br_tgt_pc :
                             (>>3$valid_load ? >>3$pc+32'd4 :
                                   ((>>3$valid_jump && >>3$is_jal) ? >>3$br_tgt_pc :   // $br_tgt_pc is used again for JAL (PC+imm) which was previously used for branch instruction(PC +imm)
                                           ((>>3$valid_jump && >>3$is_jalr) ? >>3$jalr_tgt_pc :
                                                (>>1$pc + 32'd4)))));                                                  // Here we are taking the output of previous pipeline value of $valid_taken_branch, 3$br_tgt_pc and >>3$pc      
      @3
         $valid = !(>>1$valid_taken_branch || >>2$valid_taken_branch
                     || >>1$valid_load || >>2$valid_load 
                          || >>1$valid_jump || >>2$valid_jump) ;
         $valid_load = $valid && $is_load ; // $valid_load is high only when we get a valid high and there is a load instruction in the pipeline// here valid will be high when we get a branch instruction and SKIP 2 STAGE IN PIPELINE
         $valid_jump = $valid && $is_jump;
         $jalr_tgt_pc[31:0] = $src1_value + $imm ; // if Jump to address "src1+imm"
      @1   
         // Instruction Fetch
         $imem_rd_en = !>>1$reset;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_INDEX_CNT+1:2];     // $imem_rd_addr is going to m4+imem(@1) finding the value of that address    
         $instr[31:0] = $imem_rd_en ? $imem_rd_data[31:0]: 32'b0;               // and returning it in $imem_rd_data[31:0]
      @1
         //Instruction Decode
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||   // ==? is used to compare the binary don't cares
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b11100;
         
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:7]} :
                      $is_b_instr ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0} :
                      $is_u_instr ? {$instr[31:12], 12'b0} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                                    32'b0;
         $opcode[6:0] = $instr[6:0];
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
            
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
            
         $funct7_valid = $is_r_instr ;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
            
         $dec_bits[10:0] = {$funct7[5], $funct3, $opcode};
         $is_beq = $dec_bits ==? 11'bx_000_1100011;                     //BEQ (Branch if Equal)
         $is_bne = $dec_bits ==? 11'bx_001_1100011;                     //BEQ (Branch if Equal)
         $is_blt = $dec_bits ==? 11'bx_100_1100011;                     // BLT (Branch if Less Than)
         $is_bge = $dec_bits ==? 11'bx_101_1100011;                     //BGE (Branch if Greater Than or Equal)
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;                    //BGE (Branch if Greater Than or Equal)
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;                    //BGE (Branch if Greater Than or Equal)
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         $is_add = $dec_bits ==? 11'b0_000_0110011;
         $is_load = $dec_bits ==? 11'bx_xxx_0000011;                    // all load instructions(LB(Load Byte),LH(Load Halfword),LW(Load Word),LBU(Load Byte Unsigned),LHU(Load Halfword Unsigned))
         $is_sb = $dec_bits ==? 11'bx_000_0100011;                      //SB (Store Byte)Stores the lowest byte of a register into memory.
         $is_sh = $dec_bits ==? 11'bx_001_0100011;                      //SH  (Store Halfword)Stores the lowest 16 bits of a register into memory.
         $is_sw = $dec_bits ==? 11'bx_010_0100011;                       // SW (Store Word)Stores a 32-bit value from a register into memory.
         $is_slti = $dec_bits ==? 11'bx_010_0010011;                     // SLTI (Set Less Than Immediate)Sets a target register to 1 if the source register is less than a signed immediate value; otherwise, sets it to 0.
         $is_sltiu = $dec_bits ==? 11'bx_011_0010011;                    // SLTIU (Set Less Than Immediate Unsigned)Sets a target register to 1 if the source register is less than an unsigned immediate value; otherwise, sets it to 0.       
         $is_xori = $dec_bits ==? 11'bx_100_0010011;                     // XORI (XOR Immediate) Performs a bitwise XOR operation between a register and an immediate value, storing the result in a target register.
         $is_ori = $dec_bits ==? 11'bx_110_0010011;                      // ORI (OR Immediate)Performs a bitwise OR operation between a register and an immediate value, storing the result in a target register.
         $is_andi = $dec_bits ==? 11'bx_111_0010011;                     // ANDI (AND Immediate) Performs a bitwise AND operation between a register and an immediate value, storing the result in a target register.
         $is_slli = $dec_bits ==? 11'b0_001_0010011;                     // ANDI (AND Immediate) Performs a bitwise AND operation between a register and an immediate value, storing the result in a target register.
         $is_srli = $dec_bits ==? 11'b0_101_0010011;                     // SRLI (Shift Right Logical Immediate) Performs a logical right shift on a source register by a specified immediate value and stores the result in a target register.
         $is_srai = $dec_bits ==? 11'b1_101_0010011;                     // SRLI (Shift Right Logical Immediate) Performs a logical right shift on a source register by a specified immediate value and stores the result in a target register.
         $is_sub = $dec_bits ==? 11'b1_000_0110011;                     // SUB (Subtract) Subtracts the value of one register from another and stores the result in a target register.
         $is_sll = $dec_bits ==? 11'b0_001_0110011;                     // SLL (Shift Left Logical) Performs a logical left shift on the value in one register by the number of bits specified in another register and stores the result in a target register.
         $is_slt = $dec_bits ==? 11'b0_010_0110011;                     // SLT (Set Less Than) Sets a target register to 1 if the value in one register is less than the value in another register; otherwise, sets it to 0.
         $is_sltu = $dec_bits ==? 11'b0_011_0110011;                     // SLTU (Set Less Than Unsigned) Sets a target register to 1 if the value in one register is less than the value in another register (unsigned comparison); otherwise, sets it to 0.
         $is_xor = $dec_bits ==? 11'b0_100_0110011;                      // XOR (Bitwise XOR) Performs a bitwise XOR operation between two registers and stores the result in a target register.
         $is_srl = $dec_bits ==? 11'b0_101_0110011;                     // XOR (Bitwise XOR) Performs a bitwise XOR operation between two registers and stores the result in a target register.
         $is_sra = $dec_bits ==? 11'b1_101_0110011;                     // SRA (Shift Right Arithmetic) Arithmetic right shift of a register value. It preserves the sign bit.
         $is_or = $dec_bits ==? 11'b0_110_0110011;                      // OR (Bitwise OR) Performs a bitwise OR operation between two registers and stores the result in a target register.  
         $is_and = $dec_bits ==? 11'b0_111_0110011;                     // OR (Bitwise OR) Performs a bitwise OR operation between two registers and stores the result in a target register.
         $is_lui = $dec_bits ==? 11'bx_xxx_0110111;                    // LUI (Load Upper Immediate) Loads a 16-bit immediate value into the upper bits of a register. Lower bits are set to zero. 
         $is_auipc = $dec_bits ==? 11'bx_xxx_0010111;                  // AUIPC (Add Upper Immediate to PC) Adds a 16-bit immediate value to the current instruction's address. The result is stored in a register.
         $is_jal = $dec_bits ==? 11'bx_xxx_1101111;                    // JAL (Jump and Link) Unconditionally jumps to a target address. Saves the return address in a register.            
         $is_jalr = $dec_bits ==? 11'bx_000_1100111;                   // JALR (Jump and Link Register) Jumps to an address in a register. Saves the return address in a register.  
         $is_jump = $is_jal || $is_jalr ;                              // Jump (J) Unconditionally jumps to a specified target address.
      
      
      
      @2
         //Register File Read
         $rf_rd_en1 = $rs1_valid && >>2$result ; //if two-stage back result and ISA has rs1 register then only read the value from ISA
         $rf_rd_index1[4:0] = $rs1;  //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data1 of 32-bit, which is the value stored in that register
         $rf_rd_en2 = $rs2_valid && >>2$result;   //if two-stage back result and ISA has rs2 register then only read the value from ISA
         $rf_rd_index2[4:0] = $rs2;   //m4+rf(@1, @1) takes input $rf_rd_index1[4:0] (which is index value of register of RISC-V)
                                     // and return its value as $rf_rd_data2 of 32-bit, which is the value stored in that register
         $src1_value[31:0] = >>1$rf_wr_en && (>>1$rf_wr_index == $rs1) ? (>>1$result) : $rf_rd_data1;   //if the previous destination register address matches the source register address and if the previous instruction result was written in RISC V register($rf_wr_en is high) then only store the last result of result else result date coming out from m4+rf
         $src2_value[31:0] = >>1$rf_wr_en && (>>1$rf_wr_index == $rs2) ? (>>1$result) : $rf_rd_data2;  //if the previous destination register address matches the source register address and if the previous instruction result was written in RISC V register ($rf_wr_en is high) then only store the last result of result else result date coming out from m4+rf
                                                                  // $rf_wr_index = $rd; $rf_rd_index1 = rs1 ; $rf_rd_index2 = rs2 
      @3
         //Full Designed ALU
         $sltu_rslt[31:0] = $src1_value < $src2_value;  // variable declared for $is_slt Instruction
         $sltiu_rslt[31:0]  = $src1_value < $imm;       // variable declared for $is_slti Instruction
         
         $result[31:0] =
              $is_addi ? $src1_value + $imm :
              $is_add ? $src1_value + $src2_value :
              $is_andi ? $src1_value & $imm :
              $is_ori  ? $src1_value | $imm :
              $is_xori ? $src1_value ^ $imm :
              $is_slli ? $src1_value << $imm[5:0] :
              $is_srli ? $src1_value >> $imm[5:0] :
              $is_and ? $src1_value & $src2_value :
              $is_or ? $src1_value | $src2_value :
              $is_xor ? $src1_value ^ $src2_value :
              $is_sub ? $src1_value - $src2_value :
              $is_sll ? $src1_value << $src2_value[4:0] :
              $is_srl ? $src1_value >> $src2_value[4:0] :
              $is_sltu ? $src1_value < $src2_value :
              $is_sltiu ? $src1_value < $imm :
              $is_lui ? {$imm[31:12], 12'b0} :
              $is_auipc ? $pc + $imm : 
              $is_jal ? $pc + 32'd4 :
              $is_jalr ? $pc + 32'd4 :
              $is_srai ? {{32{$src1_value[31]}}, $src1_value} >> $imm[4:0] :
              $is_slt ? ($src1_value[31] == $src2_value[31]) ? $sltu_rslt : {31'b0, $src1_value[31]} :
              $is_slti ? ($src1_value[31] == $imm[31]) ? $sltiu_rslt : {31'b0, $src1_value[31]} :
              $is_sra ? {{32{$src1_value[31]}}, $src1_value} >> $src2_value[4:0] :
              $is_load || $is_s_instr ? $src1_value + $imm :            // if there is load instruction or S-type(only type of ISA which have store instruction) ISA then result will be  $src1_value + $imm which is address of the main memory
              32'bx ;                   
      @3                     
         //Register file write
         $rf_wr_en_1 = $rd_valid && $rd != 5'b0;  // if $rd_valid =0 or $rd =0 then then $rf_wr_en is 0
         $rf_wr_en = $rf_wr_en_1 && $valid ||>>2$valid_load; // $rf_wr_en is enable write when load instruction was there before two-cycle
         $rf_wr_index[4:0] = >>2$valid_load ? >>2$rd : $rd ;
         $rf_wr_data[31:0] = >>2$valid_load ? >>2$ld_data : $result;      // if there is a load instruction, then load the data in the data in $rf_wr_data  else, normal working of the pipeline   
      @3
         //Branch Instructions
         $taken_branch = $is_beq ? ($src1_value == $src2_value):               //BEQ (Branch if Equal)
                         $is_bne ? ($src1_value != $src2_value):               //BNE (Branch if Not Equal)  
                         $is_blt ? (($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31])):    // BLT (Branch if Less Than)
                         $is_bge ? (($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31])):   //BGE (Branch if Greater Than or Equal)
                         $is_bltu ? ($src1_value < $src2_value):              //BLTU (Branch if Less Than Unsigned)
                         $is_bgeu ? ($src1_value >= $src2_value):             //BGEU (Branch if Greater Than or Equal Unsigned)
                                    1'b0;                 
         $valid_taken_branch = ($valid && $taken_branch) ;  // after every 3 clock cycle when $valid is hihen and $taken_branch is high then $valid_taken_branch is high.
      @2 
         $br_tgt_pc[31:0] = $pc + $imm;
         //$br_tgt_pc[31:0] = $pc + $imm;        // $br_tgt_pc will add the value of %pc value and $imm value which has the stored value of  difference of target address and current address
      @4
         $dmem_wr_en = $is_s_instr && $valid ; //$dmem_wr_en of is enable pin to m4+dmem(@4)  // $valis is high and S-type(only type of ISA which have store instruction) ISA 
         $dmem_addr[3:0] = $result[5:2];      // sending the address of data memory through which we need data.//Here we are only supporting the word operations, and the address is a byte
                                              // address, so we assume it's aligned such that the lower 2 bits of $result can be ignored (because only 16 entries are possible, so main memory has only 4 bit address)
         $dmem_wr_data[31:0] = $src2_value ;   // to write data in memory address
         $dmem_rd_en = $is_load ;             // enable pin to read the data if load instruction came
         $ld_data[31:0] = $dmem_rd_data ;   // taking output from memory and giving it back  
         
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = |cpu/xreg[15]>>5$value == (1+2+3+4+5+6+7+8+9);
   *failed = 1'b0;
   
   // Macro instantiations for:
   //  o instruction memory
   //  o register file
   //  o data memory
   //  o CPU visualization
   |cpu
      m4+imem(@1)    // Args: (read stage)
      m4+rf(@2, @3)  // Args: (read stage, write stage) - if equal, no register bypass is required
      m4+dmem(@4)    // Args: (read/write stage)
      //m4+myth_fpga(@0)  // Uncomment to run on fpga

   m4+cpu_viz(@4)    // For visualization, the argument should be equal to the last stage of CPU logic. @4 would work for all labs.
\SV
   endmodule
```

![Screenshot (2898)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/d9df3c88-6fcc-4430-9b72-0b3b119cf3a7)


### Block Diagram of the designed RISC-V Architecture
![Screenshot (2899)](https://github.com/abhinavprakash199/RISC-V-based-MYTH/assets/120498080/5910fca9-1e88-43a8-a370-9396430acfe7)

## All commands of Linux
---
- `leafpad <file_name>.c` Command to make a c file in Leafpad.
- To run the .c file use `gcc <filename>.c`(if there are no errors in the code, we will get an executable file with the default name a.out), then run this executable by executing `./a.out'.
- `cat <filename>.c` is used to display the contents of a file with a.c extension in the terminal
- `| less` combination is commonly used to paginate and view long text output one screen at a time.

## Appendix
---
- **`sum1ton.o`**: This is an object file likely generated from source code, possibly C or assembly, that contains compiled code for a program that calculates the sum of numbers from 1 to n.
- **`load.s`**: A source code file, typically in assembly language, that contains instructions for loading or initializing a program, often used in embedded systems.
- **`rv32im.sh`**: A shell script file configuring or managing a RISC-V RV32IM processor, possibly for setting up an environment or running a program on the processor.
- **`firmware.hex`**: A hexadecimal file containing data or instructions, often used for initializing memory or configuring hardware components in digital design.
- **`firmware32.hex`**: Similar to firmware.hex, but specific to a 32-bit system or processor.
- **`testbench.vcd`**: A VCD (Value Change Dump) file generated during digital simulation, containing data about signal values and changes over time for debugging and analysis.
- **`testbench.vvp`**: A Verilog simulation output file that results from compiling a testbench and design files, which can be executed to simulate and analyze the behavior of a digital design.
  
## References
---
- [RISC-V based MYTH](https://www.vlsisystemdesign.com/riscv-based-myth/?awt_a=5L_6&awt_l=H2Nw0&awt_m=3l0nDqaoscA8._6)
- [RISC-V_MYTH_Workshop by Steve](https://github.com/stevehoover/RISC-V_MYTH_Workshop)
- [RISC-V Commands](https://gcc.gnu.org/onlinedocs/gcc/RISC-V-Options.html)
- [RISC-V Installation](https://github.com/kunalg123/riscv_workshop_collaterals/blob/master/run.sh)
- [TL Verilog Projects](https://github.com/TL-X-org/TL-V_Projects)



## Acknowledgement
---
Finally, I would like to express my sincere gratitude to [Kunal Ghosh](https://www.linkedin.com/in/kunal-ghosh-vlsisystemdesign-com-28084836/){Co-founder of VLSI System Design (VSD) Corp. Pvt. Ltd.} and [Steve Hoover](https://www.linkedin.com/in/steve-hoover-a44b607/){founder of [Redwood EDA](https://www.redwoodeda.com/)} for help me in understanding the RISC-V architecture. The workshop was excellent and well-designed, this workshop taught about TL-Verilog Coding and Piplened RISC-V Architecture. Piplening was quite challenging but I was able to it with the help of such amazing mentors.

## Accreditation
---
- To be added.....!
## Inquiries
---
- Connect with me at [LinkedIn](https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile
