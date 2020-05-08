package CPU_StageID_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;
import CPU_RegFile_Mini ::*;

interface CPU_StageID_IFC; 
    method Action run(Data_IF_ID data_if_id);
    method Data_ID_EX out;
endinterface

module mkCPU_StageID #(CPU_RegFile_IFC regfile) (CPU_StageID_IFC);
    
    Reg #(Data_ID_EX) reg_id_ex <- mkRegU;

    method Action run(Data_IF_ID data_if_id);
        let pc = data_if_id.pc;
        let instr = data_if_id.instr;
        let decoded_instr = fv_decode(instr);

        let rs1 = decoded_instr.rs1;
        let rs2 = decoded_instr.rs2;

        let rs1_val = regfile.read_rs1(rs1);
        let rs2_val = regfile.read_rs2(rs2);

        $display("ID Module:read RF,rs1 is %0d,rs2 is %0d",rs1,rs2);
        
        reg_id_ex <= Data_ID_EX{pc:pc,
                                decoded_instr:decoded_instr,
                                rs1_val:rs1_val,
                                rs2_val:rs2_val};
    endmethod

    method Data_ID_EX out;
        return reg_id_ex;
    endmethod

endmodule

endpackage