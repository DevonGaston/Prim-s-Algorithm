%* |
Module      :  prim.lp
Description :  Runs Prim's Algorithim on a graph
Copyright   :  N/A
License     :  N/A
      
Maintainer  :  kendgast@ut.utm.edu
Stability   :  stable
Portability :  portable
      
This module takes predefined facts about nodes, applies these nodes to edges
with a weight, and further applies these to a tree predicate that is
restricted to only find all edges can be used to reach one another in order
to find the Minimum Spanning Tree (MST).

Starting at a start variable (provided by the user using the flag
-c root=nodename at execution), the program will find all reachable nodes and
connect them all to at least one other node; so long as the start node chosen
is a defined node, the choice of start node is irrelevant.  From there, the
interpreter will minimize the tree to find the tree with the lowest total
weight, which will be our MST.

This program does not accept any input outside of the start varaible and will
only be able to solve the graph provided in the file; you may test other graphs
by adding/removing/renaming nodes and edges in the format below and altering
the edges by either changing their connections (the two nodes at the start)
or their respective weights (the number at the end).  The graph cannot have any
reflexive edges (i.e., the same node in each of the first two parts of the
tuple), otherwise there will be no MST to find.  Also does not work completely
with negative numbers.
*%

%%%Problem Instance
% Nodes in a graph
node(a). node(b). node(c). node(d). node(e). node(f). node(g). node(h). node(i).

%Edges connecting the nodes
edge(a, h, 10).
edge(a, b, 4).
edge(b, h, 11).
edge(b, c, 8).
edge(c, d, 7).
edge(c, f, 4).
edge(c, i, 2).
edge(d, f, 14).
edge(d, e, 9).
edge(e, f, 10).
edge(f, g, 2).
edge(g, i, 6).
edge(g, h, 1).
edge(h, i, 7).

%%%Problem Encoding

%Edges are symmetric
edge(X, Y, W) :- edge(Y, X, W).

%*Paths exist such that two nodes can be reached via traveling along connected
edges*%
{path(X, Y, W) : edge(X, Y, W)} :- node(X), node(Y).

%*There is a route to a node such that there's a path to the node from the root
and any other route*%
route(Y) :- path(root, Y, W).
route(Y) :- path(X, Y, W), route(X).

%A route must exist for any node in the graph
:- node(X), not route(X).

%A tree only exists when there is a distinct path from any node to the root
tree(X, Y, W) :- path(X, Y, W), Y!=root.


#minimize{W, X, Y : tree(X, Y, W)}.
#show tree/3.