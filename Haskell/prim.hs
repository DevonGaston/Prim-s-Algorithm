{- |
Module      :  prim.hs
Description :  Runs Prim's Algorithim on a graph
Copyright   :  N/A
License     :  N/A
      
Maintainer  :  kendgast@ut.utm.edu
Stability   :  stable
Portability :  portable
      
This module takes a graph of edges represented by a list of 3-tuples, where
the first and second are character vertices and the third is a numerical weight.
From there, the minimumally weighted edge of subgraphs created by filtering out
only edges with certain elements as nodes in a tuple where no two can exist in
the same edge are recursively found and added to another subgraph  until there
are no more edges that can be used, effectively creating the minimum spanning
tree.

You can see this function work by simply loading it into ghci and typing
prim graph, where graph is the predefined list of 3-tuples.  You may also
use the function on any graph you want, provided you follow the format that it
accepts.  To see the weight of the graph, you simply use the weight function
by declaring the following: weight graph, where graph is a list of 3-tuples in
the above described format. To see the weight of the MST of a graph,
calling wegiht $ prim graph will suffice.
-}
import Data.List (nub,sort)

graph = [('a','b',4),('a','h',10),('b','c',8),('b','h',11),('c','i',2),('c','d',7),('c','f',4),('d','f',14),('d','e',9),('e','f',10),('f','g',2),('g','i',6),('g','h',1),('i','h',7)]
-- ^graph to be used in test cases

prim :: (Ord a, Ord t2) => [(a, a, t2)] -> [(a, a, t2)]
-- ^Returns the MST of a connected graph
prim graph = sort $ prim' graph ([head $ sortedNodes graph]) []

prim' :: (Ord a, Ord t) => [(t, t, a)] -> [t] -> [(t, t, a)] -> [(t, t, a)]
-- ^Helper function for prim: creates subgraphs only containing edges with the nodes found in a comparison list, but not both in the same edge, and adds the minimum weighted edge from those subgraphs to the mst graph until no more edges can be added
prim' edges nodes mst
  |null (remainingEdges edges nodes) == False = prim' edges (nub nodes++addedNodes) (foundEdge:mst)
  |otherwise = mst
  where foundEdge = minWeight $ remainingEdges edges nodes
        addedNodes = sortedNodes [foundEdge]

remainingEdges :: Eq t => [(t, t, t1)] -> [t] -> [(t, t, t1)]
-- ^Returns a list of all unvisited edges in a graph
remainingEdges [] _ = []
remainingEdges _ [] = []
remainingEdges xs nodes = [(a,b,c) | (a,b,c) <- xs, edgeUnvisited (a,b,c) nodes == True]

edgeUnvisited :: Eq a => (a, a, t2) -> [a] -> Bool
-- ^Determines whether a particular edge has been visited or not
edgeUnvisited _ [] = True
edgeUnvisited (x,y,z) nodes = (getFirstNode(x,y,z) `elem` nodes) `xor` (getSecondNode(x,y,z) `elem` nodes)

sortedNodes :: Ord a => [(a, a, t2)] -> [a]
-- ^Sorts the filtered list of nodes in lexicographic order
sortedNodes nodes = sort $ filteredNodes nodes

filteredNodes :: Eq a => [(a, a, t2)] -> [a]
-- ^Creates a list of non-repeating nodes from the graph provided
filteredNodes [] = []
filteredNodes [(x,y,z)] = nub $ nodes[(x,y,z)]
filteredNodes xyzs = nub $ nodes xyzs

nodes :: [(a,a,t2)] -> [a]
-- ^Creates a list of all nodes in the graph
nodes [] = []
nodes [(x,y,z)] = getFirstNode(x,y,z):[getSecondNode(x,y,z)]
nodes xyzs = ([getFirstNode d | d <- xyzs]) ++ ([getSecondNode d| d <- xyzs])

minWeight :: Ord a => [(t, t1, a)] -> (t, t1, a)
-- ^Returns the node with the lowest weight in the graph
minWeight (x:xs) = minWeight' x xs

minWeight' :: Ord a => (t, t1, a) -> [(t, t1, a)] -> (t, t1, a)
-- ^Helper function for minWeight; compares inital smallest value found (i.e., the first) and compares with all others in graph, replacing the current smallest if it's value is lesser
minWeight' smallest [] = smallest
minWeight' smallest (x:xs)
  |getWeight x < getWeight smallest =  minWeight' x xs
  |otherwise =  minWeight' smallest xs

weight :: Num a => [(t, t1, a)] -> a
-- ^Gets the total weight of the graph
weight [] = 0;
weight [(x,y,z)] = getWeight (x,y,z);
weight xyzs = sum $ weightList xyzs

weightList :: [(t1, t2, t)] -> [t]
-- ^Creates list of all weights in the graph
weightList [] = []
weightList [(x,y,z)] = [getWeight(x,y,z)]
weightList xyzs = [getWeight d| d <- xyzs] 

getWeight :: (t, t1, t2) -> t2
-- ^Returns the weight (i.e., third element) of an edge
getWeight (_,_,a) = a;

getFirstNode :: (t, t1, t2) -> t
-- ^Returns the first node (i.e., first element) of an edge
getFirstNode (a,_,_) = a;

getSecondNode :: (t1, t, t2) -> t
-- ^Returns the second node (i.e., second element) of an edge
getSecondNode (_,a,_) = a;

xor :: Bool -> Bool -> Bool
-- ^Determines the xor relation between two data members
xor p q = (p || q) && not (p && q)
