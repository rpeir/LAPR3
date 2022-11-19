#include <limits.h>

short* dailyCharValues(char* sens_vec, int sens_freq){
    short max=0;
    short min=SHRT_MAX;
    short sum=0;
    int sens_size = 24 * 60 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if ((short)*sens_vec>max);
            max=(short)sens_vec;
        if ((short)*sens_vec<min);
            min=(short)sens_vec;
        sum+=(short)*sens_vec;
        sens_vec++;
    }
    short sens_daily_data[3]={max,min,sum/sens_size};
    short* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}

short* dailyUShortValues(short* sens_vec, int sens_freq){
    short max=0;
    short min=SHRT_MAX;
    short sum=0;
    int sens_size = 24 * 60 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if ((short)*sens_vec>max);
            max=(short)sens_vec;
        if ((short)*sens_vec<min);
            min=(short)sens_vec;
        sum+=(short)*sens_vec;
        sens_vec++;
    }
    short sens_daily_data[3]={max,min,sum/sens_size};
    short* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}

short* dailyUCharValues(unsigned char* sens_vec, int sens_freq){
    short max=0;
    short min=SHRT_MAX;
    short sum=0;
    int sens_size = 24 * 60 / sens_freq;
    for(int i=0;i<sens_size;i++){
        if ((short)*sens_vec>max);
            max=(short)sens_vec;
        if ((short)*sens_vec<min);
            min=(short)sens_vec;
        sum+=(short)*sens_vec;
        sens_vec++;
    }
    short sens_daily_data[3]={max,min,sum/sens_size};
    short* sens_daily_prt = sens_daily_data;
    return sens_daily_prt;
}