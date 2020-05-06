package CPU_StageID_Mini;

import RegFile ::*;
import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageID_IFC; 
    method Action run(Data_IF_ID data_if_id);
    method Data_ID_EX out;
    method Action write_regfile(RegName rd,WordXL rd_val);
    method Action temp_readReg(RegName index);
endinterface

(*synthesize*)
module mkCPU_StageID (CPU_StageID_IFC);

    RegFile #(RegName,WordXL) regfile <- mkRegFileLoad("regfile.txt",0,5);
    
    Reg #(Data_ID_EX) reg_id_ex <- mkRegU;

    method Action run(Data_IF_ID data_if_id);
        let pc = data_if_id.pc;
        let instr = data_if_id.instr;
        let decoded_instr = fv_decode(instr);
        let rs1_val = regfile.sub(decoded_instr.rs1);
        let rs2_val = regfile.sub(decoded_instr.rs2);
        reg_id_ex <= Data_ID_EX{pc:pc,
                                decoded_instr:decoded_instr,
                                rs1_val:rs1_val,
                                rs2_val:rs2_val};
    endmethod

    method Action temp_readReg(RegName index);
        $display("read reg %0d:%0d",index,regfile.sub(index));
    endmethod

    method Data_ID_EX out;
        return reg_id_ex;
    endmethod

    method Action write_regfile(RegName rd,WordXL rd_val);
        regfile.upd(rd,rd_val);
        $display("write regfile   rd:%0d,rd_val:%0d",rd,rd_val);
    endmethod

endmodule

endpackage