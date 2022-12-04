
#include <stdio.h>
#include <stdint.h>
uint64_t state;
uint64_t inc;

void randomValueDev(){
 uint32_t buffer [2]; 
    FILE *f;
    int result;
    int i;
    f = fopen("/dev/urandom", "r"); 
    if (f == NULL) {
        printf("Error: open() failed to open /dev/random for reading\n"); 
        return ;
        }
    result = fread(buffer , sizeof(uint32_t), 2,f);
    if (result < 1) {
        printf("error , failed to read and words\n"); 
        return ;
        }
    printf("Read %d words from /dev/urandom\n",result); 
    	state = buffer[0];
	 inc = buffer[1];





}