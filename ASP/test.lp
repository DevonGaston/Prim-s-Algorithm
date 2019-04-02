%%%Problem Instance
% Nodes in a graph
node(a). node(b). node(c). node(d). %node(e). node(f). node(g). node(h). node(i).

%Edges connecting the nodes
edge(a, b, 4).
edge(b, c, 5).
edge(c, d, 3).
%edge(c, d, 6).

%Edges are symmetric
edge(X, Y, W) :- edge(Y, X, W).

%*Paths exist such that two nodes can be reached via traveling along connected
edges*%
{path(X, Y, W) : edge(X, Y, W)} :- node(X), node(Y).

%*There is a route to a node such that there's a path to the node from the route
and any other route*%
route(Y) :- path(root, Y, W).
route(Y) :- path(X, Y, W), route(X).

%A route must exist for any node in the graph
:- node(X), not route(X).

%A tree only exists when there is a distinct path from any node to the root
tree(X, Y, W) :- path(X, Y, W), Y!=root.


#minimize{W, X, Y : tree(X, Y, W)}.
#show tree/3.

#show path/2.
