package CPU_StageEX_Mini;

import CPU_Globals_Mini ::*;
import ISA_Decls_Mini ::*;

interface CPU_StageEX_IFC;
    method Action run(Data_ID_EX data_id_ex);
    method Data_EX_MEM out;
endinterface

module mkCPU_StageEX(CPU_StageEX_IFC);

    Reg #(Data_EX_MEM) reg_ex_mem <- mkRegU;

    function Data_EX_MEM fv_alu(Data_ID_EX data_id_ex);

        let pc = data_id_ex.pc;
        let di = data_id_ex.decoded_instr;
        let rs1_val = data_id_ex.rs1_val;
        let rs2_val = data_id_ex.rs2_val;
        
        let rd = di.rd;
        let op = di.opcode;
        let f3 = di.funct3;
        let f7 = di.funct7;

        let imm12_I = di.imm12_I;
        let imm12_S = di.imm12_S;

        IntXL rs1_val_s = unpack(rs1_val);
        IntXL rs2_val_s = unpack(rs2_val);
        WordXL result = ?;//ALU计算的数据，或者，S型指令要存的数据
        Addr addr = ?;//MEM访存的地址

        //return value基本值，后面只需要改需要改的部分
        Data_EX_MEM rv = Data_EX_MEM{pc:pc,
                             op_stageMEM:?,
                             f3:f3, //仅用于Load和Store指令
                             val:?,
                             addr:?,
                             rd:rd};
        
        if(op==op_OP)
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

            rv = Data_EX_MEM {  //pc:pc,
                                //rd:rd,
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

            rv = Data_EX_MEM {  //pc:pc,
                                // rd:rd,
                                op_stageMEM : OP_StageMEM_ALU,
                                val : result };

        end
        else if(op==op_LOAD)
        begin
            //地址值都是这么计算的
            addr = pack(rs1_val_s + unpack(signExtend(imm12_I)));
            rv = Data_EX_MEM { op_stageMEM : OP_StageMEM_LD,
                               addr : addr };
        end
        else if(op==op_STORE)
        begin
            addr = pack(rs1_val_s + unpack(signExtend(imm12_S)));
            rv = Data_EX_MEM { op_stageMEM : OP_StageMEM_ST,
                               addr : addr,
                               val  : rs2_val };
        end
        // else if(op==)//

        
        return rv;
    
    endfunction

    method Action run(Data_ID_EX data_id_ex);
        reg_ex_mem <= fv_alu(data_id_ex);
    endmethod

    method Data_EX_MEM out;
        return reg_ex_mem;
    endmethod

endmodule

endpackage