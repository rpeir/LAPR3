pcg32_random_r.o: ../US101/pcg32_random_r.s
	gcc -Wall -c ../US101/pcg32_random_r.s -g -o pcg32_random_r.o

us102: sens_pluvio.o sens_humd_solo.o sens_humd_atm.o sens_dir_vento.o sens_velc_vento.o sens_temp.o
	
sens_temp.o: ../US102/sens_temp.s 
	gcc  -Wall -c ../US102/sens_temp.s -g -o sens_temp.o
	
sens_velc_vento.o: ../US102/sens_velc_vento.s 
	gcc  -Wall -c ../US102/sens_velc_vento.s -g -o sens_velc_vento.o
	
sens_dir_vento.o: ../US102/sens_dir_vento.s 
	gcc  -Wall -c ../US102/sens_dir_vento.s -g -o sens_dir_vento.o
	
sens_humd_atm.o: ../US102/sens_humd_atm.s 
	gcc  -Wall -c ../US102/sens_humd_atm.s -g -o sens_humd_atm.o
	
sens_humd_solo.o: ../US102/sens_humd_solo.s 
	gcc  -Wall -c ../US102/sens_humd_solo.s -g -o sens_humd_solo.o

sens_pluvio.o: ../US102/sens_pluvio.s 
	gcc  -Wall -c ../US102/sens_pluvio.s -g -o sens_pluvio.o

us104: us102 pcg32_random_r.o checkValueInRange.o createArrayNew.o

checkValueInRange.o: ../US104/checkValueInRange.c
	gcc -Wall -c ../US104/checkValueInRange.c -g -o checkValueInRange.o

createArrayNew.o: ../US104/createArrayNew.c
	gcc -Wall -c ../US104/createArrayNew.c -g -o createArrayNew.o

us103: createMatrix.o dailyValues.o

createMatrix.o: ../US103/createMatrix.c
	gcc -Wall -c ../US103/createMatrix.c -g -o createMatrix.o

dailyValues.o: ../US103/dailyValues.c
	gcc -Wall -c ../US103/dailyValues.c -g -o dailyValues.o

us112: write_matrix_file.o write_sensor_file.o

write_matrix_file.o: ../US112/write_matrix_file.c
	gcc -Wall -c ../US112/write_matrix_file.c -g -o write_matrix_file.o

write_sensor_file.o: ../US112/write_sensor_file.c
	gcc -Wall -c ../US112/write_sensor_file.c -g -o write_sensor_file.o

main: main.o us102 us103 us104 us112 Constants.o
	gcc -g -Wall Constants.o main.o pcg32_random_r.o createMatrix.o dailyValues.o sens_pluvio.o sens_humd_solo.o sens_humd_atm.o sens_dir_vento.o sens_velc_vento.o sens_temp.o checkValueInRange.o createArrayNew.o write_matrix_file.o write_sensor_file.o -o main
	
main.o: main.c
	gcc -g -Wall -c main.c -o main.o

Constants.o: ../Constants.c
	gcc -g -Wall -c ../Constants.c -o Constants.o

run: main
	./main

clean:
	rm -f *.o main

debug: main
	gdb -tui main
