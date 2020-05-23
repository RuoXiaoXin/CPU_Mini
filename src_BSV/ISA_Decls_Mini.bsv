package ISA_Decls_Mini;

// ================================================================
// XLEN and related constants

typedef 32 XLEN;

typedef  Bit #(XLEN)  WordXL;    // Raw (unsigned) register data
typedef  Int #(XLEN)  IntXL;     //  register data

typedef  WordXL       Addr;      // addresses/pointers

// ================================================================
// Instruction fields

typedef  Bit #(32)  Instr;
typedef  Bit #(7)   Opcode;
typedef  Bit #(5)   RegName;       // 32 registers, 0..31
typedef  Bit #(12)  CSR_Addr;

function  Opcode     instr_opcode   (Instr x); return x [6:0]; endfunction

function  Bit #(3)   instr_funct3   (Instr x); return x [14:12]; endfunction
function  Bit #(7)   instr_funct7   (Instr x); return x [31:25]; endfunction
function  Bit #(10)  instr_funct10  (Instr x); return { x [31:25], x [14:12] }; endfunction

function  RegName    instr_rd       (Instr x); return x [11:7]; endfunction
function  RegName    instr_rs1      (Instr x); return x [19:15]; endfunction
function  RegName    instr_rs2      (Instr x); return x [24:20]; endfunction
function  CSR_Addr   instr_csr      (Instr x); return unpack(x [31:20]); endfunction

//这个是ADDI或者LOAD指令的格式
function  Bit #(12)  instr_I_imm12  (Instr x);
   return x [31:20];
endfunction

//这个是STORE指令的格式
function  Bit #(12)  instr_S_imm12  (Instr x);
   return { x [31:25], x [11:7] };
endfunction

//这是B型指令的立即数格式
function  Bit #(13)  instr_SB_imm13 (Instr x);
   return { x [31], x [7], x [30:25], x [11:8], 1'b0 };
endfunction

function  Bit #(20)  instr_U_imm20  (Instr x);
   return x [31:12];
endfunction

function  Bit #(21)  instr_UJ_imm21 (Instr x);
   return { x [31], x [19:12], x [20], x [30:21], 1'b0 };
endfunction

// For FENCE decode
function  Bit #(4)   instr_pred (Instr x); return x [27:24]; endfunction
function  Bit #(4)   instr_succ (Instr x); return x [23:20]; endfunction

// ----------------
// Decoded instructions

typedef struct {
   Opcode    opcode;

   RegName   rd;
   RegName   rs1;
   RegName   rs2;
   CSR_Addr  csr;

   Bit #(3)  funct3;
   Bit #(7)  funct7;
   Bit #(10) funct10;

   Bit #(12) imm12_I;
   Bit #(12) imm12_S;
   Bit #(13) imm13_SB;
   Bit #(20) imm20_U;
   Bit #(21) imm21_UJ;

   Bit #(4)  pred;
   Bit #(4)  succ;

   } Decoded_Instr
deriving (FShow, Bits);

function Decoded_Instr fv_decode (Instr instr);
   return Decoded_Instr {opcode:    instr_opcode (instr),

			 rd:        instr_rd       (instr),
			 rs1:       instr_rs1      (instr),
			 rs2:       instr_rs2      (instr),
			 csr:       instr_csr      (instr),

			 funct3:    instr_funct3   (instr),
			 funct7:    instr_funct7   (instr),
			 funct10:   instr_funct10  (instr),

			 imm12_I:   instr_I_imm12  (instr),
			 imm12_S:   instr_S_imm12  (instr),
			 imm13_SB:  instr_SB_imm13 (instr),
			 imm20_U:   instr_U_imm20  (instr),
			 imm21_UJ:  instr_UJ_imm21 (instr),

			 pred:      instr_pred     (instr),
			 succ:      instr_succ     (instr)

			 };
endfunction

// ================================================================
// LOAD/STORE instructions
// ----------------
// Load instructions

Opcode op_LOAD = 7'b00_000_11;

Bit #(3) f3_LB  = 3'b000;
Bit #(3) f3_LH  = 3'b001;
Bit #(3) f3_LW  = 3'b010;
Bit #(3) f3_LBU = 3'b100;
Bit #(3) f3_LHU = 3'b101;

// ----------------
// Store instructions

Opcode op_STORE = 7'b01_000_11;

Bit #(3) f3_SB  = 3'b000;
Bit #(3) f3_SH  = 3'b001;
Bit #(3) f3_SW  = 3'b010;

// ================================================================
// Integer Register-Immediate Instructions

Opcode op_OP_IMM = 7'b00_100_11;

Bit #(3) f3_ADDI  = 3'b000;
Bit #(3) f3_SLLI  = 3'b001;
Bit #(3) f3_SLTI  = 3'b010;
Bit #(3) f3_SLTIU = 3'b011;
Bit #(3) f3_XORI  = 3'b100;

//注意这里，立即数型的右移指令，逻辑右移和算数右移的funct3字段是相同的编码，区分这两条指令在指令的第30位，其他均相同
//而第30位的位置，处于I型指令的立即数字段，分析立即数字段才可以得到是哪一条指令
Bit #(3) f3_SRxI  = 3'b101; 
Bit #(3) f3_SRLI  = 3'b101; 
Bit #(3) f3_SRAI  = 3'b101;

Bit #(3) f3_ORI   = 3'b110;
Bit #(3) f3_ANDI  = 3'b111;

// ================================================================
// Integer Register-Register Instructions

Opcode op_OP = 7'b01_100_11;

Bit #(10) f10_ADD    = 10'b000_0000_000;
Bit #(10) f10_SUB    = 10'b010_0000_000;
Bit #(10) f10_SLL    = 10'b000_0000_001;
Bit #(10) f10_SLT    = 10'b000_0000_010;
Bit #(10) f10_SLTU   = 10'b000_0000_011;
Bit #(10) f10_XOR    = 10'b000_0000_100;
Bit #(10) f10_SRL    = 10'b000_0000_101;
Bit #(10) f10_SRA    = 10'b010_0000_101;
Bit #(10) f10_OR     = 10'b000_0000_110;
Bit #(10) f10_AND    = 10'b000_0000_111;

Bit #(7) funct7_ADD  = 7'b_000_0000;    Bit #(3) funct3_ADD = 3'b_000;
Bit #(7) funct7_SUB  = 7'b_010_0000;    Bit #(3) funct3_SUB = 3'b_000;
Bit #(7) funct7_XOR  = 7'b_000_0000;    Bit #(3) funct3_XOR = 3'b_100;
Bit #(7) funct7_OR   = 7'b_000_0000;    Bit #(3) funct3_OR  = 3'b_110;
Bit #(7) funct7_AND  = 7'b_000_0000;    Bit #(3) funct3_AND = 3'b_111;

// ================================================================
// LUI, AUIPC

Opcode op_LUI   = 7'b01_101_11;
Opcode op_AUIPC = 7'b00_101_11;

// ================================================================
// Control transfer

Opcode  op_BRANCH = 7'b11_000_11;

Bit #(3) f3_BEQ   = 3'b000;
Bit #(3) f3_BNE   = 3'b001;
Bit #(3) f3_BLT   = 3'b100;
Bit #(3) f3_BGE   = 3'b101;
Bit #(3) f3_BLTU  = 3'b110;
Bit #(3) f3_BGEU  = 3'b111;

Opcode op_JAL  = 7'b11_011_11;

Opcode op_JALR = 7'b11_001_11;

Bit #(3) funct3_JALR = 3'b000;

endpackage
