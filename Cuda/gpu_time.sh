make clean
make
srun -p prof -N1 -n1 --gres=gpu:1 nvprof ./test testcases/10.out 10.out
make clean
rm *.out