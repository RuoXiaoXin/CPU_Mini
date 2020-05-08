package Testbench_pipe;
//目前最新的
import CPU_RegFile_Mini ::*;
import CPU_Globals_Mini ::*;
import CPU_StageIF_Mini ::*;
import CPU_StageID_Mini ::*;
import CPU_StageEX_Mini ::*;
import CPU_StageMEM_Mini ::*;
import CPU_StageWB_Mini ::*;

module mkTestbench_pipe(Empty);

    CPU_RegFile_IFC regfile <- mkCPU_RegFile;

    CPU_PC_IFC       s0 <- mkCPU_PC;
    CPU_StageIF_IFC  s1 <- mkCPU_StageIF;
    CPU_StageID_IFC  s2 <- mkCPU_StageID(regfile);
    CPU_StageEX_IFC  s3 <- mkCPU_StageEX;
    CPU_StageMEM_IFC s4 <- mkCPU_StageMEM;
    CPU_StageWB_IFC  s5 <- mkCPU_StageWB(regfile);

    Reg #(UInt#(32)) step <- mkReg(0);

    /*测试指令：
    Add x1,x1,x1：1+1=2
    */
    // (0,32'b0000000_00001_00001_000_00001_0110011);
    // (1,32'b0000000_00010_00010_000_00010_0110011);
    // (2,32'b0000000_00011_00011_000_00011_0110011);
    // (3,32'b0000000_00100_00100_000_00100_0110011);
    // (4,32'b0000000_00101_00101_000_00101_0110011);

    
    rule init(step==0);
        $display("**************************************************************************");
        $display("0:init");
        s1.init;     
        s0.in(32'H0000_0000);
        step <= step + 1;
        $display("finish init");
    endrule

    rule pipe(step>0);
        $display("**************************************************************************");
        $display("1:fetch");
        $display("pc:%b",s0.out);
        s1.run(s0.out);
        s0.incr;

        $display("2:decode");
        $display("instr:%b",s1.out.instr);
        s2.run(s1.out);

        $display("3:execute");
        $display("rs1_val:%0d   rs2_val:%0d",s2.out.rs1_val,s2.out.rs2_val);
        s3.run(s2.out);

        $display("4:mem");
        $display("result from ALU:%0d",s3.out.val);
        s4.run(s3.out);

        $display("5:write back");
        s5.run(s4.out);

        step <= step + 1;

    endrule

    rule done(step==31);
        $finish;
    endrule

endmodule

endpackage