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
        reg_pc <= reg_pc + 1;
    endmethod

endmodule


module mkCPU_StageIF(CPU_StageIF_IFC);

    //指令存储器
    //这样是IM按字寻址，不能字节寻址，PC+1
    RegFile #(Addr,Instr) imem <- mkRegFileFullLoad("imem_store.txt");

    Reg #(Data_IF_ID) reg_if_id <- mkRegU;

    //*************************init**********************

    /*Add x1,x1,x1五条指令，均是这个1+1,2+2,4+4,8+8,16+16*/
    /*
    method Action init;
        writeReg(imem[0],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[1],32'b0000000_00010_00010_000_00010_0110011);
        writeReg(imem[2],32'b0000000_00011_00011_000_00011_0110011);
        writeReg(imem[3],32'b0000000_00100_00100_000_00100_0110011);
        writeReg(imem[4],32'b0000000_00101_00101_000_00101_0110011);

        writeReg(imem[5],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[6],32'b0000000_00010_00010_000_00010_0110011);
        writeReg(imem[7],32'b0000000_00011_00011_000_00011_0110011);
        writeReg(imem[8],32'b0000000_00100_00100_000_00100_0110011);
        writeReg(imem[9],32'b0000000_00101_00101_000_00101_0110011);

        writeReg(imem[10],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[11],32'b0000000_00010_00010_000_00010_0110011);
        writeReg(imem[12],32'b0000000_00011_00011_000_00011_0110011);
        writeReg(imem[13],32'b0000000_00100_00100_000_00100_0110011);
        writeReg(imem[14],32'b0000000_00101_00101_000_00101_0110011);

        writeReg(imem[15],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[16],32'b0000000_00010_00010_000_00010_0110011);
        writeReg(imem[17],32'b0000000_00011_00011_000_00011_0110011);
        writeReg(imem[18],32'b0000000_00100_00100_000_00100_0110011);
        writeReg(imem[19],32'b0000000_00101_00101_000_00101_0110011);

        writeReg(imem[20],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[21],32'b0000000_00010_00010_000_00010_0110011);
        writeReg(imem[22],32'b0000000_00011_00011_000_00011_0110011);
        writeReg(imem[23],32'b0000000_00100_00100_000_00100_0110011);
        writeReg(imem[24],32'b0000000_00101_00101_000_00101_0110011);

        writeReg(imem[25],32'b0000000_00001_00001_000_00001_0110011);
        writeReg(imem[26],32'b0000000_00010_00010_000_00010_0110011);
        writeReg(imem[27],32'b0000000_00011_00011_000_00011_0110011);
        writeReg(imem[28],32'b0000000_00100_00100_000_00100_0110011);
        writeReg(imem[29],32'b0000000_00101_00101_000_00101_0110011);
    endmethod
    */

    //*************************本模块***********************

    method Action run(Addr pc);
        let instr = imem.sub(pc);
        reg_if_id <= Data_IF_ID{pc:pc,instr:instr};
        $display("IF Module:pc is %b",pc);
    endmethod

    method Data_IF_ID out;
        return reg_if_id;
    endmethod

endmodule

endpackage