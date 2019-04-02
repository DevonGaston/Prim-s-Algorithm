/**
 * @file main.c
 * @author Kenneth Devon Gaston
 * @date 18 April 2017
 * @brief Driver for Prim's Algorithm
 *
 * This program takes in a file containing grah data, invokes the readGraph
 * function in graph.c to store the data into a usable format, then after
 * the MST is found, it is printed out via the printMST function in graph.c
 * and exit with return status 0.
 *
 */

#include <stdio.h>
#include <string.h>
#include "graph.h"

/**
  * This function gives graph data to functions in graph.c so it can be stored 
  * and manipulated in order to find the MST of the given graph.
  * @author Kenneth Devon Gaston
  * @param args  The number of elements passed into the command line
  * @param argv  The array of strings containing the data passed in to the
  * command line (in this case, the name of the file containing the graph).
  * @date 04/18/2017
  * @return int
  */
int main(int args, char *argv[]){
  char *fileName = argv[1];
  readGraph(fileName);
  prim();
  
  return 0;
}
