package CPU_StageIF_Mini;

import RegFile ::*;

import ISA_Decls_Mini ::*;
import CPU_Globals_Mini ::*;

interface CPU_StageIF_IFC;
    method Action run(Data_Branch br);
    method Data_IF_ID out;
endinterface

module mkCPU_StageIF (CPU_StageIF_IFC);
    
    Reg #(Addr) reg_pc <- mkReg(0);
    Reg #(Data_IF_ID) reg_if_id <- mkRegU;
    RegFile #(Addr,Bit#(8)) imem <- mkRegFileFullLoad("imem_beq.txt");//指令存储器，字节寻址

    method Action run(Data_Branch br);

        let branch_EN = br.branch_EN;
        let branch_target = br.branch_target;
        let pc_temp = ?;

        Bool valid_instr = True;

        if(branch_EN==True)//判断是否分支
            begin 
            pc_temp = branch_target; 
            valid_instr = False;
            $display("IF:branch taken");
            $display("IF:branch target is %b",branch_target); 
            end
        else
            begin 
            pc_temp = reg_pc; 
            $display("IF:branch untaken"); 
            end
    
        let instr = { imem.sub(pc_temp),imem.sub(pc_temp+1),imem.sub(pc_temp+2),imem.sub(pc_temp+3) };//读imem

        $display("pc is %b",pc_temp);
        reg_pc <= pc_temp + 4;//写pc寄存器
        reg_if_id <= Data_IF_ID{ valid_instr:valid_instr,pc:pc_temp+4,instr:instr };//写if_id流水线寄存器
    endmethod

    method Data_IF_ID out;
        return reg_if_id;
    endmethod

endmodule

endpackage