# 1. module load mpi
# 2. make
# /home/pp23/share/hw1/testcases/10.out
srun -pjudge -N8 -n16 ./test ./testcase/16MB.test 16MB.out

srun -pjudge -N1 -n2 ./encrypt_ECB ./testcase/16MB.test 16MB.out
# generate binary file of 'filesize' KB named 'filename'
# dd if=/dev/zero of=filename bs=1024 count=0 seek=filesize

# dd if=/dev/zero of=./testcase/8MB.test bs=1024 count=0 seek=$[8*1024]