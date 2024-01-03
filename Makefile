CC:=gcc
exe:=test
obj:=test.o aes.o 

# all:$(obj)
#  $(CC) -o $(exe) $(obj)  
test: test.o aes.o
	$(CC) -o test test.o aes.o
# test.o: test.c aes.h
# 	$(CC) -c test.c
# aes.o: aes.c aes.h
# 	$(CC) -c aes.c

%.o:%.c
	$(CC) -c $^ -o $@

.PHONY:clean
clean:
	rm -rf $(obj) $(exe)