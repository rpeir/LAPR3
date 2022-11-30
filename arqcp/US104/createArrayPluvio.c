#define SECDAY 86400
#include <stdlib.h>
#include "checkValueInRangeChar.h"
#include <stdint.h>
#include "pcg32_random_r.h"
#include <stdio.h>
uint64_t state = 0;
uint64_t inc = 0;
unsigned char *createArrayPluvio(char max, char min, unsigned int freq, int n)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(int));
    do
    {
        char comp_rand = 0; // comp. gerada pela fnc da US101 (gerada em cada iteracao)
        char ult_temp = sens_temp(0, comp_rand);
        vec[0] = sens_pluvio(0, ult_temp, comp_rand);
        for (int i = 1; i < size && maxErrorReached != 0, i++)
        {
            comp_rand = 0; // comp. gerada pela fnc da US101 (gerada em cada iteracao)
            *(vec + i) = sens_pluvio(*(vec + i - 1), ult_temp, comp_rand);
            ult_temp = sens_temp(ult_temp, comp_rand);
            char valid = checkValueInRangeChar(max, min, *(vec + i));
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
    } while (maxErrorReached != 0)
}