# AES Internal Parallelization and ECB/CTR Block Parallelization
This repo was forked from [kokke's tiny-AES-c](https://github.com/kokke/tiny-AES-c), for more information about AES implementation, refer to its README. This README focuses on the parallelization.

# Overview
In this repo we implemented two version of parallelized AES:
- CPU version with MPI + OpenMP
- GPU version with Cuda

The corresponding files are in saparate directories. 

We experimented with two levels of parallelization: 
- Parallelization on AES internal routines (Subbytes, Shiftrows, ...)
- Cipher block parallelization (Only implemented ECB & CTR modes, as they have no data dependencies)

The first one didn't perform well. In fact, it runs way slower if we parallelize the internal routines of AES. We reasoned that a cipher block consists of only 16 bytes, therefore creating threads to execute simple calculations leads to an overhead exceeding its parallelism.

# Compilation

    cd CPU or cd Cuda
    make
# Run
## CPU Version
    mpirun -n<number_of_processes> ./test <input_filename> <output_filenmae> <mode>
    e.g., mpirun -n4 ./test 1MB.test 1MB.out CTR
## GPU Version

# CPU Version
MPI to parallelize cipher blocks, which is straightforward as there are no data dependencies when in ECB/CTR mode. OpenMP to parallelize internal AES routines (performed badly).
There are two flags that can be set in AES.h
- PARALLEL: define it if you wish to parallelize AES internal routines with OpenMP, which will reduce the performance.
- TEST_CORRECTNESS: define it if you wish to check the correctness of the code. It invokes functions that test the program with predefined input and expected output of different modes of AES.
# GPU Version

