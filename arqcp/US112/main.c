#include "write_sensor_file.h"

int main(){
    Sensor sensor;
    sensor.id = 1;
    sensor.sensor_type = 'c';
    sensor.max_limit = 100;
    sensor.min_limit = 0;
    sensor.frequency = 1;
    sensor.readings_size = 3;
    unsigned short readings[3] = {1, 2, 3};
    sensor.readings = readings;
    write_sensor_file(&sensor);


    return 0;
}