/**
 * @file graph.h
 * @author Kenneth Devon Gaston
 * @date 18 April 2017
 * @brief Header file for graph.c and main.c
 *
 * Contains prototypes for functions that are defined in graph.c and used in
 * main.c
 *
 */

#include <stdbool.h>

#ifndef GRAPH_H
#define GRAPH_H

/**
 * This function solves Prim's Algorithm for the graph stored in the matrix;
 * a set of index keys used to find the minimum values, a set of indexes for
 * the first nodes in each edge, where the node is found in table by the index,
 * and a set of boolean values that are used to ensure no specific location's
 * value is found twice are created. The set of index keys and booleans are 
 * initially filled to a large amount and false respectively, except in the 
 * first position  of the keys index, which is set to a negative value to ensure
 * that it is chosen first.  From there, the minimum value per index location is
 * found,the boolean located at that index set to true,  and then the index for
 * the first node is stored in the corresponding position in the set of node 
 * indexes, and the value in the keys index at that position is changed to the
 * number in the matrix found at the min value's position.  This continues
 * until all lowest values are found, after whcih the MST is printed out.
 * @author Kenneth Devon Gaston
 * @date 04/18/2017
 */
void prim();

/**
  * This function takes a set of stored key values and a set of boolean values,
  * searches for the lowest value whose corresponding in the boolean set is 
  * false, and returns it as the second node in a set, where the value is the
  * index for the node in question.
  * @author Kenneth Devon Gaston
  * @param key The key values in the adjacency matrix to search through.
  * @param visited The set of booleans used to track whether or not a value
  * in key at a specific location has already been used.
  * @date 4/22/2017
  * @returns int
  */
int minValue(int key[], bool visited[]);

/**
  * This function searches through the table and provided set of nodes to
  * print out the MST of the graph, where the index of the first node is stored
  * in the passed in set of values, the second is the current iteration of the
  * loop, and the weight is found by searching in the location in the matrix as
  * specified by the loop's current iteration and the index found in the node 
  * set.
  * @author Kenneth Devon Gaston
  * @param node_1 The indices for the first node in each edge.
  * @date 4/22/2017
  */
void print(int node_1[]);

/**
 * This function takes in a file containing graph information and stores 
 * the vertices into a reference table and the weight of each edge in an
 * adjacency matrix.
 * @author Kenneth Devon Gaston
 * @param file  The file containing the graph data
 * @date 04/18/2017
 * @return void
 */
void readGraph(char* file);

/**
 * This function takes a veretx and stores it in the reference table;
 * no duplicates are allowed in the table.
 * @author Kenneth Devon Gaston
 * @param vertex  The vertex stored into the table
 * @date 04/18/2017
 * @return void
 */
void storeVertices(char vertex[]);

/**
 * This function takes two vertices and a weight, finds the position of the
 * vertices in the reference table, and stores the weight in the position
 * of the adjacency matrix that correpsonds with the positions of the vertices.
 * @author Kenneth Devon Gaston
 * @param vertex_1  The first vertex in the edge whose weight we wish to store.
 * @param vertex_2  The second vertex in the edge whose weight we wish to store.
 * @param weight  The weight of the edge to be stored in the matrix
 * @date 04/18/2017
 * @return void
 */
void storeWeight(char vertex_1[], char vertex_2[], int weight);

/**
  * This function takes a vertex, finds its index in the reference table, and
  * returns that index.
  * @author Kenneth Devon Gaston
  * @param vertex  The vertex whose index we are looking for.
  * @date 04/18/2017
  * @return int
  */
int getVertPosition(char vertex[]);

#endif
