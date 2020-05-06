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
        let rd = data_ex_mem.rd;
        let rd_val = data_ex_mem.result;
        reg_mem_wb <= Data_MEM_WB{write_reg:True,rd:rd,rd_val:rd_val};
    endmethod

    method Data_MEM_WB out;
        return reg_mem_wb;
    endmethod

endmodule
endpackage
