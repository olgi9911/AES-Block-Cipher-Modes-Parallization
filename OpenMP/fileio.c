#include <stdio.h>
#include <stdlib.h>
int main(int argc, char **argv){
    if(argc != 2) {
        printf("argc should be 2 instead of %d\n",argc);
        return 1;
    }

    FILE *fd = fopen(argv[1],"rb");
    if(fd == NULL){
        printf("Failed to open file\n");
        return 1;
    }

    
    fseek(fd,0,SEEK_END);
    int fsize = ftell(fd);
    printf("file size = %d bytes\n",fsize);
    rewind(fd);

    __uint8_t *buffer = (__uint8_t*) malloc(sizeof(__uint8_t)*fsize);

    int tmp = fread(buffer, sizeof(__uint8_t), fsize, fd);
    printf("successfully read %d bytes\n",tmp);
    fclose(fd);

    // printf("hello world\n");
    return 0;
}