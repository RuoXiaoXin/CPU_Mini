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

    function Data_EX_MEM fv_alu(Data_ID_EX data_id_ex);

        let pc = data_id_ex.pc;
        let di = data_id_ex.decoded_instr;
        let rs1_val = data_id_ex.rs1_val;
        let rs2_val = data_id_ex.rs2_val;
        
        let rd = di.rd;
        let op = di.opcode;
        let f3 = di.funct3;
        let f7 = di.funct7;

        //有符号
        IntXL rs1_val_s = unpack(rs1_val);
        IntXL rs2_val_s = unpack(rs2_val);

        WordXL result = 0;
        
        if(op==op_LOAD)
        //
        else if(op==op_STORE)
        //
        else if(op==op_OP_IMM)
        begin
            case(f3)
            f3_ADDI:
            f3_SLLI:
            f3_SLTI:
            f3_SLTIU:
            f3_XORI:
            f3_SRxI:
            f3_ORI:
            f3_ANDI:
            default:
            endcase
        end
        else if(op==op_OP)
        begin
            case({f7,f3})
            f10_ADD  : result = rs1_val + rs2_val;
            f10_SUB  : result = rs1_val - rs2_val;
            f10_SLL  : result = rs1_val << rs2_val[4:0];
            f10_SLT  : result = (rs1_val_s < rs2_val_s) ? 1 : 0;
            f10_SLTU : result = (rs1_val < rs2_val) ? 1 : 0;
            f10_XOR  : result = rs1_val ^ rs2_val;
            f10_SRL  : result = rs1_val >> rs2_val[4:0];
            f10_SRA  : result = rs1_val_s >> rs2_val[4:0];
            f10_OR   : result = rs1_val | rs2_val;
            f10_AND  : result = rs1_val & rs2_val;
            endcase

            let rv = Data_EX_MEM{pc:pc,
                                op_stageMEM:OP_StageMEM_ALU,
                                val:result,
                                rd:rd};

        end
        else if(op==op_LUI)
        //
        else if(op==op_AUIPC)
        //
        else if(op==op_BRANCH)
        //
        else if(op==op_JAL)
        //
        else if(op==JALR)
        //
        else
        begin
            $display("ERROR:Unknown Instruction");
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