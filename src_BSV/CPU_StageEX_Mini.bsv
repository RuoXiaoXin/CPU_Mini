package CPU_StageEX_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageEX_IFC;
    method Action run(Data_ID_EX data_id_ex);
    method Data_EX_MEM out;
endinterface

(*synthesize*)
module mkCPU_StageEX(CPU_StageEX_IFC);

    Reg #(Data_EX_MEM) reg_ex_mem <- mkRegU;

    //先写一条ADD指令
    //再梳理成function
    method Action run(Data_ID_EX data_id_ex);
        let rd = data_id_ex.decoded_instr.rd;
        let op = data_id_ex.decoded_instr.opcode;
        let f3 = data_id_ex.decoded_instr.funct3;
        let f7 = data_id_ex.decoded_instr.funct7;
        let rs1_val = data_id_ex.rs1_val;
        let rs2_val = data_id_ex.rs2_val;

        WordXL result = 0;

        if(op==op_OP)
            case ({f3,f7})
                f10_ADD : result = rs1_val + rs2_val;
            endcase
                  
        reg_ex_mem <= Data_EX_MEM{result:result,write_mem:False,write_reg:True,rd:rd};
    endmethod

    method Data_EX_MEM out;
        return reg_ex_mem;
    endmethod

endmodule

endpackage