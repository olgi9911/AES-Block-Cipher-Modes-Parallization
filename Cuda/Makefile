CC:=gcc
NVCC:=nvcc
NVFLAGS  := -std=c++11 -O3 -Xptxas="-v" -arch=sm_61 -Xcompiler
exe:=test
obj:=test.o aes.o 
CFLAGS = -lm -O3
# all:$(obj)
#  $(CC) -o $(exe) $(obj)  
test:
	nvcc -o test aes.cu test.c
#	$(NVCC) $(NVFLAGS) -o test aes.cu test.c
#test.o: test.c aes.h
#	$(CC) $(CFLAGS) -c test.c
#aes.o: aes.cu aes.h
#	$(NVCC) $(NVFLAGS) -c aes.cu

#%.o:%.c
#	$(CC) $(CFLAGS) -c $^ -o $@

.PHONY:clean
clean:
	rm -rf $(obj) $(exe)