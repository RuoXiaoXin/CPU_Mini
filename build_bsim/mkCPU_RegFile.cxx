/*
 * Generated by Bluespec Compiler (build 6a8cedf)
 * 
 * On Thu May  7 13:38:37 CST 2020
 * 
 */
#include "bluesim_primitives.h"
#include "mkCPU_RegFile.h"


/* Constructor */
MOD_mkCPU_RegFile::MOD_mkCPU_RegFile(tSimStateHdl simHdl, char const *name, Module *parent)
  : Module(simHdl, name, parent),
    __clk_handle_0(BAD_CLOCK_HANDLE),
    INST_regfile(simHdl, "regfile", this, 5u, 32u, (tUInt8)0u, (tUInt8)31u),
    INST_rg_j(simHdl, "rg_j", this, 5u),
    INST_rg_state(simHdl, "rg_state", this, 2u, (tUInt8)0u, (tUInt8)0u),
    PORT_RST_N((tUInt8)1u)
{
  PORT_EN_write_rd = false;
  PORT_read_rs1_rs1 = 0u;
  PORT_read_rs2_rs2 = 0u;
  PORT_write_rd_rd = 0u;
  PORT_write_rd_rd_val = 0u;
  PORT_read_rs1 = 0u;
  PORT_RDY_read_rs1 = false;
  PORT_read_rs2 = 0u;
  PORT_RDY_read_rs2 = false;
  PORT_RDY_write_rd = false;
  symbol_count = 23u;
  symbols = new tSym[symbol_count];
  init_symbols_0();
}


/* Symbol init fns */

void MOD_mkCPU_RegFile::init_symbols_0()
{
  init_symbol(&symbols[0u], "CAN_FIRE_RL_rl_reset_loop", SYM_DEF, &DEF_CAN_FIRE_RL_rl_reset_loop, 1u);
  init_symbol(&symbols[1u],
	      "CAN_FIRE_RL_rl_reset_start",
	      SYM_DEF,
	      &DEF_CAN_FIRE_RL_rl_reset_start,
	      1u);
  init_symbol(&symbols[2u], "CAN_FIRE_read_rs1", SYM_DEF, &DEF_CAN_FIRE_read_rs1, 1u);
  init_symbol(&symbols[3u], "CAN_FIRE_read_rs2", SYM_DEF, &DEF_CAN_FIRE_read_rs2, 1u);
  init_symbol(&symbols[4u], "CAN_FIRE_write_rd", SYM_DEF, &DEF_CAN_FIRE_write_rd, 1u);
  init_symbol(&symbols[5u], "EN_write_rd", SYM_PORT, &PORT_EN_write_rd, 1u);
  init_symbol(&symbols[6u], "RDY_read_rs1", SYM_PORT, &PORT_RDY_read_rs1, 1u);
  init_symbol(&symbols[7u], "RDY_read_rs2", SYM_PORT, &PORT_RDY_read_rs2, 1u);
  init_symbol(&symbols[8u], "RDY_write_rd", SYM_PORT, &PORT_RDY_write_rd, 1u);
  init_symbol(&symbols[9u], "RL_rl_reset_loop", SYM_RULE);
  init_symbol(&symbols[10u], "RL_rl_reset_start", SYM_RULE);
  init_symbol(&symbols[11u], "read_rs1", SYM_PORT, &PORT_read_rs1, 32u);
  init_symbol(&symbols[12u], "read_rs1_rs1", SYM_PORT, &PORT_read_rs1_rs1, 5u);
  init_symbol(&symbols[13u], "read_rs2", SYM_PORT, &PORT_read_rs2, 32u);
  init_symbol(&symbols[14u], "read_rs2_rs2", SYM_PORT, &PORT_read_rs2_rs2, 5u);
  init_symbol(&symbols[15u], "regfile", SYM_MODULE, &INST_regfile);
  init_symbol(&symbols[16u], "rg_j", SYM_MODULE, &INST_rg_j);
  init_symbol(&symbols[17u], "rg_state", SYM_MODULE, &INST_rg_state);
  init_symbol(&symbols[18u],
	      "WILL_FIRE_RL_rl_reset_loop",
	      SYM_DEF,
	      &DEF_WILL_FIRE_RL_rl_reset_loop,
	      1u);
  init_symbol(&symbols[19u],
	      "WILL_FIRE_RL_rl_reset_start",
	      SYM_DEF,
	      &DEF_WILL_FIRE_RL_rl_reset_start,
	      1u);
  init_symbol(&symbols[20u], "WILL_FIRE_write_rd", SYM_DEF, &DEF_WILL_FIRE_write_rd, 1u);
  init_symbol(&symbols[21u], "write_rd_rd", SYM_PORT, &PORT_write_rd_rd, 5u);
  init_symbol(&symbols[22u], "write_rd_rd_val", SYM_PORT, &PORT_write_rd_rd_val, 32u);
}


