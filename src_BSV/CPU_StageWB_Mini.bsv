package CPU_StageWB_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageWB_IFC;
    method Action run(Data_MEM_WB data_mem_wb);
endinterface

(*synthesize*)
module mkCPU_StageWB #(CPU_RegFile_IFC regfile) (CPU_StageWB_IFC);
    
    method Action run(Data_MEM_WB data_mem_wb);
        let rd_valid = data_mem_wb.rd_valid;
        let rd = data_mem_wb.rd;
        let rd_val = data_mem_wb.rd_val;
        if(rd_valid==1 & rd!=0)
            regfile.write_rd(rd,rd_val);
        else
            noAction
    endmethod
    
endmodule

endpackage