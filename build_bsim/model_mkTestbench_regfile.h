/*
 * Generated by Bluespec Compiler (build 6a8cedf)
 * 
 * On Thu May  7 13:38:37 CST 2020
 * 
 */

/* Generation options: keep-fires */
#ifndef __model_mkTestbench_regfile_h__
#define __model_mkTestbench_regfile_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"

#include "bs_model.h"
#include "mkTestbench_regfile.h"

/* Class declaration for a model of mkTestbench_regfile */
class MODEL_mkTestbench_regfile : public Model {
 
 /* Top-level module instance */
 private:
  MOD_mkTestbench_regfile *mkTestbench_regfile_instance;
 
 /* Handle to the simulation kernel */
 private:
  tSimStateHdl sim_hdl;
 
 /* Constructor */
 public:
  MODEL_mkTestbench_regfile();
 
 /* Functions required by the kernel */
 public:
  void create_model(tSimStateHdl simHdl, bool master);
  void destroy_model();
  void reset_model(bool asserted);
  void get_version(unsigned int *year,
		   unsigned int *month,
		   char const **annotation,
		   char const **build);
  time_t get_creation_time();
  void * get_instance();
  void dump_state();
  void dump_VCD_defs();
  void dump_VCD(tVCDDumpType dt);
};

/* Function for creating a new model */
extern "C" {
  void * new_MODEL_mkTestbench_regfile();
}

#endif /* ifndef __model_mkTestbench_regfile_h__ */