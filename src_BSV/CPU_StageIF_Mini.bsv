package CPU_StageIF_Mini;

import RegFile ::*;

import ISA_Decls_Mini ::*;
import CPU_Globals_Mini ::*;

interface CPU_StageIF_IFC;
    method Action run;
    method Data_IF_ID out;
endinterface

module mkCPU_StageIF (CPU_StageIF_IFC);
    
    Reg #(Addr) reg_pc <- mkReg(0);
    Reg #(Data_IF_ID) reg_if_id <- mkRegU;
    RegFile #(Addr,Bit#(8)) imem <- mkRegFileFullLoad("imem_add.txt");//指令存储器，字节寻址

    method Action run;

        //这个读的是上一拍写的寄存器，顺序时永远从reg_pc里面读
        //ID级送回分支时，从reg_target里面读
        let pc_temp = reg_pc;
        let instr = { imem.sub(pc_temp),imem.sub(pc_temp+1),imem.sub(pc_temp+2),imem.sub(pc_temp+3) };
        //写reg_pc寄存器
        $display("pc is %b",pc_temp);
        reg_pc <= pc_temp + 4;
        reg_if_id <= Data_IF_ID{ pc:pc_temp+4,instr:instr };
    endmethod

    method Data_IF_ID out;
        return reg_if_id;
    endmethod

endmodule

endpackage