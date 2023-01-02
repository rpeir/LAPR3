prog: write_sensor_file.o main.o
	gcc -g -Wall write_sensor_file.o main.o -o prog

write_sensor_file.o: write_sensor_file.c
	gcc -g -Wall -c write_sensor_file.c -o write_sensor_file.o

main.o: main.c
	gcc -g -Wall -c main.c -o main.o

run: prog
	./prog

clean:
	rm -f *.o prog