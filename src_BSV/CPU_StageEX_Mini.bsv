package CPU_StageEX_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageEX_IFC;
    method Action run(Data_ID_EX data_id_ex);
    method Data_EX_MEM out;
endinterface

module mkCPU_StageEX(CPU_StageEX_IFC);

    Reg #(Data_EX_MEM) reg_ex_mem <- mkRegU;

    function Data_EX_MEM fv_alu(Data_ID_EX data_id_ex);

        let pc = data_id_ex.pc;
        let di = data_id_ex.decoded_instr;
        let rs1_val = data_id_ex.rs1_val;
        let rs2_val = data_id_ex.rs2_val;
        
        let rd = di.rd;
        let op = di.opcode;
        let f3 = di.funct3;
        let f7 = di.funct7;

        IntXL rs1_val_s = unpack(rs1_val);
        IntXL rs2_val_s = unpack(rs2_val);
        WordXL result = ?;

        //return value
        Data_EX_MEM rv = Data_EX_MEM{pc:?,
                             op_stageMEM:?,
                             val:?,
                             rd:?};
        
        if(op==op_OP)
        begin
            case({f7,f3})
            f10_ADD  : result = pack(rs1_val_s + rs2_val_s);
            f10_SUB  : result = pack(rs1_val_s - rs2_val_s);
            f10_SLL  : result = rs1_val << rs2_val[4:0];
            f10_SLT  : result = (rs1_val_s < rs2_val_s) ? 1 : 0;
            f10_SLTU : result = (rs1_val < rs2_val) ? 1 : 0;
            f10_XOR  : result = rs1_val ^ rs2_val;
            f10_SRL  : result = rs1_val >> rs2_val[4:0];
            f10_SRA  : result = pack(rs1_val_s >> rs2_val[4:0]);
            f10_OR   : result = rs1_val | rs2_val;
            f10_AND  : result = rs1_val & rs2_val;
            endcase

            rv = Data_EX_MEM{pc:pc,
                            op_stageMEM:OP_StageMEM_ALU,
                            val:result,
                            rd:rd};

        end
        return rv;
    
    endfunction

    method Action run(Data_ID_EX data_id_ex);
        reg_ex_mem <= fv_alu(data_id_ex);
    endmethod

    method Data_EX_MEM out;
        return reg_ex_mem;
    endmethod

endmodule

endpackage