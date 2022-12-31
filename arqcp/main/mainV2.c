#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//////////////////////////////////////////////////////////////////////////////////
#define INITIAL_ARRAY_SIZE 10

Sensor* sensors = malloc(INITIAL_ARRAY_SIZE * sizeof(Sensor));
int num_sensors = 0;
int array_size = INITIAL_ARRAY_SIZE;

void add_sensor_to_list(Sensor sensor) {
    if (num_sensors == array_size) {
    array_size *= 2;
    sensors = realloc(sensors, array_size * sizeof(Sensor));
    }

    sensors[num_sensors] = sensor;
    num_sensors++;
}
/////////////////////////////////////////////////////////////////////////////////

typedef struct
{
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit; // limites do sensor
    unsigned short min_limit;
    unsigned long frequency; // frequency de leituras (em segundos)
    unsigned long readings_size; // tamanho do array de leituras
    unsigned short *readings; // array de leituras diárias
    ... // adicionar o que acharem conveniente
} Sensor;


void parse_sensor_line(char* line, Sensor* sensor) {
    char* token;
    char* line_copy = strdup(line);
    // atoi = ascii to integer
    token = strtok(line_copy, ",");
    sensor->id = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->sensor_type = (unsigned char)token[0];

    token = strtok(NULL, ",");
    sensor->max_limit = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->min_limit = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->frequency = (unsigned long)atoi(token);

    // Calculate the size of the readings array
    sensor->readings_size = 86400 / sensor->frequency; // 86400 seconds in a day

    sensor->readings = malloc(sensor->readings_size * sizeof(unsigned short));

    //fill readings array here

    free(line_copy);
}
///////////////////////////////////////////////////////////////////////////////////
int main() {
    // choose if u want to import file or input the info yourself
    int choice;
    printf("1 - Import file\n2 - Input info\n");
    scanf("%d", &choice);

    if(choice==1) {
    FILE* file = fopen("sensores.csv", "r");
    if (file == NULL) {
    perror("Error opening file");
    return 1;
    }

    char line[1024];
    while (fgets(line, 1024, file) != NULL) {
    Sensor sensor;
    parse_sensor_line(line, &sensor);

    add_sensor_to_list(sensor);
    }

    fclose(file);

    }

    else if(choice==2) {
        int i;
        int nrSensors;
        printf("How many sensors do you want to add?\n");
        scanf("%d", &nrSensors);
        if(nrSensors>0) {
            for(i=0; i<nrSensors; i++) {
                Sensor sensor;
                printf("Sensor %d\n", i+1);
                printf("ID: ");
                scanf("%d", &sensor.id);
                printf("Sensor type: ");
                scanf("%d", &sensor.sensor_type);
                printf("Max limit: ");
                scanf("%d", &sensor.max_limit);
                printf("Min limit: ");
                scanf("%d", &sensor.min_limit);
                printf("Frequency: ");
                scanf("%d", &sensor.frequency);
                sensor.readings_size = 86400 / sensor.frequency;
                sensor.readings = malloc(sensor.readings_size * sizeof(unsigned short));
                //fill readings array here
                add_sensor_to_list(sensor);
            }
        }
        else {
            printf("Invalid number of sensors\n");
        }
    }
    else {
        printf("Invalid choice");
        return 1;
    }
    return 0;
}


