# AES Internal Parallelization and ECB/CTR Block Parallelization
This repo was forked from [kokke's tiny-AES-c](https://github.com/kokke/tiny-AES-c), for more information about AES implementation, refer to its README. This README focuses on the parallelization.

# Overview
In this repo we implemented two versions of parallelized AES:
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
The parameters of parallelism (number of processes, GPUs, ...) should be set depending on which version and which parallelization package you choose. Refer to MPI, OpenMP, or Cuda documents to get details on how to run those programs. In general, it should be like

    ./test <input_filename> <output_filenmae> <mode>
e.g. 

    ./test 1MB.test 1MB.out CTR
    mpirun -np 2 ./test 1MB.test 1MB.out CTR #for MPI

# CPU Version
The main functions are in test.c
We used MPI to parallelize cipher blocks, which is straightforward as there are no data dependencies when in ECB/CTR mode. OpenMP to parallelize internal AES routines (performed badly), which can be turned off.
There are two flags that can be set in AES.h
- PARALLEL: define it if you wish to parallelize AES internal routines with OpenMP, which will reduce the performance.
- TEST_CORRECTNESS: define it if you wish to check the correctness of the code. It invokes functions that test the program with predefined input and expected output of different modes of AES.
# GPU Version
We experimented with two methods:
1. Each Cuda thread is responsible for a byte of a cipher block, and each Cuda block corresponds to a cipher block. (Parallelize internal AES routines)
2. Each Cuda thread is responsible for a cipher block, each Cuda block conprises 512 threads. (No parallelization of internal AES routines)

Results showed that method 2 performs significantly better, in line with the discovery in CPU version.

# Analysis
## Input sizes
CPU: 

![Parallelize ECB mode with 16 Processes](https://github.com/ssuyung/tiny-AES-c/assets/39045469/0b6b4073-058c-443e-84fb-081b1ac6aee7)

GPU: 

![chart](https://github.com/ssuyung/tiny-AES-c/assets/39045469/2be6bf0a-2410-41de-8fca-12c7c6975737)

## Parallelize internal AES routines or not?
CPU:

![Comparing with or without AES internal parallelization (ECB)](https://github.com/ssuyung/tiny-AES-c/assets/39045469/a1fad71f-85aa-4412-856e-5b0055faefbb)

GPU (Method 2 does not parallelize AES internal routines while method 1 does): 

![chart-2](https://github.com/ssuyung/tiny-AES-c/assets/39045469/3416ccd0-90b0-4dfa-b362-52c19d095b02)

It is obvious that parallelizing AES itself is not an efficient or meaningful approach. This outcome arises from the fact that a cipher block consists of only 16 bytes, therefore creating threads to execute simple calculations leads to an overhead exceeding its parallelism, which is also supported by the paper "Parallelization of Cryptographic Algorithm Based on Different Parallel Computing Technologies"
![unnamed-2](https://github.com/ssuyung/tiny-AES-c/assets/39045469/1a622516-ca54-4c75-8ac0-c7dec0b9e2b5)
[1] Mochurad, L., & Shchur, G. (2021, March). Parallelization of Cryptographic Algorithm Based on Different Parallel Computing Technologies. In IT&AS (pp. 20-29).


## Strong Scalability
CPU:

![Strong Scalability (Using 512 MB input)](https://github.com/ssuyung/tiny-AES-c/assets/39045469/4dc4298e-d4f5-4c24-9a10-511f5e6bb7ce)

CPU and GPU:

![Strong Scalability (Using 512 MB input)-2](https://github.com/ssuyung/tiny-AES-c/assets/39045469/5a8ae43a-8e32-423f-9a35-6d4017222788)

Both scales well, in line with our expectation as the cipher blocks are independent.

## Weak Scalability 
CPU: 

![Weak Scalability (8MB data for each process)](https://github.com/ssuyung/tiny-AES-c/assets/39045469/14d42d27-5509-4ce9-bb11-67fe87d17c80)

Scales well too, for the same reason.
## ECB vs CTR
We also found that CTR and ECB perform almost the same, as CTR only consists of one extra XOR step.

![chart-3](https://github.com/ssuyung/tiny-AES-c/assets/39045469/cf717bee-3b2b-4538-a65a-f90dca196a05)

# Encryption Throughput
