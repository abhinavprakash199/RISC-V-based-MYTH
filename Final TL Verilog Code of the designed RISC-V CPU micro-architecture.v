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