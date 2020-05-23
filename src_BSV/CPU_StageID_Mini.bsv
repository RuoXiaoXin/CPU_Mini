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

        //分支预测出错：置指令为无效
        let branch_EN = reg_branch.branch_EN;
        let branch_target = reg_branch.branch_target;

        //因为reg_branch是寄存器，所以当读到reg_branch置位时，说明这就是BEQ后一条指令在这里执行，需要置为无效
        Bool valid_instr = ?;
        if (branch_EN == True)
            valid_instr = False;
        else
            valid_instr = data_if_id.valid_instr;


        //从IF级传来的信息：PC和Instr
        let pc    = data_if_id.pc;
        let instr = data_if_id.instr;

        //本级要做的事情：译码
        let decoded_instr = fv_decode(instr);

        let rs1 = decoded_instr.rs1;
        let rs2 = decoded_instr.rs2;

        let instr_SB_imm13 = decoded_instr.imm13_SB;
        let imm21_UJ       = decoded_instr.imm21_UJ;
        let imm12_I        = decoded_instr.imm12_I;

        let op = decoded_instr.opcode;
        let f3 = decoded_instr.funct3;

        //本级要做的事情：读寄存器堆，取数
        let rs1_val = regfile.read_rs1(rs1);
        let rs2_val = regfile.read_rs2(rs2);

        //有符号版本
        IntXL rs1_val_s = unpack(rs1_val);
        IntXL rs2_val_s = unpack(rs2_val);
        
        //本级指令是否是分支指令并且发生分支行为
        Bool branch_EN_temp = False;//默认值，Branch和JAL和JALR共用
        //Branch指令的新地址
        Addr branch_target_temp = unpack(pc + signExtend(instr_SB_imm13));
        //Jal指令的新地址
        Addr jal_target_temp = unpack(rs1_val + signExtend(imm21_UJ));
        //Jalr指令的新地址
        Addr jalr_target_temp = unpack(pc + signExtend(imm12_I));

        //reg_branch的基本值
        Data_Branch data_branch = Data_Branch {branch_EN:branch_EN_temp,branch_target:?};

        //如果是分支指令，ID级处理一下
        if(op==op_BRANCH)
        begin
            $display("ID:Branch Instr");
            $display("ID:Branch Target is %b",branch_target_temp);
            case(f3)
                f3_BEQ  : branch_EN_temp = (rs1_val_s == rs2_val_s) ? True  : False ;
                f3_BNE  : branch_EN_temp = (rs1_val_s == rs2_val_s) ? False : True  ;
                f3_BLT  : branch_EN_temp = (rs1_val_s <  rs2_val_s) ? True  : False ;
                f3_BGE  : branch_EN_temp = (rs1_val_s >= rs2_val_s) ? True  : False ;
                f3_BLTU : branch_EN_temp = (rs1_val   < rs2_val)    ? True  : False ;
                f3_BGEU : branch_EN_temp = (rs1_val  <= rs2_val)    ? True  : False ;
            endcase
            data_branch = Data_Branch{ branch_EN:branch_EN_temp,branch_target:branch_target_temp };  
        end
        //如果是JAL指令，ID级处理，跟Branch类似
        else if(op==op_JAL)
        begin
            branch_EN_temp = True;
            $display("ID:JAL Instr");
            $display("ID:JAL Target is %b",jal_target_temp);
            data_branch = Data_Branch{branch_EN:branch_EN_temp,branch_target:jal_target_temp};
        end
        //如果是JALR指令，ID级处理，同上
        else if(op==op_JALR)
        begin
            branch_EN_temp = True;
            $display("ID:JALR Instr");
            $display("ID:JALR Target is %b",jalr_target_temp);
            data_branch = Data_Branch{branch_EN:branch_EN_temp,branch_target:jalr_target_temp};
        end        
        
        $display("ID:Branch_EN is ",branch_EN_temp);
        $display("ID:valid_instr is ",valid_instr);
            
        reg_branch <= data_branch;

        reg_id_ex <= Data_ID_EX {valid_instr:valid_instr,
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