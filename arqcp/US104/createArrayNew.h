#ifndef CREATE_ARRAY_SENS_H
#define CREATE_ARRAY_SENS_H
#include "../US110/sensores.h"

void fill_sens_dir_vento(Sensor *sensor_dir_vento, int n);

void fill_sens_hum_atm(Sensor *sensor_hum_atm, Sensor* sensor_pluvio, int n);

void fill_sens_hum_solo(Sensor *sensor_hum_solo, Sensor* sensor_pluvio, int n);

void fill_sens_pluvio(Sensor *sensor_pluvio, Sensor *sensor_temp, int n);

void fill_sens_temp(Sensor *sensor_temp, int n);

void fill_sens_vel_vento(Sensor *sensor_vel_vento, int n);

#endif