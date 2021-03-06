package Testbench_pipe;
//目前最新的
import CPU_RegFile_Mini ::*;
import CPU_Globals_Mini ::*;
import CPU_StageIF_Mini ::*;
import CPU_StageID_Mini ::*;
import CPU_StageEX_Mini ::*;
import CPU_StageMEM_Mini ::*;
import CPU_StageWB_Mini ::*;

module mkTestbench_pipe(Empty);

    CPU_RegFile_IFC regfile <- mkCPU_RegFile;

    CPU_StageIF_IFC  s1 <- mkCPU_StageIF;
    CPU_StageID_IFC  s2 <- mkCPU_StageID(regfile);
    CPU_StageEX_IFC  s3 <- mkCPU_StageEX;
    CPU_StageMEM_IFC s4 <- mkCPU_StageMEM;
    CPU_StageWB_IFC  s5 <- mkCPU_StageWB(regfile);

    Reg #(UInt#(32)) step <- mkReg(0);
    
    rule pipe;
        $display("**************************************************************************");
        $display("1:fetch");
        $display("branch_EN is ",s2.out_branch.branch_EN);
        s1.run(s2.out_branch);

        $display("2:decode");
        $display("instr:%b",s1.out.instr);
        $display("valid_instr:%b",s1.out.valid_instr);
        s2.run(s1.out);

        $display("3:execute");
        $display("rs1_val from RF:%b",s2.out.rs1_val);
        $display("rs2_val from RF:%b",s2.out.rs2_val);
        // $display("rs1_val:%0d",s2.out.rs1_val);
        // $display("rs2_val:%0d",s2.out.rs2_val);
        $display("valid_instr:%b",s2.out.valid_instr);
        s3.run(s2.out , s4.out_forward);

        $display("4:mem");
        // $display("addr:%0d",s3.out.addr);
        // $display("val :%0d",s3.out.val);
        $display("addr:%b",s3.out.addr);
        $display("val :%b",s3.out.val);
        $display("valid_instr:%b",s3.out.valid_instr);
        s4.run(s3.out);

        $display("5:write back");//写回级的打印信息在WB模块里
        // $display("rd_valid:%b",s4.out.rd_valid);
        // $display("if valid,write %0d in %0d",s4.out.rd_val,s4.out.rd);
        $display("valid_instr:%b",s4.out.valid_instr);
        s5.run(s4.out);

        step <= step + 1;

    endrule

    //15拍基本就跑完了，肯定后面多几拍，取到的指令是默认值
    rule done(step==8);
        $finish;
    endrule

endmodule

endpackage