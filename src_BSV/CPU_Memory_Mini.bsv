// package CPU_Memory_Mini;

// import ISA_Decls_Mini ::*;
// import BRAMCore ::*;
// // import CPU_Globals_Mini::*;
// //interface BRAM_PORT_BE#(type addr, type data, numeric type n);
// // method Action put(Bool write, addr address, data datain);
// // method data read();
// //参数n不太清楚，但是只能取4,8,32？？？
// //参数BOOL不确定？？？

// //IM
// Integer imemSize = 1024;
// typedef BRAM_PORT#(Addr,Instr) CPU_IM_IFC;
// //DM
// Integer dmemSize = 1024;
// typedef BRAM_PORT_BE#(Addr,WordXL,8) CPU_DM_IFC;


// module mkCPU_IM (CPU_IM_IFC);

//     CPU_IM_IFC im <- mkBRAMCore1Load(imemSize,True,"imem.txt",True);

//     method Action put(Bool write, addr address, data datain);

//     method data read();
     
// endmodule


// module mkCPU_DM (CPU_DM_IFC);

//     CPU_DM_IFC dm <- mkBRAMCore1BELoad(dmemSize,True,"dmem.txt",False);

// endmodule
// endpackage