package CPU_StageIF_Mini;

import RegFile ::*;

import ISA_Decls_Mini ::*;
import CPU_Globals_Mini ::*;

interface CPU_PC_IFC;
    method Action in(Addr pc);//外部写入新的pc
    method Addr out;
    method Action incr;
endinterface

interface CPU_StageIF_IFC;
    method Action init;
    method Action run(Addr pc_start);
    method Data_IF_ID out;
endinterface

module mkCPU_PC(CPU_PC_IFC);

    Reg #(Addr) reg_pc <- mkRegU;

    method Action in(Addr pc);
        reg_pc <= pc;
    endmethod

    method Addr out;
        return reg_pc;
    endmethod

    method Action incr;
        reg_pc <= reg_pc + 4;
    endmethod

endmodule


module mkCPU_StageIF(CPU_StageIF_IFC);

    //指令存储器，字节寻址
    RegFile #(Addr,Bit#(8)) imem <- mkRegFileFullLoad("imem_store.txt");

    Reg #(Data_IF_ID) reg_if_id <- mkRegU;

    //*************************本模块***********************

    method Action run(Addr pc);
        let instr = {imem.sub(pc),imem.sub(pc+1),imem.sub(pc+2),imem.sub(pc+3)};
        reg_if_id <= Data_IF_ID{pc:pc,instr:instr};
        $display("IF Module:pc is %b",pc);
    endmethod

    method Data_IF_ID out;
        return reg_if_id;
    endmethod

endmodule

endpackage