/* Rule actions */

void MOD_mkCPU_RegFile::RL_rl_reset_start()
{
  INST_rg_state.METH_write((tUInt8)1u);
  INST_rg_j.METH_write((tUInt8)1u);
}

void MOD_mkCPU_RegFile::RL_rl_reset_loop()
{
  tUInt8 DEF_x__h344;
  tUInt8 DEF_rg_j_EQ_31___d6;
  tUInt8 DEF_i__h319;
  DEF_i__h319 = INST_rg_j.METH_read();
  DEF_rg_j_EQ_31___d6 = DEF_i__h319 == (tUInt8)31u;
  DEF_x__h344 = (tUInt8)31u & (DEF_i__h319 + (tUInt8)1u);
  INST_regfile.METH_upd(DEF_i__h319, 0u);
  INST_rg_j.METH_write(DEF_x__h344);
  if (DEF_rg_j_EQ_31___d6)
    INST_rg_state.METH_write((tUInt8)2u);
}


/* Methods */

tUInt32 MOD_mkCPU_RegFile::METH_read_rs1(tUInt8 ARG_read_rs1_rs1)
{
  tUInt8 DEF_read_rs1_rs1_EQ_0___d7;
  tUInt32 DEF_x__h390;
  PORT_read_rs1_rs1 = ARG_read_rs1_rs1;
  DEF_x__h390 = INST_regfile.METH_sub(ARG_read_rs1_rs1);
  DEF_read_rs1_rs1_EQ_0___d7 = ARG_read_rs1_rs1 == (tUInt8)0u;
  PORT_read_rs1 = DEF_read_rs1_rs1_EQ_0___d7 ? 0u : DEF_x__h390;
  return PORT_read_rs1;
}

tUInt8 MOD_mkCPU_RegFile::METH_RDY_read_rs1()
{
  DEF_CAN_FIRE_read_rs1 = (tUInt8)1u;
  PORT_RDY_read_rs1 = DEF_CAN_FIRE_read_rs1;
  return PORT_RDY_read_rs1;
}

tUInt32 MOD_mkCPU_RegFile::METH_read_rs2(tUInt8 ARG_read_rs2_rs2)
{
  tUInt8 DEF_read_rs2_rs2_EQ_0___d9;
  tUInt32 DEF_x__h393;
  PORT_read_rs2_rs2 = ARG_read_rs2_rs2;
  DEF_x__h393 = INST_regfile.METH_sub(ARG_read_rs2_rs2);
  DEF_read_rs2_rs2_EQ_0___d9 = ARG_read_rs2_rs2 == (tUInt8)0u;
  PORT_read_rs2 = DEF_read_rs2_rs2_EQ_0___d9 ? 0u : DEF_x__h393;
  return PORT_read_rs2;
}

tUInt8 MOD_mkCPU_RegFile::METH_RDY_read_rs2()
{
  DEF_CAN_FIRE_read_rs2 = (tUInt8)1u;
  PORT_RDY_read_rs2 = DEF_CAN_FIRE_read_rs2;
  return PORT_RDY_read_rs2;
}

void MOD_mkCPU_RegFile::METH_write_rd(tUInt8 ARG_write_rd_rd, tUInt32 ARG_write_rd_rd_val)
{
  tUInt8 DEF_NOT_write_rd_rd_EQ_0_1___d12;
  PORT_EN_write_rd = (tUInt8)1u;
  DEF_WILL_FIRE_write_rd = (tUInt8)1u;
  PORT_write_rd_rd = ARG_write_rd_rd;
  PORT_write_rd_rd_val = ARG_write_rd_rd_val;
  DEF_NOT_write_rd_rd_EQ_0_1___d12 = !(ARG_write_rd_rd == (tUInt8)0u);
  if (DEF_NOT_write_rd_rd_EQ_0_1___d12)
    INST_regfile.METH_upd(ARG_write_rd_rd, ARG_write_rd_rd_val);
}

tUInt8 MOD_mkCPU_RegFile::METH_RDY_write_rd()
{
  DEF_CAN_FIRE_write_rd = (tUInt8)1u;
  PORT_RDY_write_rd = DEF_CAN_FIRE_write_rd;
  return PORT_RDY_write_rd;
}


