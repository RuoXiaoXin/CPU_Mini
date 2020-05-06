//注意语法：import xxx ::*;

package Testbench_IF;

import CPU_Globals_Mini :: *;
import ISA_Decls_Mini :: *;
import CPU_StageIF_Mini ::*;

(* synthesize *)
module mkTestbench_IF(Empty);

    CPU_StageIF_IFC s1 <- mkCPU_StageIF;
    Reg#(UInt#(32)) step <- mkReg(0);

    rule clear(step==0);
        // $display("This is rule clear in testbench!");
        // $display("step is : ",step);
        s1.if_reset;
        step<=step+1;
    endrule

    rule run(step<=8);
        // $display("This is rule run in testbench");
        $display("step is : ",step);
        s1.if_fetch;
        s1.if_pc_incr;
        s1.read_reg;
        // $display("pc is : ",fshow(reg_IF_ID.pc));
        // $display("instr is : ",fshow(reg_IF_ID.instr));
        step<=step+1;
    endrule

    rule done(step>8);
        // $display("This is rule done in testbench");
        // $display("step is : ",step);
        $finish;
    endrule

endmodule

endpackage