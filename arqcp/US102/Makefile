main: sens_pluvio.o sens_humd_solo.o sens_humd_atm.o sens_dir_vento.o sens_velc_vento.o sens_temp.o pcg32_random_r.o main.o
	gcc -g -Wall sens_pluvio.o sens_humd_solo.o sens_humd_atm.o sens_dir_vento.o sens_velc_vento.o sens_temp.o pcg32_random_r.o main.o -o main

pcg32_random_r.o: pcg32_random_r.s 
	gcc  -Wall -c pcg32_random_r.s -g -o pcg32_random_r.o
	
sens_temp.o: sens_temp.s 
	gcc  -Wall -c sens_temp.s -g -o sens_temp.o
	
sens_velc_vento.o: sens_velc_vento.s 
	gcc  -Wall -c sens_velc_vento.s -g -o sens_velc_vento.o
	
sens_dir_vento.o: sens_dir_vento.s 
	gcc  -Wall -c sens_dir_vento.s -g -o sens_dir_vento.o
	
sens_humd_atm.o: sens_humd_atm.s 
	gcc  -Wall -c sens_humd_atm.s -g -o sens_humd_atm.o
	
sens_humd_solo.o: sens_humd_solo.s 
	gcc  -Wall -c sens_humd_solo.s -g -o sens_humd_solo.o

sens_pluvio.o: sens_pluvio.s 
	gcc  -Wall -c sens_pluvio.s -g -o sens_pluvio.o
	
main.o: main.c
	gcc -g -Wall -c main.c -o main.o

clean:
	rm -f *.o main
	
debug:
	gdb -tui main
	
run: main
	./main
