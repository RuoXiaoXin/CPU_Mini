package CPU_StageMEM_Mini;

import RegFile ::*;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageMEM_IFC;
    method Action run(Data_EX_MEM data_ex_mem);
    method Data_MEM_WB out();
endinterface

module mkCPU_StageMEM(CPU_StageMEM_IFC);
    
    Reg #(Data_MEM_WB) reg_mem_wb <- mkRegU;
    
    RegFile#(Addr,WordXL) dmem <- mkRegFileFullLoad("dmem.txt");
    
    method Action run(Data_EX_MEM data_ex_mem);

        //接收EX级传过来的信息
        let pc = data_ex_mem.pc;
        let rd = data_ex_mem.rd;
        let f3 = data_ex_mem.f3;
        let val  = data_ex_mem.val;
        let addr = data_ex_mem.addr;
        let op_stageMEM = data_ex_mem.op_stageMEM;
    

        Data_MEM_WB rv = Data_MEM_WB { rd_valid:False,
                                       rd:rd,
                                       rd_val:val };

        if(op_stageMEM == OP_StageMEM_ALU)
        begin
            rv = Data_MEM_WB { rd_valid : True};
        end
        else if(op_stageMEM == OP_StageMEM_LD)
        begin
            case(f3)
            f3_LB : begin
                        Bit#(8) load_data = truncate(dmem.sub(addr));
                        rv = Data_MEM_WB { rd_valid :True,rd_val:signExtend(load_data) };
                    end
            f3_LH : begin
                        Bit#(16) load_data = truncate(dmem.sub(addr));
                        rv = Data_MEM_WB { rd_valid :True,rd_val:signExtend(load_data) };
                    end
            f3_LW :begin
                        WordXL load_data = dmem.sub(addr);
                        rv = Data_MEM_WB { rd_valid:True,rd_val:load_data };
                    end
            f3_LBU: begin
                        Bit#(8) load_data = truncate(dmem.sub(addr));
                        rv = Data_MEM_WB { rd_valid :True,rd_val:zeroExtend(load_data) };
                    end
            f3_LHU: begin
                        Bit#(16) load_data = truncate(dmem.sub(addr));
                        rv = Data_MEM_WB { rd_valid :True,rd_val:zeroExtend(load_data) };
                    end
            endcase
        end
        else if(op_stageMEM == OP_StageMEM_ST)
        begin
            case(f3)
            f3_SB:  begin //先读再写，以后应该需要修改掉？？？
                        Bit#(32) temp = dmem.sub(addr);
                        let store_data = { temp[31:8], val[7:0] };
                        dmem.upd(addr,store_data); 
                        rv = Data_MEM_WB { rd_valid:False };
                        $display("store %0d in %0d",store_data,addr);
                    end                                                                      
            f3_SH:  begin
                        Bit#(32) temp = dmem.sub(addr);
                        let store_data = { temp[31:16] ,val[15:0] };
                        rv = Data_MEM_WB { rd_valid:False };
                        $display("store %0d in %0d",store_data,addr);
                    end
            f3_SW: begin
                        dmem.upd(addr,val);
                        rv = Data_MEM_WB { rd_valid:False };
                        $display("store %0d in %0d",val,addr);
                    end

            endcase
        end

        reg_mem_wb <= rv;

    endmethod

    method Data_MEM_WB out;
        return reg_mem_wb;
    endmethod

endmodule
endpackage
