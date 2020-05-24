package CPU_StageEX_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageEX_IFC;
    method Action run(Data_ID_EX data_id_ex,Data_Forward reg_forward_wb);
    method Data_EX_MEM out;
endinterface

module mkCPU_StageEX (CPU_StageEX_IFC);

    Reg #(Data_EX_MEM) reg_ex_mem <- mkRegU;

    //旁路信息存储在这里，这是EX级写MEM级的信息，用于两条相邻的指令发生RAW型数据冒险
    Reg #(Data_Forward) reg_forward_mem <- mkRegU;

    method Action run(Data_ID_EX data_id_ex,Data_Forward reg_forward_wb);
        
        //当前指令是否有效，是否被NOP
        let valid_instr = data_id_ex.valid_instr;
        
        //ID级传来的信息
        let pc = data_id_ex.pc;
        let rs1_val = data_id_ex.rs1_val;
        let rs2_val = data_id_ex.rs2_val;
        let di = data_id_ex.decoded_instr;
        let rd = di.rd;
        let op = di.opcode;
        let f3 = di.funct3;
        let f7 = di.funct7;
        let imm12_I = di.imm12_I;
        let imm12_S = di.imm12_S;
        let imm20_U = di.imm20_U;

        //**********************************************旁路**************************************************
        //本级的要读的rs1和rs2
        let rs1_forward = di.rs1;
        let rs2_forward = di.rs2;
        //MEM级的那条指令要写的rd以及rd的数值
        let rd_forward_mem       = reg_forward_mem.rd;
        let rd_val_forward_mem   = reg_forward_mem.rd_val;
        let rd_valid_forward_mem = reg_forward_mem.rd_valid;
        //WB级的那条指令要写的rd以及rd的数值
        let rd_forward_wb       = reg_forward_wb.rd;
        let rd_val_forward_wb   = reg_forward_wb.rd_val;
        let rd_valid_forward_wb = reg_forward_wb.rd_valid;
        //旁路的判断
        if(rd_valid_forward_mem && rs1_forward==rd_forward_mem)
        begin
            $display("Forward rs1_val from MEM");
            rs1_val = rd_val_forward_mem;
        end
        if(rd_valid_forward_mem && rs2_forward==rd_forward_mem)
        begin
            $display("Forward rs2_val from MEM");
            rs2_val = rd_val_forward_mem;
        end
        if(rd_valid_forward_wb && rs1_forward==rd_forward_wb)
        begin
            $display("Forward rs1_val from WB");
            rs1_val = rd_val_forward_wb;
        end
        if(rd_valid_forward_wb && rs2_forward==rd_forward_wb)
        begin
            $display("Forward rs2_val from WB");
            rs2_val = rd_val_forward_wb;
        end

        IntXL rs1_val_s = unpack(rs1_val);
        IntXL rs2_val_s = unpack(rs2_val);

        Addr     addr = ?;//MEM访存的地址
        WordXL result = ?;//ALU计算的数据，或者，S型指令要存的数据

        //return value基本值
        Data_EX_MEM rv = Data_EX_MEM{pc:pc,
                             op_stageMEM:?,
                             valid_instr:valid_instr,//指令是否有效
                             f3:f3, //仅用于Load和Store指令
                             val:?,
                             addr:?,
                             rd:rd};
        //旁路信息基本值
        Data_Forward f = Data_Forward{ rd:rd,rd_val:?,rd_valid:False };
        

        if(op==op_LUI)
        begin
            result =  signExtend(imm20_U) << 12;
            rv = Data_EX_MEM { op_stageMEM:OP_StageMEM_ALU,valid_instr:valid_instr,val:result };
            f  = Data_Forward{ rd_valid:True,rd:rd,rd_val:result };
        end
        else if(op==op_AUIPC)
        begin
            result = (signExtend(imm20_U)<<12) + pc;
            rv = Data_EX_MEM { op_stageMEM:OP_StageMEM_ALU,valid_instr:valid_instr,val:result };
            f  = Data_Forward{ rd_valid:True,rd:rd,rd_val:result };
        end
        else if(op==op_OP)
        begin
            case({f7,f3})
            f10_ADD  : result = pack(rs1_val_s + rs2_val_s);
            f10_SUB  : result = pack(rs1_val_s - rs2_val_s);
            f10_SLL  : result = rs1_val << rs2_val[4:0];
            f10_SLT  : result = (rs1_val_s < rs2_val_s) ? 1 : 0;
            f10_SLTU : result = (rs1_val < rs2_val) ? 1 : 0;
            f10_XOR  : result = rs1_val ^ rs2_val;
            f10_SRL  : result = rs1_val >> rs2_val[4:0];
            f10_SRA  : result = pack(rs1_val_s >> rs2_val[4:0]);
            f10_OR   : result = rs1_val | rs2_val;
            f10_AND  : result = rs1_val & rs2_val;
            endcase
            f  = Data_Forward{ rd_valid:True,rd:rd,rd_val:result };
            rv = Data_EX_MEM {  //pc:pc,
                                //rd:rd,
                                valid_instr:valid_instr,
                                op_stageMEM : OP_StageMEM_ALU,
                                val : result };
    
        end
        else if(op==op_OP_IMM)
        begin
            case(f3)
            f3_ADDI  : result = pack(rs1_val_s + unpack(signExtend(imm12_I)));
            f3_SLLI  : result = pack(rs1_val_s << imm12_I[4:0]);
            f3_SLTI  : result = (rs1_val_s < unpack(signExtend(imm12_I))) ? 1 : 0;
            f3_SLTIU : result = (rs1_val < unpack(zeroExtend(imm12_I))) ? 1 : 0;
            f3_XORI  : result = rs1_val ^ unpack(zeroExtend(imm12_I));
            f3_SRxI  : begin 
                        if(imm12_I[10]==1)//SRAI
                            result = pack(rs1_val_s >> imm12_I[4:0]);
                        else//SRLI
                            result = pack(rs1_val >> imm12_I[4:0]);
                        end
            f3_ORI   : result = rs1_val | zeroExtend(imm12_I);
            f3_ANDI  : result = rs1_val & zeroExtend(imm12_I);
            endcase
            f  = Data_Forward{ rd_valid:True,rd:rd,rd_val:result };
            rv = Data_EX_MEM {  //pc:pc,
                                // rd:rd,
                                valid_instr:valid_instr,
                                op_stageMEM : OP_StageMEM_ALU,
                                val : result };

        end
        else if(op==op_LOAD)
        begin
            //地址值都是这么计算的
            addr = pack(rs1_val_s + unpack(signExtend(imm12_I)));
            //不确定这里对不对？？？
            f  = Data_Forward{ rd_valid:False};
            rv = Data_EX_MEM { op_stageMEM : OP_StageMEM_LD,
                               valid_instr:valid_instr,
                               addr : addr };
        end
        else if(op==op_STORE)
        begin
            addr = pack(rs1_val_s + unpack(signExtend(imm12_S)));
            f  = Data_Forward{ rd_valid:False };
            rv = Data_EX_MEM { op_stageMEM : OP_StageMEM_ST,
                               addr : addr,
                               valid_instr:valid_instr,
                               val  : rs2_val };
        end
        else if(op==op_BRANCH)
        begin
            f  = Data_Forward{ rd_valid:False };
            rv = Data_EX_MEM { op_stageMEM : OP_StageMEM_NONE ,valid_instr:valid_instr};
        end        
        else if(op==op_JAL || op==op_JALR)
        begin
            f  = Data_Forward{ rd_valid:False };
            rv = Data_EX_MEM { op_stageMEM :OP_StageMEM_ALU,val:pc,valid_instr:valid_instr };
        end        
        
        //写寄存器
        reg_ex_mem      <= rv;
        reg_forward_mem <= f;
    
    endmethod



    method Data_EX_MEM out;
        return reg_ex_mem;
    endmethod

endmodule

endpackage