/* Reset routines */

void MOD_mkCPU_RegFile::reset_RST_N(tUInt8 ARG_rst_in)
{
  PORT_RST_N = ARG_rst_in;
  INST_rg_state.reset_RST(ARG_rst_in);
}


/* Static handles to reset routines */


/* Functions for the parent module to register its reset fns */


/* Functions to set the elaborated clock id */

void MOD_mkCPU_RegFile::set_clk_0(char const *s)
{
  __clk_handle_0 = bk_get_or_define_clock(sim_hdl, s);
}


/* State dumping routine */
void MOD_mkCPU_RegFile::dump_state(unsigned int indent)
{
  printf("%*s%s:\n", indent, "", inst_name);
  INST_regfile.dump_state(indent + 2u);
  INST_rg_j.dump_state(indent + 2u);
  INST_rg_state.dump_state(indent + 2u);
}


/* VCD dumping routines */

unsigned int MOD_mkCPU_RegFile::dump_VCD_defs(unsigned int levels)
{
  vcd_write_scope_start(sim_hdl, inst_name);
  vcd_num = vcd_reserve_ids(sim_hdl, 22u);
  unsigned int num = vcd_num;
  for (unsigned int clk = 0u; clk < bk_num_clocks(sim_hdl); ++clk)
    vcd_add_clock_def(sim_hdl, this, bk_clock_name(sim_hdl, clk), bk_clock_vcd_num(sim_hdl, clk));
  vcd_write_def(sim_hdl, bk_clock_vcd_num(sim_hdl, __clk_handle_0), "CLK", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "CAN_FIRE_RL_rl_reset_loop", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "CAN_FIRE_RL_rl_reset_start", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "CAN_FIRE_read_rs1", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "CAN_FIRE_read_rs2", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "CAN_FIRE_write_rd", 1u);
  vcd_write_def(sim_hdl, num++, "RST_N", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "WILL_FIRE_RL_rl_reset_loop", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "WILL_FIRE_RL_rl_reset_start", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "WILL_FIRE_write_rd", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "EN_write_rd", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "RDY_read_rs1", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "RDY_read_rs2", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "RDY_write_rd", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "read_rs1", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "read_rs1_rs1", 5u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "read_rs2", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "read_rs2_rs2", 5u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "write_rd_rd", 5u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "write_rd_rd_val", 32u);
  num = INST_regfile.dump_VCD_defs(num);
  num = INST_rg_j.dump_VCD_defs(num);
  num = INST_rg_state.dump_VCD_defs(num);
  vcd_write_scope_end(sim_hdl);
  return num;
}

void MOD_mkCPU_RegFile::dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkCPU_RegFile &backing)
{
  vcd_defs(dt, backing);
  vcd_prims(dt, backing);
}

