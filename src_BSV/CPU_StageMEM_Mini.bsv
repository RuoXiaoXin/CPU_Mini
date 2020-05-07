package CPU_StageMEM_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageMEM_IFC;
    method Action run(Data_EX_MEM data_ex_mem);
    method Data_MEM_WB out();
endinterface

(*synthesize*)
module mkCPU_StageMEM(CPU_StageMEM_IFC);
    
    Reg #(Data_MEM_WB) reg_mem_wb <- mkRegU;

    //mem暂时使用寄存器数组
    Reg #(WordXL) dmem[dmemSize];

    for(Integer i=0;i<dmemSize;i=i+1)
        dmem[i] <- mkReg(0);
    
    method Action run(Data_EX_MEM data_ex_mem);

        let pc = data_ex_mem.pc;
        let rd = data_ex_mem.rd;
        let val = data_ex_mem.val;
        let op_stageMEM = data_ex_mem.op_stageMEM;

        let rd_valid = (op_stageMEM==OP_StageMEM_ST) ? 0:1;

        reg_mem_wb <= Data_MEM_WB{rd_valid:rd_valid,
                                  rd:rd,
                                  rd_val:val};

    endmethod

    method Data_MEM_WB out;
        return reg_mem_wb;
    endmethod

endmodule
endpackage
