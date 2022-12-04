#define SECDAY 86400
#include <stdlib.h>
#include "checkValueInRange.h"
#include <stdint.h>
#include "../US101/pcg32_random_r.h"
#include <stdio.h>
#include "../US102/sens_dir_vento.h"
#include "../US102/sens_humd_atm.h"
#include "../US102/sens_humd_solo.h"
#include "../US102/sens_pluvio.h"
#include "../US102/sens_temp.h"
#include "../US102/sens_velc_vento.h"
uint64_t state = 0;
uint64_t inc = 0;

unsigned short *createArrayDirVento(unsigned short max, unsigned short min, unsigned int freq, int n)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    unsigned short *vec = malloc(size * sizeof(short));
    do
    {
        maxErrorReached = 0;
        short comp_rand = (short)pcg32_random_r();
        vec[0] = sens_dir_vento(0, comp_rand);
        for (int i = 1; i < size && maxErrorReached != 1; i++)
        {
            comp_rand = (short)pcg32_random_r();
            *(vec + i) = sens_dir_vento(*(vec + i - 1), comp_rand);
            char valid = checkValueInRangeUS(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count == n)
            {
                maxErrorReached = 1;
            }
        }
        if (maxErrorReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(short));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (maxErrorReached != 0);
    return vec;
}

unsigned char *createArrayHumAtm(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(char));
    do
    {
        maxErrorReached = 0;
        char comp_rand = (unsigned char)pcg32_random_r();
        unsigned ult_pluvio = *(pluvio + 0);
        vec[0] = sens_humd_atm(20, ult_pluvio, comp_rand);
        for (int i = 1; i < size && maxErrorReached != 1; i++)
        {
            comp_rand = (unsigned char)pcg32_random_r();
            *(vec + i) = sens_humd_atm(*(vec + i - 1), ult_pluvio, comp_rand);
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
            if (count == n)
            {
                maxErrorReached = 1;
            }
        }
        if (maxErrorReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(char));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (maxErrorReached != 0);
    return vec;
}

unsigned char *createArrayHumSolo(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(char));
    do
    {
        maxErrorReached = 0;
        char comp_rand = (unsigned char)pcg32_random_r();
        unsigned ult_pluvio = *(pluvio + 0);
        vec[0] = sens_humd_solo(20, ult_pluvio, comp_rand);
        for (int i = 1; i < size && maxErrorReached != 1; i++)
        {
            comp_rand = (unsigned char)pcg32_random_r();
            *(vec + i) = sens_humd_solo(*(vec + i - 1), ult_pluvio, comp_rand);
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
            if (count == n)
            {
                maxErrorReached = 1;
            }
        }
        if (maxErrorReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(char));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (maxErrorReached != 0); 
    return vec;
}

unsigned char *createArrayPluvio(unsigned char max, unsigned char min, unsigned int freq, int n, char *temp)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(char));
    do
    {
        maxErrorReached = 0;
        char comp_rand = (unsigned char)pcg32_random_r();
        char ult_temp = *(temp + 0);
        vec[0] = sens_pluvio(55, ult_temp, comp_rand);
        for (int i = 1; i < size && maxErrorReached != 1; i++)
        {
            comp_rand = (unsigned char)pcg32_random_r();
            *(vec + i) = sens_pluvio(*(vec + i - 1), ult_temp, comp_rand);
            ult_temp = *(temp + i);
            char valid = checkValueInRangeUC(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count == n)
            {
                maxErrorReached = 1;
            }
        }
        if (maxErrorReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(char));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (maxErrorReached != 0);
    return vec;
}

char *createArrayTemp(char max, char min, unsigned int freq, int n)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    char *vec = malloc(size * sizeof(char));
    do
    {
        maxErrorReached = 0;
        char comp_rand = (char)pcg32_random_r();
        vec[0] = sens_temp(15, comp_rand);
        for (int i = 1; i < size && maxErrorReached != 1; i++)
        {
            comp_rand = (char)pcg32_random_r();
            *(vec + i) = sens_temp(*(vec + i - 1), comp_rand);
            char valid = checkValueInRangeChar(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count == n)
            {
                maxErrorReached = 1;
            }
        }
        if (maxErrorReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(char));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (maxErrorReached != 0);
    return vec;
}

unsigned char *createArrayVelVento(unsigned char max, unsigned char min, unsigned int freq, int n)
{
    int count = 0;
    char maxErrorReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(char));
    do
    {
        maxErrorReached = 0;
        char comp_rand = (char) pcg32_random_r();
        vec[0] = sens_velc_vento(20, comp_rand);
        for (int i = 1; i < size && maxErrorReached != 1; i++)
        {
            comp_rand = (char) pcg32_random_r();
            *(vec + i) = sens_velc_vento(*(vec + i - 1), comp_rand);
            char valid = checkValueInRangeUC(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count == n)
            {
                maxErrorReached = 1;
            }
        }
        if (maxErrorReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(char));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (maxErrorReached != 0); 
    return vec;
}