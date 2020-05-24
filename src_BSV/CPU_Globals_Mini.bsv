package CPU_Globals_Mini;

import ISA_Decls_Mini ::*;

Integer dmemSize = 1024;

typedef struct 
{
    Addr        pc;
    Instr       instr;
    Bool        valid_instr;//是否被清空，置为NOP指令
} Data_IF_ID deriving (Bits,FShow);

typedef struct
{
    Bool        branch_EN;
    Addr        branch_target;
} Data_Branch deriving (Bits,FShow);

typedef struct
{
    Addr              pc;
    Decoded_Instr     decoded_instr;
    WordXL            rs1_val;
    WordXL            rs2_val;
    Bool              valid_instr;//是否被清空，置为NOP指令
} Data_ID_EX deriving (Bits,FShow);

typedef struct
{
    Bool        rd_valid;
    RegName     rd;
    WordXL      rd_val;
} Data_Forward deriving (Bits,FShow);

typedef enum
{
    //除了LD，ST都选择这个
    OP_StageMEM_ALU,//写RF，无MEM
    OP_StageMEM_LD,//写RF，读MEM
    OP_StageMEM_ST,//写MEM
    OP_StageMEM_NONE
} OP_StageMEM deriving (Bits,FShow,Eq);

typedef struct
{
    Addr            pc;
    Bit#(3)         f3;     //仅仅用于LoadStore指令
    OP_StageMEM     op_stageMEM;
    WordXL          val;    //写入MEM的数据：来自于ALU，RF，Imm等
    WordXL          addr;   //Store指令要用的地址
    RegName         rd;
    Bool            valid_instr;//是否被清空，置为NOP指令
} Data_EX_MEM deriving (Bits,FShow);

typedef struct
{
    Bool        rd_valid;
    RegName     rd;
    WordXL      rd_val;
    Bool        valid_instr;//是否被清空，置为NOP指令
} Data_MEM_WB deriving (Bits,FShow);

endpackage