#Name: Kenneth Devon Gaston
#Date: 4/21/17
#Name: Makefile
#Purpose: Makefile for the prim program

#Compiler version
CC = gcc

#Target
TARGET = prim

#Flags
CFLAGS = -c -Wall

all: $(TARGET)

$(TARGET): main.o graph.o
	$(CC) main.o graph.o -o $(TARGET)

main.o: main.c graph.h
	$(CC) $(CFLAGS) main.c graph.h

graph.o: graph.c graph.h
	$(CC) $(CFLAGS) graph.c graph.h

clean:
	rm *.o $(TARGET) *~
