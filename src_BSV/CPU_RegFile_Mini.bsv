package CPU_RegFile_Mini;

export CPU_RegFile_IFC (..), mkCPU_RegFile;

import RegFile      :: *;
import ISA_Decls_Mini :: *;

interface CPU_RegFile_IFC;
   method WordXL read_rs1 (RegName rs1) ;
   method WordXL read_rs2 (RegName rs2) ;
   method WordXL read_debug (RegName r);
   // method RF_State temp_read_state ;
   method Action temp_readAll;
   method Action write_rd (RegName rd, WordXL rd_val) ;
endinterface

// typedef enum { RF_RESET_START, RF_RESETTING, RF_RUNNING } RF_State
// deriving (Eq, Bits, FShow);

module mkCPU_RegFile (CPU_RegFile_IFC);

   // Reg #(RF_State) rg_state <- mkReg (RF_RESET_START);

   Reg #(Bool) flag <- mkReg(False);
   RegFile #(RegName, WordXL) regfile <- mkRegFileFullLoad("regfile.txt");

   //这两个rule会不会在同一个时钟周期执行？？？不会，已测试
   // Reg #(RegName) rg_j <- mkRegU;

   //执行一拍
   // rule rl_reset_start (rg_state == RF_RESET_START);
   //    rg_state <= RF_RESETTING;
   //    rg_j <= 1;
   // endrule

   //执行30拍？？？是的
   // rule rl_reset_loop (rg_state == RF_RESETTING);
   //    regfile.upd (rg_j, 0);
   //    rg_j <= rg_j + 1;
   //    if (rg_j == 31)
	//       rg_state <= RF_RUNNING;
   // endrule

   // rule temp_readAll(flag==True);
   // for(Integer i=1;i<=5;i=i+1)
   // begin
   //    $display("RegFile : index=%0d, val=%0d",fromInteger(i),regfile.sub(fromInteger(i)));
   // end
   // $finish;
   // endrule

   method WordXL read_rs1 (RegName rs1);
      return ((rs1 == 0) ? 0 : regfile.sub (rs1));
   endmethod

   method WordXL read_rs2 (RegName rs2);
      return ((rs2 == 0) ? 0 : regfile.sub (rs2));
   endmethod

   method WordXL read_debug (RegName r);
      return ((r ==0) ? 0 : regfile.sub(r));
   endmethod

   method Action write_rd (RegName rd, WordXL rd_val);
      if (rd != 0) regfile.upd (rd, rd_val);
      $display("RegFile:write %0d in %0d",rd_val,rd);
   endmethod

endmodule

endpackage
