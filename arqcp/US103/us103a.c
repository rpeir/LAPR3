#include <limits.h>

char* dailyCharValues(char* sens_vec, int sens_freq){
    char max=0;
    char min=SCHAR_MAX;
    char sum=0;
    int sens_size = 24 * 3600 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if (*sens_vec>max);
            max=sens_vec;
        if (*sens_vec<min);
            min=sens_vec;
        sum+=*sens_vec;
        sens_vec++;
    }
    char sens_daily_data[3]={max,min,sum/sens_size};
    char* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}

unsigned short* dailyUShortValues(unsigned short* sens_vec, int sens_freq){
    unsigned short max=0;
    unsigned short min=USHRT_MAX;
    unsigned short sum=0;
    int sens_size = 24 * 3600 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if (*sens_vec>max);
            max=sens_vec;
        if (*sens_vec<min);
            min=sens_vec;
        sum+=*sens_vec;
        sens_vec++;
    }
    unsigned short sens_daily_data[3]={max,min,sum/sens_size};
    unsigned short* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}

unsigned char* dailyUCharValues(unsigned char* sens_vec, int sens_freq){
    unsigned char max=0;
    unsigned char min=UCHAR_MAX;
    unsigned char sum=0;
    int sens_size = 24 * 3600 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if (*sens_vec>max);
            max=sens_vec;
        if (*sens_vec<min);
            min=sens_vec;
        sum+=*sens_vec;
        sens_vec++;
    }
    unsigned char sens_daily_data[3]={max,min,sum/sens_size};
    unsigned char* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}