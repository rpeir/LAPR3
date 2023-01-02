#include <stdio.h>
#include "../US104/createArray.h"
#include "../US103/dailyValues.h"
#include "../US103/createMatrix.h"
#include "../Constants.h"
#include "../US112/write_sensor_file.h"
#include "../US112/write_matrix_file.h"

int main() {
    int n = 5;
    
    char* temps = createArrayTemp(MAX_TEMP, MIN_TEMP, FREQ_TEMP, n);
    unsigned char* velVents = createArrayVelVento(MAX_WVEL, MIN_WVEL, FREQ_WVEL, n);
    unsigned short* dirVents = createArrayDirVento(MAX_WINDDEG, MIN_WINDDEG, FREQ_WINDDEG, n);
    unsigned char* pluvios = createArrayPluvio(MAX_PLUV, MIN_PLUV, FREQ_PLUV, n, temps);
    unsigned char* humAtms = createArrayHumAtm(MAX_ATMHUM, MIN_ATMHUM, FREQ_ATMHUM, n, pluvios);
    unsigned char* humSolos = createArrayHumSolo(MAX_SOILHUM, MIN_SOILHUM, FREQ_SOILHUM, n, pluvios);

    char* tempsValues = dailyCharValues(temps, FREQ_TEMP);
    unsigned char* pluviosValues = dailyUCharValues(pluvios, FREQ_PLUV);
    unsigned char* humAtmsValues = dailyUCharValues(humAtms, FREQ_ATMHUM);
    unsigned char* humSolosValues = dailyUCharValues(humSolos, FREQ_SOILHUM);
    unsigned char* velVentsValues = dailyUCharValues(velVents, FREQ_WVEL);
    unsigned short* dirVentsValues = dailyUShortValues(dirVents, FREQ_WINDDEG);

    short** matrix = createMatrix(tempsValues, velVentsValues, dirVentsValues, humAtmsValues, humSolosValues, pluviosValues);

    char sens_names[6][22] = {"Temperatura", "Velocidade do Vento", "Direcao do Vento", "Humidade Atmosferica", "Humidade do Solo", "Pluviometria"};
    char sens_units[6][22] = {"Celsius", "Km/h", "Graus", "%", "%", "mm"};
    printf("Sensor: Max, Min, Media\n");
    for (int sensor = 0; sensor < 6; sensor++) {
        printf("%s: %d, %d, %d %s\n", sens_names[sensor], matrix[sensor][0], matrix[sensor][1], matrix[sensor][2], sens_units[sensor]);
    }
    //test write_sensor_file & write_matrix_file
    Sensor sensor;
    sensor.id = 1;
    sensor.sensor_type = 'c';
    sensor.max_limit = 100;
    sensor.min_limit = 0;
    sensor.frequency = 1;
    sensor.readings_size = 3;
    unsigned short readings[3] = {1, 2, 3};
    sensor.readings = readings;

    Sensor sensor2;
    sensor2.id = 2;
    sensor2.sensor_type = 'b';
    sensor2.max_limit = 110;
    sensor2.min_limit = 2;
    sensor2.frequency = 2;
    sensor2.readings_size = 4;
    unsigned short readings2[4] = {1, 2, 3, 4};
    sensor2.readings = readings2;

    write_sensor_file(&sensor);
    write_sensor_file(&sensor2);
    write_matrix_file(matrix);
    //end test
    return 0;
}