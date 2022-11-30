#define SECDAY 86400
#include <stdlib.h>
#include "checkValueInRangeChar.h"
#include <stdint.h>
#include "pcg32_random_r.h"
#include <stdio.h>
uint64_t state = 0;
uint64_t inc = 0;
unsigned char *createArrayHumAtm(unsigned char max, unsigned char min, unsigned int freq, int n, char *temp, unsigned char *pluvio)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(int));
    do
    {
        char comp_rand = (unsigned char)pcg32_random_r();
        vec[0] = sens_humd_atm(0, 0, comp_rand);
        char ult_temp = *(tempo + 0);
        unsigned ult_pluvio = *(pluvio + 0);
        for (int i = 1; i < size && maxErrorReached != 0, i++)
        {
            comp_rand = (unsigned char)pcg32_random_r();
            *(vec + i) = sens_humd_atm(*(vec + i - 1), ult_pluvio, comp_rand);
            ult_temp = *(temp + i);
            ult_pluvio = *(pluvio + i);
            char valid = checkValueInRangeUC(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count = n)
            {
                maxErrorReached = 1;
            }
        }
        if (maxErrorReached = 1)
        {
            free(vec);
            vec = malloc(size * sizeof(int));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (maxErrorReached != 0) return vec;
}