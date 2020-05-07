package Testbench_regfile;
import CPU_RegFile_Mini ::*;
module mkTestbench_regfile(Empty);
    CPU_RegFile_IFC dut0 <- mkCPU_RegFile;
    Reg#(int) c <- mkReg(0);

    rule show if(c<50);
        $display(dut0.read_rs1(1));
        $display(dut0.read_rs2(2));
        c <= c + 1;
    endrule
endmodule
endpackage
