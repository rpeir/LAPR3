#ifndef CREATE_ARRAY_SENS_H
#define CREATE_ARRAY_SENS_H
#include "../mainS2/sensores.h"

void createArrayDirVento(Sensor *sensor_dir_vento, int n);

void createArrayHumAtm(Sensor *sensor_hum_atm, Sensor* sensor_pluvio, int n);

void createArrayHumSolo(Sensor *sensor_hum_solo, Sensor* sensor_pluvio, int n);

void createArrayPluvio(Sensor *sensor_pluvio, Sensor *sensor_temp, int n);

void createArrayTemp(Sensor *sensor_temp, int n);

void createArrayVelVento(Sensor *sensor_vel_vento, int n);

#endif