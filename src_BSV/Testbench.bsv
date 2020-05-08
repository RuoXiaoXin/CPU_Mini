package Testbench;
//这个测试了：因为Rule分散开了，因此实际是单周期的，不能流水。

import CPU_Globals_Mini ::*;
import CPU_StageIF_Mini ::*;
import CPU_StageID_Mini ::*;
import CPU_StageEX_Mini ::*;
import CPU_StageMEM_Mini ::*;
import CPU_StageWB_Mini ::*;

module mkTestbench(Empty);

    CPU_PC_IFC       s0 <- mkCPU_PC;
    CPU_StageIF_IFC  s1 <- mkCPU_StageIF;
    CPU_StageID_IFC  s2 <- mkCPU_StageID;
    CPU_StageEX_IFC  s3 <- mkCPU_StageEX;
    CPU_StageMEM_IFC s4 <- mkCPU_StageMEM;
    CPU_StageWB_IFC  s5 <- mkCPU_StageWB;

    Reg #(UInt#(32)) step <- mkReg(0);

    /*测试指令：
    Add x1,x1,x1：1+1=2
    Add x2,x2,x2: 2+2=4
    Add x3,x3,x3: 3+3=6
    Add x4,x4,x4: 4+4=8
    Add x5,x5,x5: 5+5=10
    */
    // 0:s1.write_imem(0,32'b0000000_00001_00001_000_00001_0110011);
    // 1:s1.write_imem(1,32'b0000000_00010_00010_000_00010_0110011);
    // 2:s1.write_imem(2,32'b0000000_00011_00011_000_00011_0110011);
    // 3:s1.write_imem(3,32'b0000000_00100_00100_000_00100_0110011);
    // 4:s1.write_imem(4,32'b0000000_00101_00101_000_00101_0110011);

    rule init(step==0);
        $display("**************step0:init***************");
        $display;
        s1.init;     
        s0.in(32'H0000_0000);
        step <= step + 1;
    endrule

    rule fetch ((step%6)==1);
        $display("**************step1:fetch***************");
        $display;
        $display("pc:%b",s0.out);
        s1.run(s0.out);
        s0.incr;
        step <= step + 1;
    endrule

    rule decode ((step%6)==2);
        $display("**************step2:decode*************");
        $display;
        $display("instr:%b",s1.out.instr);
        s2.run(s1.out);
        step <= step + 1;
    endrule

    rule ex ((step%6)==3);
        $display("**************step3:ex*****************");
        $display;
        $display("rs1_val:%0d,rs2_val:%0d",s2.out.rs1_val,s2.out.rs2_val);
        s3.run(s2.out);
        step <= step + 1;
    endrule

    rule mem ((step%6)==4);
        $display("*************step4:mem****************");
        $display;
        $display("result from ex:%0d",s3.out.result);
        s4.run(s3.out);
        step <= step + 1;
    endrule

    rule wb ((step%6)==5);
        $display("************step5:wb**************");
        $display;
        let rd = s5.out(s4.out).rd;
        let rd_val = s5.out(s4.out).rd_val;
        s2.write_regfile(rd,rd_val);
        step <= step + 1;
    endrule

    rule temp ((step%6)==0 && step!=0);
        $display("**************show info*************");
        $display;
        s2.temp_readReg(1);
        step <= step + 1;
    endrule

    rule done((step==31));
        $display("****************Done***************");
        $finish;
    endrule

endmodule

endpackage