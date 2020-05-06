package CPU_StageWB_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageWB_IFC;
    method Data_WB out(Data_MEM_WB data_mem_wb);
endinterface

//如果寄存器定义在ID模块里，那么WB模块就全部是组合逻辑了。
//写回寄存器需要在TOP调用ID模块的方法。

(*synthesize*)
module mkCPU_StageWB(CPU_StageWB_IFC);
    
    method Data_WB out(Data_MEM_WB data_mem_wb);
        let write_reg = data_mem_wb.write_reg;
        let rd = data_mem_wb.rd;
        let rd_val = data_mem_wb.rd_val;

        if(write_reg==True)
            return Data_WB{rd:rd,rd_val:rd_val};
        else
            return Data_WB{rd:0,rd_val:0};
    endmethod

endmodule

endpackage