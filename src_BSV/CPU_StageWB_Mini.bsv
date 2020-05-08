package CPU_StageWB_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;
import CPU_RegFile_Mini ::*;

interface CPU_StageWB_IFC;
    method Action run(Data_MEM_WB data_mem_wb);
endinterface

module mkCPU_StageWB #(CPU_RegFile_IFC regfile) (CPU_StageWB_IFC);
    
    method Action run(Data_MEM_WB data_mem_wb);
        let rd_valid = data_mem_wb.rd_valid;
        let rd = data_mem_wb.rd;
        let rd_val = data_mem_wb.rd_val;
        $display("rd_valid is ",rd_valid);
        if(rd_valid==True)
        begin
            regfile.write_rd(rd,rd_val);     
            $display("WB Module:write %0d in %0d",rd_val,rd);
        end
    endmethod
    
endmodule

endpackage