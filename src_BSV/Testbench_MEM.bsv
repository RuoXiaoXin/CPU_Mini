package Testbench_MEM;
import BRAMCore ::*;
import ISA_Decls_Mini ::*;
import Memory ::*;

Integer imemSize = 1024;

module mkTestbench_MEM(Empty);

    BRAM_PORT#(Addr,Instr) imem <- mkBRAMCore1Load(imemSize,False,"imem.txt",True);

    Reg#(int) s <- mkReg(0);

    //在同一个rule里，同一拍，是读不出来的
    rule test(s==0);
        $display("put method,read addr");
        imem.put(False,32'H0000_0000,?);
        $display("read method,%b",imem.read);
        s <= s + 1;
    endrule

    rule test2(s==1);
        $display("read method,%b",imem.read);
        s <= s + 1;
    endrule

    rule test3(s==2);
        $display("read method,%b",imem.read);
        s <= s + 1;
    endrule

    rule test4(s==3);
        $display("read method,%b",imem.read);
        $finish;
    endrule
    
endmodule

endpackage