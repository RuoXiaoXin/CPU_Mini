/*
 * Generated by Bluespec Compiler (build 6a8cedf)
 * 
 * On Thu May  7 13:38:37 CST 2020
 * 
 */
#include "bluesim_primitives.h"
#include "model_mkTestbench_regfile.h"

#include <cstdlib>
#include <time.h>
#include "bluesim_kernel_api.h"
#include "bs_vcd.h"
#include "bs_reset.h"


/* Constructor */
MODEL_mkTestbench_regfile::MODEL_mkTestbench_regfile()
{
  mkTestbench_regfile_instance = NULL;
}

/* Function for creating a new model */
void * new_MODEL_mkTestbench_regfile()
{
  MODEL_mkTestbench_regfile *model = new MODEL_mkTestbench_regfile();
  return (void *)(model);
}

/* Schedule functions */

static void schedule_posedge_CLK(tSimStateHdl simHdl, void *instance_ptr)
       {
	 MOD_mkTestbench_regfile &INST_top = *((MOD_mkTestbench_regfile *)(instance_ptr));
	 tUInt8 DEF_INST_top_INST_dut0_DEF_rg_state__h267;
	 INST_top.DEF_b__h136 = INST_top.INST_c.METH_read();
	 INST_top.DEF_CAN_FIRE_RL_show = primSLT8(1u, 32u, (tUInt32)(INST_top.DEF_b__h136), 32u, 50u);
	 INST_top.DEF_WILL_FIRE_RL_show = INST_top.DEF_CAN_FIRE_RL_show;
	 INST_top.INST_dut0.DEF_WILL_FIRE_write_rd = INST_top.INST_dut0.PORT_EN_write_rd;
	 DEF_INST_top_INST_dut0_DEF_rg_state__h267 = INST_top.INST_dut0.INST_rg_state.METH_read();
	 INST_top.INST_dut0.DEF_CAN_FIRE_RL_rl_reset_loop = DEF_INST_top_INST_dut0_DEF_rg_state__h267 == (tUInt8)1u;
	 INST_top.INST_dut0.DEF_WILL_FIRE_RL_rl_reset_loop = INST_top.INST_dut0.DEF_CAN_FIRE_RL_rl_reset_loop && !(INST_top.INST_dut0.DEF_WILL_FIRE_write_rd);
	 INST_top.INST_dut0.DEF_CAN_FIRE_RL_rl_reset_start = DEF_INST_top_INST_dut0_DEF_rg_state__h267 == (tUInt8)0u;
	 INST_top.INST_dut0.DEF_WILL_FIRE_RL_rl_reset_start = INST_top.INST_dut0.DEF_CAN_FIRE_RL_rl_reset_start;
	 if (INST_top.DEF_WILL_FIRE_RL_show)
	   INST_top.RL_show();
	 if (INST_top.INST_dut0.DEF_WILL_FIRE_RL_rl_reset_loop)
	   INST_top.INST_dut0.RL_rl_reset_loop();
	 if (INST_top.INST_dut0.DEF_WILL_FIRE_RL_rl_reset_start)
	   INST_top.INST_dut0.RL_rl_reset_start();
	 if (do_reset_ticks(simHdl))
	 {
	   INST_top.INST_dut0.INST_rg_state.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_c.rst_tick__clk__1((tUInt8)1u);
	 }
       };

/* Model creation/destruction functions */

void MODEL_mkTestbench_regfile::create_model(tSimStateHdl simHdl, bool master)
{
  sim_hdl = simHdl;
  init_reset_request_counters(sim_hdl);
  mkTestbench_regfile_instance = new MOD_mkTestbench_regfile(sim_hdl, "top", NULL);
  bk_get_or_define_clock(sim_hdl, "CLK");
  if (master)
  {
    bk_alter_clock(sim_hdl, bk_get_clock_by_name(sim_hdl, "CLK"), CLK_LOW, false, 0llu, 5llu, 5llu);
    bk_use_default_reset(sim_hdl);
  }
  bk_set_clock_event_fn(sim_hdl,
			bk_get_clock_by_name(sim_hdl, "CLK"),
			schedule_posedge_CLK,
			NULL,
			(tEdgeDirection)(POSEDGE));
  (mkTestbench_regfile_instance->INST_dut0.set_clk_0)("CLK");
  (mkTestbench_regfile_instance->set_clk_0)("CLK");
}
void MODEL_mkTestbench_regfile::destroy_model()
{
  delete mkTestbench_regfile_instance;
  mkTestbench_regfile_instance = NULL;
}
void MODEL_mkTestbench_regfile::reset_model(bool asserted)
{
  (mkTestbench_regfile_instance->reset_RST_N)(asserted ? (tUInt8)0u : (tUInt8)1u);
}
void * MODEL_mkTestbench_regfile::get_instance()
{
  return mkTestbench_regfile_instance;
}

/* Fill in version numbers */
void MODEL_mkTestbench_regfile::get_version(unsigned int *year,
					    unsigned int *month,
					    char const **annotation,
					    char const **build)
{
  *year = 0u;
  *month = 0u;
  *annotation = NULL;
  *build = "6a8cedf";
}

/* Get the model creation time */
time_t MODEL_mkTestbench_regfile::get_creation_time()
{
  
  /* Thu May  7 05:38:37 UTC 2020 */
  return 1588829917llu;
}

/* State dumping function */
void MODEL_mkTestbench_regfile::dump_state()
{
  (mkTestbench_regfile_instance->dump_state)(0u);
}

/* VCD dumping functions */
MOD_mkTestbench_regfile & mkTestbench_regfile_backing(tSimStateHdl simHdl)
{
  static MOD_mkTestbench_regfile *instance = NULL;
  if (instance == NULL)
  {
    vcd_set_backing_instance(simHdl, true);
    instance = new MOD_mkTestbench_regfile(simHdl, "top", NULL);
    vcd_set_backing_instance(simHdl, false);
  }
  return *instance;
}
void MODEL_mkTestbench_regfile::dump_VCD_defs()
{
  (mkTestbench_regfile_instance->dump_VCD_defs)(vcd_depth(sim_hdl));
}
void MODEL_mkTestbench_regfile::dump_VCD(tVCDDumpType dt)
{
  (mkTestbench_regfile_instance->dump_VCD)(dt,
					   vcd_depth(sim_hdl),
					   mkTestbench_regfile_backing(sim_hdl));
}