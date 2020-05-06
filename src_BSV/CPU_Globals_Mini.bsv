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

typedef struct
{
    WordXL  result;//ALU OUT
    
    Bool    write_mem;
    Addr    mem_addr;
    WordXL  mem_val;

    Bool    write_reg;
    RegName rd;
    WordXL  rd_val;

} Data_EX_MEM deriving (Bits,FShow);

typedef struct
{   Bool    write_reg;
    RegName rd;
    WordXL  rd_val;
} Data_MEM_WB deriving (Bits,FShow);

typedef struct 
{
    RegName rd;
    WordXL  rd_val;
} Data_WB deriving (Bits,FShow);

endpackage