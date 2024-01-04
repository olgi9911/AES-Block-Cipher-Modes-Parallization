CC:=mpicc
exe:=test
obj:=test.o aes.o fileio
CFLAGS = -lm -O3 -fopenmp
# all:$(obj)
#  $(CC) -o $(exe) $(obj)  
test: test.o aes.o
	$(CC) $(CFLAGS) -o test test.o aes.o 
# test.o: test.c aes.h
# 	$(CC) -c test.c
# aes.o: aes.c aes.h
# 	$(CC) -c aes.c

fileio: fileio.c
	$(CC) $(CFLAGS) $^ -o fileio
%.o:%.c
	$(CC) $(CFLAGS) -c $^ -o $@

.PHONY:clean
clean:
	rm -rf $(obj) $(exe)