#include <stdio.h>
#include "write_sensor_file.h"


void write_sensor_file(Sensor *sensor){
    FILE *fp;
    fp = fopen("sensores.csv", "a");                        //create or open file in append mode
    fprintf(fp, "%d,%c,%d,%d,%ld,%ld", sensor->id, sensor->sensor_type, sensor->max_limit, sensor->min_limit, sensor->frequency, sensor->readings_size);        //write sensor data
    for (int i = 0; i < sensor->readings_size; i++) {       //iterate through readings
        if (sensor->sensor_type == 'T'){
            fprintf(fp, ",%d", *((char*) (sensor->readings)+ i));
        }else if (sensor->sensor_type == 'D'){
            fprintf(fp, ",%d", *((unsigned short*) (sensor->readings)+ i));
        }else {
            fprintf(fp, ",%d", *((unsigned char*) (sensor->readings)+ i));
        }
    }
    fprintf(fp, "\n");
    fclose(fp);                                             //close file
}