package CPU_Memory_Mini;

import Memory ::*;
import RegFile ::*;
import GetPut ::*;
import ClientServer::*;
import ISA_Decls_Mini ::*;

//先写数据存储，验证了再补充指令存储器
//DM
Integer dmemSize = 'h0008_0000;

typedef 32 Addr_Width;
typedef 32 Data_Width;

typedef MemoryServer#(Addr_Width,Data_Width) CPU_DMem_IFC;

module mkCPU_DMem (CPU_DMem_IFC);

    RegFile#(Addr,WordXL) dmem <- mkRegFileLoad ("dmem.txt", 0, fromInteger (dmemSize - 1));

    MemoryResponse#(Data_Width) rsp = ?;
    MemoryRequest#(Addr_Width,Data_Width) req = ?;

    rule rl;
        let addr = req.address;
        let data = req.data;
        if(req.write==True) 
        begin
            dmem.upd(addr,data);
            let rsp = MemoryResponse{data:?};
            $display("dmem write,addr is %b,data is %0d",addr,data);
        end else 
        begin
            let x = dmem.sub(addr);
            let rsp = MemoryResponse{data:x};
            $display("dmem read,addr is %b",addr);
        end
    endrule

    interface Get response = toGet (rsp);
    interface Put request  = toPut (req);

endmodule
endpackage