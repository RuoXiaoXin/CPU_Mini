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

        let op = decoded_instr.opcode;
        let f3 = decoded_instr.funct3;

        let rs1_val = regfile.read_rs1(rs1);
        let rs2_val = regfile.read_rs2(rs2);

        IntXL rs1_val_s = unpack(rs1_val);
        IntXL rs2_val_s = unpack(rs2_val);
        
        //分支指令有问题，需要修改
        /*
        if(op==op_BRANCH)
        $display("Branch Instr");
        begin
            let instr_SB_imm13 = decoded_instr.imm13_SB;
            Addr new_pc = pc + signExtend(instr_SB_imm13);

            case(f3)
                f3_BEQ  : branch_EN = (rs1_val_s == rs2_val_s) ? 1'b1  : 1'b0 ;
                f3_BNE  : branch_EN = (rs1_val_s == rs2_val_s) ? 1'b0 : 1'b1  ;
                f3_BLT  : branch_EN = (rs1_val_s <  rs2_val_s) ? 1'b1  : 1'b0 ;
                f3_BGE  : branch_EN = (rs1_val_s >= rs2_val_s) ? 1'b1  : 1'b0 ;
                f3_BLTU : branch_EN = (rs1_val   < rs2_val)    ? 1'b1  : 1'b0 ;
                f3_BGEU : branch_EN = (rs1_val  <= rs2_val)    ? 1'b1  : 1'b0 ;
            endcase

            if(branch_EN == 1'b1)
            begin
                $display("BEQ instr:branch_EN is %b",branch_EN);
            end

            else if(branch_EN == 1'b0)
            begin
                $display("BEQ instr:branch_EN is %b",branch_EN);
            end
        end*/
                
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