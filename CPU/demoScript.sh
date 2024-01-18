#!/bin/bash
#SBATCH -N8
#SBATCH -n16
#SBATCH -pjudge

srun ./encrypt_decrypt_ECB ./testcase/32MB.test 32MB.out ECB
echo "Running Diff"
diff ./testcase/32MB.test 32MB.out
echo "End of Diff (If no output in between, there is no difference between the two files)"