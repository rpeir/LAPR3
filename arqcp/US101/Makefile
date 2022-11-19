main: pcg32_random_r.o main.o
	gcc -g -Wall pcg32_random_r.o main.o -o main

pcg32_random_r.o: pcg32_random_r.s 
	gcc  -Wall -c pcg32_random_r.s -g -o pcg32_random_r.o

main.o: main.c
	gcc -g -Wall -c main.c -o main.o

clean:
	rm -f *.o main
	
debug:
	gdb -tui main
	
run: main
	./main
