package CPU_StageWB_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;
import CPU_RegFile_Mini ::*;

interface CPU_StageWB_IFC;
    method Action run(Data_MEM_WB data_mem_wb);
endinterface

module mkCPU_StageWB #(CPU_RegFile_IFC regfile) (CPU_StageWB_IFC);
    
    method Action run(Data_MEM_WB data_mem_wb);

        let valid_instr = data_mem_wb.valid_instr;

        let rd = data_mem_wb.rd;
        let rd_val = data_mem_wb.rd_val;
        let rd_valid = data_mem_wb.rd_valid;

        if(rd_valid==True && valid_instr==True)//避免被清除的指令写寄存器
        begin
            $display("write %0d in %0d",rd_val,rd);
            regfile.write_rd(rd,rd_val);     
        end
    endmethod
    
endmodule

endpackage