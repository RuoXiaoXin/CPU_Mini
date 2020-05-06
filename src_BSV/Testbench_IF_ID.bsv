package Testbench_IF_ID;

import CPU_Globals_Mini ::*;
import CPU_StageIF_Mini ::*;
import CPU_StageID_Mini ::*;

module mkTestbench_IF_ID(Empty);

    CPU_PC_IFC      s0 <- mkCPU_PC;
    CPU_StageIF_IFC s1 <- mkCPU_StageIF;
    CPU_StageID_IFC s2 <- mkCPU_StageID;

    Reg #(UInt#(32)) step <- mkReg(0);

    rule init_imem(step==0);
    //测试指令：Add x1,x1,x1：1+1=2
        s1.write_imem(0,32'b0000000_00001_00001_000_00001_0110011);
        step <= step + 1;
    endrule

    rule r1 (step==1);
        s0.in(32'H0000_0000);
        step <= step + 1;
    endrule

    rule r2 (step==2);
        $display("pc:%b",s0.out);
        s1.run(s0.out);
        step <= step + 1;
    endrule

    rule r3 (step==3);
        $display("instr:%b",s1.out.instr);
        s2.run(s1.out);
        step <= step + 1;
    endrule

    rule r4(step==4);
        $display("rs1_val:%0d",s2.out.rs1_val);
        $display("rs2_val:%0d",s2.out.rs2_val);
        $finish;
    endrule
    
endmodule

endpackage