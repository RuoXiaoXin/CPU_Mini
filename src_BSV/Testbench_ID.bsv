package Testbench_ID;

import CPU_StageID_Mini ::*;
module mkTestbench_ID(Empty);

    CPU_StageID_IFC s2 <- mkCPU_StageID;
    Reg#(UInt#(32)) count <- mkReg(0);

    rule r1(count==0);
        s2.temp_test(0);
        count <= count + 1;
    endrule

    rule r2(count==1);
        s2.temp_test(5'd1);
        $finish;
    endrule

endmodule

endpackage