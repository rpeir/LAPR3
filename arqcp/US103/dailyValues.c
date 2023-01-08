#include <limits.h>
#include <stdlib.h>

char* dailyCharValues(char* sens_vec, int sens_freq){
    char max=0;
    char min=SCHAR_MAX;
    int sum=0;
    int sens_size = 24 * 3600 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if (*sens_vec>max)
            max=*sens_vec;
        if (*sens_vec<min)
            min=*sens_vec;
        sum+=*sens_vec;
        sens_vec++;
    }
    char avg=sum/sens_size;
    char *sens_daily_data = malloc(3*sizeof(char));
    *sens_daily_data=max;
    *(sens_daily_data+1)=min;
    *(sens_daily_data+2)=avg;
    char* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}

unsigned short* dailyUShortValues(unsigned short* sens_vec, unsigned long sens_size){
    unsigned short max=0;
    unsigned short min=USHRT_MAX;
    unsigned int sum=0;
    for(unsigned long i=0;i<sens_size;i++){
        if (*sens_vec>max)
            max=*sens_vec;
        if (*sens_vec<min)
            min=*sens_vec;
        sum+=*sens_vec;
        sens_vec++;
    }
    unsigned short avg=sum/(unsigned short) sens_size;
    unsigned short *sens_daily_data = malloc(3*sizeof(short));
    *sens_daily_data=max;
    *(sens_daily_data+1)=min;
    *(sens_daily_data+2)=avg;
    unsigned short* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}

unsigned char* dailyUCharValues(unsigned char* sens_vec, int sens_freq){
    unsigned char max=0;
    unsigned char min=UCHAR_MAX;
    unsigned int sum=0;
    int sens_size = 24 * 3600 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if (*sens_vec>max)
            max=*sens_vec;
        if (*sens_vec<min)
            min=*sens_vec;
        sum+=*sens_vec;
        sens_vec++;
    }
    unsigned char avg=sum/sens_size;
    unsigned char *sens_daily_data = malloc(3*sizeof(char));
    *sens_daily_data=max;
    *(sens_daily_data+1)=min;
    *(sens_daily_data+2)=avg;
    unsigned char* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}