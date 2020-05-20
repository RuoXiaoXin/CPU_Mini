package Testbench_MEM;

import ISA_Decls_Mini ::*;
import Memory ::*;
import CPU_Memory_Mini ::*;

module mkTestbench_MEM(Empty);

    CPU_DMem_IFC dmem <- mkCPU_DMem;

    MemoryResponse#(Addr_Width,Data_Width) rsp = ?;

    rule rl;
        let req = MemoryRequest{write:False, address:32'H0000_0000};
        dmem.toPut(req);
        dmem.toGet(rsp);
        $display("response is,%b",rsp.data);
        $finish;
    endrule
endmodule
endpackage