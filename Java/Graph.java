/**
 * This class takes in data to create edges in a graph structure.  This data
 * consists of two Strings and an integer, which is then stored into a TreeMap
 * where the keys are the first String of the read in edge  and the values
 * are TreeMaps whose keys are the second String of the read in edge and the
 * values are the Integer values in the edge.  This allows each key of the
 * outer tree to contain multiple values consisting of the rest of the data
 * in the read-in edge.
 * 
 *
 * @author Kenneth Devon Gaston
 * @since 2017-04-12
 */

import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.Iterator;
import java.util.TreeMap;

public class Graph{
    TreeMap<String, TreeMap<String, Integer>> graph
	= new TreeMap<String, TreeMap<String, Integer>>();

    /**
     * Adds a new mapping of a String value to the mapping of another String
     * value to an Integer value to represent edges in a graph.
     * @param n1 The first node in the edge.
     * @param n2 The second node in the edge.
     * @param w The weight of the whole edge.
     */
    public void addEdge(String n1, String n2, int w){
	TreeMap<String, Integer> adjacent = graph.get(n1);
	if(adjacent == null){
	    adjacent = new TreeMap<String, Integer>();
	    graph.put(n1, adjacent);
	}
	adjacent.put(n2, w);
    }

    /**
     * Deletes the edge adjacent to the first node that connects with the
     * second node.
     * @param n1 The first String to be compared
     * @param n2 The second String to be compared
     */
    public void deleteEdge(String n1, String n2){
	TreeMap<String, Integer> adjacent = graph.get(n1);
	if(adjacent == null){
	    return;
	}
	adjacent.remove(n2);
    }

    /**
     * Prints out the graph.
     */
    public void printGraph(){
	String node1, node2;
	int weight;
	Map.Entry inTree;
	Set map = graph.keySet();
	Iterator mapit = map.iterator();
	Set inmap;
	Iterator inmapit;
	while(mapit.hasNext()){
	    node1 = (String)mapit.next();
	    inmap = graph.get(node1).entrySet();
	    inmapit = inmap.iterator();
	    while(inmapit.hasNext()){
		inTree = (Map.Entry)inmapit.next();
		node2 = (String)inTree.getKey();
		weight = (Integer)inTree.getValue();
		if(node2.compareTo(node1) > 0){
		    System.out.print(node1 + "->" +  node2 + "      ");
		    System.out.println("Weight: " + weight);
		}
	    }
	}
    }
}

