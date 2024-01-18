#!/bin/bash
#SBATCH -ptest
#SBATCH -N1
#SBATCH -n2
#SBATCH -c4
export IPM_REPORT=full
export IPM_REPORT_MEM=yes
export IPM_LOG=full
export LD_PRELOAD=/opt/ipm/lib/libipm.so
export IPM_HPM=“PAPI_TOT_INS,PAPI_TOT_CYC,PAPI_REF_CYC,\
PAPI_SP_OPS,PAPI_DP_OPS,PAPI_VEC_SP,PAPI_VEC_DP”

## ipm_parse -html pp23s13.1698111831.672602.ipm.xml
srun ./test 1MB.test 1MB.enc