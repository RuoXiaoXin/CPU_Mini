package CPU_Globals_Mini;

import ISA_Decls_Mini ::*;

//暂时使用Index作为imem的索引，因为现在是寄存器数组实现的imem
typedef Bit#(5) Index;
Integer imemSize = 1024;
Integer dmemSize = 1024;

typedef struct 
{
    Addr    pc;
    Instr   instr;
} Data_IF_ID deriving (Bits,FShow);

typedef struct
{
    Addr              pc;
    Decoded_Instr     decoded_instr;
    WordXL            rs1_val;
    WordXL            rs2_val;
} Data_ID_EX deriving (Bits,FShow);

typedef enum
{
    //除了LD，ST都选择这个
    OP_StageMEM_ALU,//写RF，无MEM
    OP_StageMEM_LD,//写RF，读MEM
    OP_StageMEM_ST//写MEM
} OP_StageMEM deriving (Bits,FShow,Eq);

typedef struct
{
    Addr            pc;
    OP_StageMEM     op_stageMEM;
    WordXL          val;    //写入MEM的数据：来自于ALU，RF，Imm等
    RegName         rd;
} Data_EX_MEM deriving (Bits,FShow);

typedef struct
{
    Bool    rd_valid;
    RegName rd;
    WordXL  rd_val;
} Data_MEM_WB deriving (Bits,FShow);

endpackage