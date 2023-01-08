#include <stdio.h>
void write_matrix_file(short **matrix){
    int rows = 6;
    int cols = 3;
    FILE *fp;
    fp = fopen("matrix.csv", "a");              //create or open file in append mode
    for (int i = 0; i < rows; i++) {            //iterate through rows
        for (int j = 0; j < cols; j++) {        //iterate through columns
            fprintf(fp, "%d", matrix[i][j]);
            if (j < cols-1) {
                fprintf(fp, ",");
            }
        }
        fprintf(fp, "\n");
    }
    fclose(fp);                                 //close file
}