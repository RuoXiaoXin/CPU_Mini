package CPU_StageIF_Mini;

import ISA_Decls_Mini ::*;
import CPU_Globals_Mini ::*;

interface CPU_PC_IFC;
    method Action in(Addr pc);
    method Addr out;
    method Action incr;
endinterface

interface CPU_StageIF_IFC;
    method Action init;
    method Action run(Addr pc_start);
    method Data_IF_ID out;
endinterface


(* synthesize *)
module mkCPU_PC(CPU_PC_IFC);

    Reg #(Addr) reg_pc <- mkRegU;

    method Action in(Addr pc);
        reg_pc <= pc;
    endmethod

    method Addr out;
        return reg_pc;
    endmethod

    method Action incr;
        reg_pc <= reg_pc + 1;
    endmethod

endmodule


(* synthesize *)
module mkCPU_StageIF(CPU_StageIF_IFC);

    Reg #(Instr) imem[imemSize];
    for(Integer i=0;i<imemSize;i=i+1)
        imem[i] <- mkRegU;

    Reg #(Data_IF_ID) reg_if_id <- mkRegU;

    //*************************init**********************

    /*Add x1,x1,x1五条指令，均是这个1+1,2+2,4+4,8+8,16+16*/
    method Action init;
        writeReg(imem[0],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[1],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[2],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[3],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[4],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[5],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[6],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[7],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[8],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[9],32'b0000000_00001_00001_000_00001_0110011);
    endmethod

    //*************************本模块***********************

    method Action run(Addr pc_start);
        let pc = pc_start;
        let instr = imem[pc];
        reg_if_id <= Data_IF_ID{pc:pc,instr:instr};
    endmethod

    method Data_IF_ID out;
        return reg_if_id;
    endmethod

endmodule

endpackage