#include <stdio.h>
void write_matrix_file(short **matrix){
    int rows = 6;
    int cols = 3;
    FILE *fp;
    fp = fopen("matrix.csv", "w");              //create or open file in write mode
    fprintf(fp,"SensorType,Max,Min,Media");
    char sens_names[] = {'T', 'V', 'D', 'H', 'S', 'P'};
    for (int i = 0; i < rows; i++) {            //iterate through rows
        fprintf(fp, "\n");
        fprintf(fp, "%c,", sens_names[i]);
        for (int j = 0; j < cols; j++) {        //iterate through columns
            fprintf(fp, "%d", matrix[i][j]);
            if (j < cols-1) {
                fprintf(fp, ",");
            }
        }
    }
    fclose(fp);                                 //close file
}