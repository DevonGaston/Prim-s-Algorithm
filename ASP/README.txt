Name: Kenneth Devon Gaston
File Name: README.txt
Purpose: Instructions on how to use prim.lp

This program can be used to find the Minimum Spanning Tree (MST) of any
graph that has an MST.  To have an MST, a graph must:

1. Have at least 2 nodes connected by an edge.
2. Any edge must have some weighted value associated with it.
3. Every node must have at least one edge connected to some other node.
4. No reflexive edges can be in the graph (i.e., no node can have an edge
that leads back to itself).
5. No two nodes can have more than one edge connecting them.

To test this program, you must first have clingo installed on your machine
for use.  Then, it's simply a matter of running the program with the following
command: ./clingo prim.lp -c root=node, where node is the starting node in
the graph.  In this case, so long as the node exists in the program file
and is connected by at least one edge, the actual starting node is irrelevant;
the solution will be the same when starting with any other edge in the program.

To see the possible nodes to start with, open prim.lp in emacs.  Any element
denoted node(X), where X is some arbitrary name for the node,
is a candidate for a starting node.  If you wish to modify the node names,
number of nodes, or the entire graph as a whole, simply change the node names,
add nodes in the following format: node(name).* 
and modify/add/remove any edges you see fit, provided they follow the above
rules and are written as follows: edge(X, Y, W).* , where X and Y are the
connected edges and W is a number representing the weight (think of it as
the distance between the two connected nodes, if it helps).

*Note: When declaring nodes and edges, a period must be put after the closing
parentheses, otherwise the program will not work.