void MOD_mkCPU_RegFile::vcd_defs(tVCDDumpType dt, MOD_mkCPU_RegFile &backing)
{
  unsigned int num = vcd_num;
  if (dt == VCD_DUMP_XS)
  {
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 5u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 5u);
    vcd_write_x(sim_hdl, num++, 5u);
    vcd_write_x(sim_hdl, num++, 32u);
  }
  else
    if (dt == VCD_DUMP_CHANGES)
    {
      if ((backing.DEF_CAN_FIRE_RL_rl_reset_loop) != DEF_CAN_FIRE_RL_rl_reset_loop)
      {
	vcd_write_val(sim_hdl, num, DEF_CAN_FIRE_RL_rl_reset_loop, 1u);
	backing.DEF_CAN_FIRE_RL_rl_reset_loop = DEF_CAN_FIRE_RL_rl_reset_loop;
      }
      ++num;
      if ((backing.DEF_CAN_FIRE_RL_rl_reset_start) != DEF_CAN_FIRE_RL_rl_reset_start)
      {
	vcd_write_val(sim_hdl, num, DEF_CAN_FIRE_RL_rl_reset_start, 1u);
	backing.DEF_CAN_FIRE_RL_rl_reset_start = DEF_CAN_FIRE_RL_rl_reset_start;
      }
      ++num;
      if ((backing.DEF_CAN_FIRE_read_rs1) != DEF_CAN_FIRE_read_rs1)
      {
	vcd_write_val(sim_hdl, num, DEF_CAN_FIRE_read_rs1, 1u);
	backing.DEF_CAN_FIRE_read_rs1 = DEF_CAN_FIRE_read_rs1;
      }
      ++num;
      if ((backing.DEF_CAN_FIRE_read_rs2) != DEF_CAN_FIRE_read_rs2)
      {
	vcd_write_val(sim_hdl, num, DEF_CAN_FIRE_read_rs2, 1u);
	backing.DEF_CAN_FIRE_read_rs2 = DEF_CAN_FIRE_read_rs2;
      }
      ++num;
      if ((backing.DEF_CAN_FIRE_write_rd) != DEF_CAN_FIRE_write_rd)
      {
	vcd_write_val(sim_hdl, num, DEF_CAN_FIRE_write_rd, 1u);
	backing.DEF_CAN_FIRE_write_rd = DEF_CAN_FIRE_write_rd;
      }
      ++num;
      if ((backing.PORT_RST_N) != PORT_RST_N)
      {
	vcd_write_val(sim_hdl, num, PORT_RST_N, 1u);
	backing.PORT_RST_N = PORT_RST_N;
      }
      ++num;
      if ((backing.DEF_WILL_FIRE_RL_rl_reset_loop) != DEF_WILL_FIRE_RL_rl_reset_loop)
      {
	vcd_write_val(sim_hdl, num, DEF_WILL_FIRE_RL_rl_reset_loop, 1u);
	backing.DEF_WILL_FIRE_RL_rl_reset_loop = DEF_WILL_FIRE_RL_rl_reset_loop;
      }
      ++num;
      if ((backing.DEF_WILL_FIRE_RL_rl_reset_start) != DEF_WILL_FIRE_RL_rl_reset_start)
      {
	vcd_write_val(sim_hdl, num, DEF_WILL_FIRE_RL_rl_reset_start, 1u);
	backing.DEF_WILL_FIRE_RL_rl_reset_start = DEF_WILL_FIRE_RL_rl_reset_start;
      }
      ++num;
      if ((backing.DEF_WILL_FIRE_write_rd) != DEF_WILL_FIRE_write_rd)
      {
	vcd_write_val(sim_hdl, num, DEF_WILL_FIRE_write_rd, 1u);
	backing.DEF_WILL_FIRE_write_rd = DEF_WILL_FIRE_write_rd;
      }
      ++num;
      if ((backing.PORT_EN_write_rd) != PORT_EN_write_rd)
      {
	vcd_write_val(sim_hdl, num, PORT_EN_write_rd, 1u);
	backing.PORT_EN_write_rd = PORT_EN_write_rd;
      }
      ++num;
      if ((backing.PORT_RDY_read_rs1) != PORT_RDY_read_rs1)
      {
	vcd_write_val(sim_hdl, num, PORT_RDY_read_rs1, 1u);
	backing.PORT_RDY_read_rs1 = PORT_RDY_read_rs1;
      }
      ++num;
      if ((backing.PORT_RDY_read_rs2) != PORT_RDY_read_rs2)
      {
	vcd_write_val(sim_hdl, num, PORT_RDY_read_rs2, 1u);
	backing.PORT_RDY_read_rs2 = PORT_RDY_read_rs2;
      }
      ++num;
      if ((backing.PORT_RDY_write_rd) != PORT_RDY_write_rd)
      {
	vcd_write_val(sim_hdl, num, PORT_RDY_write_rd, 1u);
	backing.PORT_RDY_write_rd = PORT_RDY_write_rd;
      }
      ++num;
      if ((backing.PORT_read_rs1) != PORT_read_rs1)
      {
	vcd_write_val(sim_hdl, num, PORT_read_rs1, 32u);
	backing.PORT_read_rs1 = PORT_read_rs1;
      }
      ++num;
      if ((backing.PORT_read_rs1_rs1) != PORT_read_rs1_rs1)
      {
	vcd_write_val(sim_hdl, num, PORT_read_rs1_rs1, 5u);
	backing.PORT_read_rs1_rs1 = PORT_read_rs1_rs1;
      }
      ++num;
      if ((backing.PORT_read_rs2) != PORT_read_rs2)
      {
	vcd_write_val(sim_hdl, num, PORT_read_rs2, 32u);
	backing.PORT_read_rs2 = PORT_read_rs2;
      }
      ++num;
      if ((backing.PORT_read_rs2_rs2) != PORT_read_rs2_rs2)
      {
	vcd_write_val(sim_hdl, num, PORT_read_rs2_rs2, 5u);
	backing.PORT_read_rs2_rs2 = PORT_read_rs2_rs2;
      }
      ++num;
      if ((backing.PORT_write_rd_rd) != PORT_write_rd_rd)
      {
	vcd_write_val(sim_hdl, num, PORT_write_rd_rd, 5u);
	backing.PORT_write_rd_rd = PORT_write_rd_rd;
      }
      ++num;
      if ((backing.PORT_write_rd_rd_val) != PORT_write_rd_rd_val)
      {
	vcd_write_val(sim_hdl, num, PORT_write_rd_rd_val, 32u);
	backing.PORT_write_rd_rd_val = PORT_write_rd_rd_val;
      }
      ++num;
    }
    else
    {
      vcd_write_val(sim_hdl, num++, DEF_CAN_FIRE_RL_rl_reset_loop, 1u);
      backing.DEF_CAN_FIRE_RL_rl_reset_loop = DEF_CAN_FIRE_RL_rl_reset_loop;
      vcd_write_val(sim_hdl, num++, DEF_CAN_FIRE_RL_rl_reset_start, 1u);
      backing.DEF_CAN_FIRE_RL_rl_reset_start = DEF_CAN_FIRE_RL_rl_reset_start;
      vcd_write_val(sim_hdl, num++, DEF_CAN_FIRE_read_rs1, 1u);
      backing.DEF_CAN_FIRE_read_rs1 = DEF_CAN_FIRE_read_rs1;
      vcd_write_val(sim_hdl, num++, DEF_CAN_FIRE_read_rs2, 1u);
      backing.DEF_CAN_FIRE_read_rs2 = DEF_CAN_FIRE_read_rs2;
      vcd_write_val(sim_hdl, num++, DEF_CAN_FIRE_write_rd, 1u);
      backing.DEF_CAN_FIRE_write_rd = DEF_CAN_FIRE_write_rd;
      vcd_write_val(sim_hdl, num++, PORT_RST_N, 1u);
      backing.PORT_RST_N = PORT_RST_N;
      vcd_write_val(sim_hdl, num++, DEF_WILL_FIRE_RL_rl_reset_loop, 1u);
      backing.DEF_WILL_FIRE_RL_rl_reset_loop = DEF_WILL_FIRE_RL_rl_reset_loop;
      vcd_write_val(sim_hdl, num++, DEF_WILL_FIRE_RL_rl_reset_start, 1u);
      backing.DEF_WILL_FIRE_RL_rl_reset_start = DEF_WILL_FIRE_RL_rl_reset_start;
      vcd_write_val(sim_hdl, num++, DEF_WILL_FIRE_write_rd, 1u);
      backing.DEF_WILL_FIRE_write_rd = DEF_WILL_FIRE_write_rd;
      vcd_write_val(sim_hdl, num++, PORT_EN_write_rd, 1u);
      backing.PORT_EN_write_rd = PORT_EN_write_rd;
      vcd_write_val(sim_hdl, num++, PORT_RDY_read_rs1, 1u);
      backing.PORT_RDY_read_rs1 = PORT_RDY_read_rs1;
      vcd_write_val(sim_hdl, num++, PORT_RDY_read_rs2, 1u);
      backing.PORT_RDY_read_rs2 = PORT_RDY_read_rs2;
      vcd_write_val(sim_hdl, num++, PORT_RDY_write_rd, 1u);
      backing.PORT_RDY_write_rd = PORT_RDY_write_rd;
      vcd_write_val(sim_hdl, num++, PORT_read_rs1, 32u);
      backing.PORT_read_rs1 = PORT_read_rs1;
      vcd_write_val(sim_hdl, num++, PORT_read_rs1_rs1, 5u);
      backing.PORT_read_rs1_rs1 = PORT_read_rs1_rs1;
      vcd_write_val(sim_hdl, num++, PORT_read_rs2, 32u);
      backing.PORT_read_rs2 = PORT_read_rs2;
      vcd_write_val(sim_hdl, num++, PORT_read_rs2_rs2, 5u);
      backing.PORT_read_rs2_rs2 = PORT_read_rs2_rs2;
      vcd_write_val(sim_hdl, num++, PORT_write_rd_rd, 5u);
      backing.PORT_write_rd_rd = PORT_write_rd_rd;
      vcd_write_val(sim_hdl, num++, PORT_write_rd_rd_val, 32u);
      backing.PORT_write_rd_rd_val = PORT_write_rd_rd_val;
    }
}

void MOD_mkCPU_RegFile::vcd_prims(tVCDDumpType dt, MOD_mkCPU_RegFile &backing)
{
  INST_regfile.dump_VCD(dt, backing.INST_regfile);
  INST_rg_j.dump_VCD(dt, backing.INST_rg_j);
  INST_rg_state.dump_VCD(dt, backing.INST_rg_state);
}