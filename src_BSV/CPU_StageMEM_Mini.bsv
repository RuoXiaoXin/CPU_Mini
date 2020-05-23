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
    
    //存储器，字节寻址，【3\2\1\0】表示【32-25\24-17\16-8\7-0】
    //存储器里面的数据是：0000000F=15
    RegFile#(Addr,Bit#(8)) dmem3 <- mkRegFileFullLoad("dmem3.txt");
    RegFile#(Addr,Bit#(8)) dmem2 <- mkRegFileFullLoad("dmem2.txt");
    RegFile#(Addr,Bit#(8)) dmem1 <- mkRegFileFullLoad("dmem1.txt");
    RegFile#(Addr,Bit#(8)) dmem0 <- mkRegFileFullLoad("dmem0.txt");

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
                                    
        if(op_stageMEM == OP_StageMEM_NONE)
        begin
            rv = Data_MEM_WB { rd_valid : False };
        end
        else if(op_stageMEM == OP_StageMEM_ALU)
        begin
            rv = Data_MEM_WB { rd_valid : True};
        end
        else if(op_stageMEM == OP_StageMEM_LD)
        begin
            case(f3)
            f3_LB : begin
                        let load_data = dmem0.sub(addr);
                        rv = Data_MEM_WB { rd_valid :True,rd_val:signExtend(load_data) };
                    end
            f3_LH : begin
                        let load_data = { dmem1.sub(addr),dmem0.sub(addr) };
                        rv = Data_MEM_WB { rd_valid :True,rd_val:signExtend(load_data) };
                    end
            f3_LW :begin
                        let load_data = {dmem3.sub(addr),dmem2.sub(addr),dmem1.sub(addr),dmem0.sub(addr)};
                        rv = Data_MEM_WB { rd_valid:True,rd_val:load_data };
                        $display("LW:addr is %0d, data is %0d",addr,load_data);
                    end
            f3_LBU: begin
                        let load_data = dmem0.sub(addr);
                        rv = Data_MEM_WB { rd_valid :True,rd_val:zeroExtend(load_data) };
                    end
            f3_LHU: begin
                        let load_data = { dmem1.sub(addr),dmem0.sub(addr) };
                        rv = Data_MEM_WB { rd_valid :True,rd_val:zeroExtend(load_data) };
                    end
            endcase
        end
        else if(op_stageMEM == OP_StageMEM_ST)
        begin
            case(f3)
            f3_SB:  begin
                        //这里得用地址做一下取余操作，判断是哪个字节数组的
                        //dmem.upd(addr,val); 
                        let temp = addr % 'd4;
                        let addr_byte = addr / 'd4;
                        // $display("SB:");
                        case(temp)
                            0:begin dmem0.upd(addr_byte,val[7:0]); $display("dmem0.upd(%0d,%b)",addr_byte,val[7:0]); end
                            1:begin dmem1.upd(addr_byte,val[7:0]); $display("dmem1.upd(%0d,%b)",addr_byte,val[7:0]); end
                            2:begin dmem2.upd(addr_byte,val[7:0]); $display("dmem2.upd(%0d,%b)",addr_byte,val[7:0]); end
                            3:begin dmem3.upd(addr_byte,val[7:0]); $display("dmem3.upd(%0d,%b)",addr_byte,val[7:0]); end
                        endcase
                        rv = Data_MEM_WB { rd_valid:False };
                    end                                                                      
            f3_SH:  begin
                        let temp = addr % 'd2;
                        case(temp)
                            0:begin
                                dmem0.upd(addr,val[7:0]);
                                dmem1.upd(addr,val[15:8]);
                              end                                       
                            1:begin
                                dmem2.upd(addr,val[23:16]);
                                dmem3.upd(addr,val[31:24]);
                              end
                        endcase
                        rv = Data_MEM_WB { rd_valid:False };
                    end
            f3_SW: begin
                        dmem0.upd(addr,val[7:0]);
                        dmem1.upd(addr,val[15:8]);
                        dmem2.upd(addr,val[23:16]);
                        dmem3.upd(addr,val[31:24]);
                        rv = Data_MEM_WB { rd_valid:False };
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