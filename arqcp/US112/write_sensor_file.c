#include <stdio.h>
#include "write_sensor_file.h"

void write_sensor_file(Sensor *sensor){
    FILE *fp;
    fp = fopen("sensores.csv", "a");
    fprintf(fp, "%d,%c,%d,%d,%ld,%ld", sensor->id, sensor->sensor_type, sensor->max_limit, sensor->min_limit, sensor->frequency, sensor->readings_size);
    for (int i = 0; i < sensor->readings_size; i++) {
        fprintf(fp, ",%d", sensor->readings[i]);
    }
    fprintf(fp, "\n");
    fclose(fp);
}