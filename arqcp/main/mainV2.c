#include <stdio.h>
#include <stdint.h>
#include "../US104/createArray.h"
#include "../US103/dailyValues.h"
#include "../US103/createMatrix.h"
#include "../Constants.h"

typedef struct {
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit;     //limite máximo
    unsigned short min_limit;     //limite mínimo
    unsigned long frequency;      //frequência de leitura
    unsigned long readings_size;  //tamanho do array de leituras

    unsigned short *readings;     //array de leituras diárias
} Sensor;

int main() {
    // previous main
    int n = 5;

        char* temps = createArrayTemp(MAX_TEMP, MIN_TEMP, FREQ_TEMP, n);
        unsigned char* velVents = createArrayVelVento(MAX_WVEL, MIN_WVEL, FREQ_WVEL, n);
        unsigned short* dirVents = createArrayDirVento(MAX_WINDDEG, MIN_WINDDEG, FREQ_WINDDEG, n);
        unsigned char* pluvios = createArrayPluvio(MAX_PLUV, MIN_PLUV, FREQ_PLUV, n, temps);
        unsigned char* humAtms = createArrayHumAtm(MAX_ATMHUM, MIN_ATMHUM, FREQ_ATMHUM, n, pluvios);
        unsigned char* humSolos = createArrayHumSolo(MAX_SOILHUM, MIN_SOILHUM, FREQ_SOILHUM, n, pluvios);

        char* tempsValues = dailyCharValues(temps, FREQ_TEMP);
        // readings arrays
        unsigned char* pluviosValues = dailyUCharValues(pluvios, FREQ_PLUV);
        unsigned char* humAtmsValues = dailyUCharValues(humAtms, FREQ_ATMHUM);
        unsigned char* humSolosValues = dailyUCharValues(humSolos, FREQ_SOILHUM);
        unsigned char* velVentsValues = dailyUCharValues(velVents, FREQ_WVEL);
        unsigned short* dirVentsValues = dailyUShortValues(dirVents, FREQ_WINDDEG);
    //

    //number of sensors
    int numSensors = 6;

    //readings size
    unsigned long readingsSize = 1440;

    //create an array of sensors dynamically
    Sensor* sensors = (Sensor*) malloc(numSensors * sizeof(Sensor));

    //initialize the sensors dynamically
    for (int i = 0; i < numSensors; i++) {
        sensors[i].id = (unsigned short) i;

        // ask for parameters
        unsigned char sensorType;
        unsigned short max, min;
        unsigned long freq;

        printf("Inserir tipo de sensor: ");
        scanf("%hhu", &sensorType);
        printf("Inserir limite máximo: ");
        scanf("%hu", &max);
        printf("Inserir limite mínimo: ");
        scanf("%hu", &min);
        printf("Inserir frequência: ");
        scanf("%lu", &freq);

        // initialize the sensor
        sensors[i].sensor_type = sensorType;
        sensors[i].max_limit = max;
        sensors[i].min_limit = min;
        sensors[i].frequency = freq;
        sensors[i].readings_size = readingsSize;
        sensors[i].readings = calloc(readingsSize, sizeof(unsigned short));
        // fill the readings array
        for (int j = 0; j < readingsSize; j++) {
            sensors[i].readings[j] =
        }
    }



    return 0;

}