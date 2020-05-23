package CPU_StageID_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;
import CPU_RegFile_Mini ::*;

interface CPU_StageID_IFC; 
    method Action run(Data_IF_ID data_if_id);
    method Data_ID_EX out;
    method Data_Branch out_branch;
endinterface

module mkCPU_StageID #(CPU_RegFile_IFC regfile) (CPU_StageID_IFC);
    
    Reg #(Data_ID_EX) reg_id_ex <- mkRegU;
    Reg #(Data_Branch) reg_branch <- mkRegU;

    method Action run(Data_IF_ID data_if_id);
        let pc = data_if_id.pc;
        let instr = data_if_id.instr;
        let decoded_instr = fv_decode(instr);

        let rs1 = decoded_instr.rs1;
        let rs2 = decoded_instr.rs2;

        let instr_SB_imm13 = decoded_instr.imm13_SB;

        let op = decoded_instr.opcode;
        let f3 = decoded_instr.funct3;

        let rs1_val = regfile.read_rs1(rs1);
        let rs2_val = regfile.read_rs2(rs2);

        // IntXL pc_s = unpack(pc);
        IntXL rs1_val_s = unpack(rs1_val);
        IntXL rs2_val_s = unpack(rs2_val);
        
        Bool branch_EN = False;
        Addr branch_target = ? ;
                
        if(op==op_BRANCH)
        begin
            branch_target = unpack(pc + signExtend(instr_SB_imm13));
            
            $display("ID:Branch Instr");
            $display("ID:Branch Target is %b",branch_target);

            case(f3)
                f3_BEQ  : branch_EN = (rs1_val_s == rs2_val_s) ? True  : False ;
                f3_BNE  : branch_EN = (rs1_val_s == rs2_val_s) ? False : True  ;
                f3_BLT  : branch_EN = (rs1_val_s <  rs2_val_s) ? True  : False ;
                f3_BGE  : branch_EN = (rs1_val_s >= rs2_val_s) ? True  : False ;
                f3_BLTU : branch_EN = (rs1_val   < rs2_val)    ? True  : False ;
                f3_BGEU : branch_EN = (rs1_val  <= rs2_val)    ? True  : False ;
            endcase

        end

        $display("ID:Branch_EN is ",branch_EN);
        reg_branch <= Data_Branch{ branch_EN:branch_EN,branch_target:branch_target };        
        reg_id_ex <= Data_ID_EX{valid_instr:True,
                                pc:pc,
                                decoded_instr:decoded_instr,
                                rs1_val:rs1_val,
                                rs2_val:rs2_val};
    endmethod

    method Data_ID_EX out;
        return reg_id_ex;
    endmethod

    method Data_Branch out_branch;
        return reg_branch;
    endmethod

endmodule

endpackage