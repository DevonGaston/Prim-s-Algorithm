/**
 * @file graph.c
 * @author Kenneth Devon Gaston
 * @date 18 April 2017
 * @brief Creates a graph and finds the MST of the graph
 *
 * Contains adjacency matrix representation of the graph, a table 
 * containing the vertices, and all the functionality needed to find the MST
 * in the created graph.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "graph.h"

#define  MAX_VERTS 100
#define MAX_NAME  50

char table[MAX_VERTS][MAX_NAME];
char compare[MAX_NAME*MAX_NAME];
int matrix [MAX_VERTS][MAX_VERTS] = {{0}};
int count = 0;

void prim(){
  int node_1[count];
  int key[count];
  bool visited[count];
  for (int c = 0; c < count; c++){
    key[c] = 99999999;
    visited[c] = false;
  }
  int node_2;
  key[0] = 0;
  node_1[0] = -375;
  for(int i = 0; i < count - 1; i++){
    node_2 = minValue(key, visited);
    visited[node_2] = true;
    for(int j = 0; j < count; j++){
      if(matrix[node_2][j] != 0 && visited[j] == false &&
	 matrix[node_2][j] < key[j]){
	node_1[j] = node_2, key[j] = matrix[node_2][j];
      }
    }
  }
  print(node_1);
}

int minValue(int key[], bool visited[]){
  int min = 99999999, index;
  for(int i = 0; i < count; i++){
    if(visited[i] == false && key[i] < min){
      min = key[i], index = i;
    }
  }
  return index;
}

void print(int node_1[]){
  for(int i = 1; i < count; i++){
    printf("%s -> %s\t%d\n", table[node_1[i]], table[i], matrix[i][node_1[i]]);
  }
}


void readGraph(char* file){
  FILE * fp;
  char vertex_1[50], vertex_2[50], weight[50];
  int weight_num,  r;
  fp = fopen(file, "r");
  if(fp == NULL){
    printf("ERROR: FILE NOT FOUND!\n");
    exit(1);
  }
  while((r = fscanf(fp, "%s %s %s\n", vertex_1, vertex_2, weight)) != EOF){
    storeVertices(vertex_1);
    storeVertices(vertex_2);
    weight_num = atoi(weight);
    storeWeight(vertex_1, vertex_2, weight_num);
    storeWeight(vertex_2, vertex_1, weight_num);
  }
  fclose(fp);
}

void storeVertices(char vertex[]){
  for(int i = 0; i < count; i++){
    if(strcmp(table[i], vertex) == 0){
      return;
    }
  }
      strcpy(table[count], vertex);
      strcat(compare, vertex);
      count++;
}

void storeWeight(char vertex_1[], char vertex_2[], int weight){
  int x = getVertPosition(vertex_1), y = getVertPosition(vertex_2);
  matrix[x][y] = weight;
}


int getVertPosition(char vertex[]){
  for(int i = 0; i < MAX_VERTS; i++){
    if(strcmp(table[i], vertex) == 0){
      return i;
    }
  }
}

