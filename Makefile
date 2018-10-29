
CC=gcc
CFLAGS=-c

all: Compare-Gaussian-Cube Gaussian-Cube-to-Bin Compare-Gaussian-Cube-Bin MakeMap-Gaussian-Cube-Bin

Compare-Gaussian-Cube: src/tracer/Compare-Gaussian-Cube.c
	$(CC) $(CFLAGS) src/tracer/Compare-Gaussian-Cube.c -o bin/Compare-Gaussian-Cube
	chmod a+x bin/Compare-Gaussian-Cube

Gaussian-Cube-to-Bin: src/tracer/Gaussian-Cube-to-Bin.c
	$(CC) $(CFLAGS) src/tracer/Gaussian-Cube-to-Bin.c -o bin/Gaussian-Cube-to-Bin
	chmod a+x bin/Gaussian-Cube-to-Bin

Compare-Gaussian-Cube-Bin: src/tracer/Compare-Gaussian-Cube-Bin.c
	$(CC) $(CFLAGS) src/tracer/Compare-Gaussian-Cube-Bin.c -o bin/Compare-Gaussian-Cube-Bin
	chmod a+x bin/Compare-Gaussian-Cube-Bin

MakeMap-Gaussian-Cube-Bin: src/tracer/MakeMap-Gaussian-Cube-Bin.c
	$(CC) $(CFLAGS) src/tracer/MakeMap-Gaussian-Cube-Bin.c -o bin/MakeMap-Gaussian-Cube-Bin
	chmod a+x bin/MakeMap-Gaussian-Cube-Bin

clean:
	rm bin/Compare-Gaussian-Cube bin/Gaussian-Cube-to-Bin bin/Compare-Gaussian-Cube-Bin bin/MakeMap-Gaussian-Cube-Bin
