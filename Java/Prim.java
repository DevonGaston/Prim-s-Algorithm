/**
 * Takes in a file, stores it in the Graph class, and then finds and returns 
 * the MST of the graph given to it.
 *
 * @author Kenneth Devon Gaston
 * @since 2017-04-12
 */

import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.lang.ArrayIndexOutOfBoundsException;
import java.util.NoSuchElementException;
import java.util.InputMismatchException;
import java.util.Map;
import java.util.TreeMap;
import java.util.Set;
import java.util.HashSet;
import java.util.Iterator;

public class Prim{
    Graph original = new Graph();
    /**
     * Main driver; takes in the graph from the command line and invokes 
     * functions that print out the graph and it's MST.
     * @param args The command line arguments; the file to be read from.
     */
    public static void main(String[] args){
 	Prim prim = new Prim();
	prim.readGraph(args[0]);
	prim.printGraph();
	prim.printMST();
    }

    /**
     * Reads the graph in the passed in file, stores its information in a graph
     * object, and then prints out that object's data.
     * @param graphFile The file containing the graph to be read in.
     */
    public void readGraph(String graphFile){
	try{
	    Scanner inFile = new Scanner(new File(graphFile));
	    String n1, n2;
	    int w;
	    while(inFile.hasNextLine()){
		n1 = inFile.next();
		n2 = inFile.next();
		w = inFile.nextInt();
		original.addEdge(n1, n2, w);
		original.addEdge(n2, n1, w);
	    }
	    inFile.close();
	}
	catch(ArrayIndexOutOfBoundsException e){
	    System.err.println("ERROR: COULD NOT READ IN GRAPH");
	}
	catch(FileNotFoundException e){
	    System.err.println("ERROR: FILE " + graphFile +
			       " WAS NOT FOUND");
	}
	catch(InputMismatchException e){
	    System.err.println("ERROR: THIRD ELEMENT IN SOME LINE " +
			       "IS NOT AN INTEGER.  LINE SKIPPED.");
	}
	catch(NoSuchElementException e){
	}
    }
    
     /** 
     * Prints out the original graph
     */
    public void printGraph(){
	System.out.println("Graph:");
	original.printGraph();
	System.out.print('\n');
    }

    /**
     * Creates the MST.  It takes the keys inside the graph, goes through
     * all their adjacent edges, and adds the edge if it does not cycle back
     * to a previous edge and is of minimum weight.
     * @returns Graph The created MST
     */
    public Graph makeMST(){
	Graph mst = new Graph();
	String node1 = null, node2 = null, compareS = null;
	Set map = original.graph.keySet();
	Set inMap;
	Map.Entry inTree;
	Set<String> compare = new HashSet<String>();
	Iterator compareIt, inMapIt;
	int weight = 99999999;
	try{
	    compare.add(original.graph.firstKey());
	}
	catch(NoSuchElementException e){
	    System.err.println("ERROR: NO EDGES FOUND!");
	}
	    while(compare.size() != map.size()){
		compareIt = compare.iterator();
		while(compareIt.hasNext()){
		    compareS = (String)compareIt.next();
		    inMap = original.graph.get(compareS).entrySet();
		    inMapIt = inMap.iterator();
		    while(inMapIt.hasNext()){
			inTree = (Map.Entry)inMapIt.next();
			if(compare.contains((String)inTree.getKey()) == false &&
			   (Integer)inTree.getValue() < weight){
			node1 = compareS;
			node2 = (String)inTree.getKey();
			weight = (Integer)inTree.getValue();
			}
		    }
		}
		mst.addEdge(node1, node2, weight);
		original.deleteEdge(node1, node2);
		original.deleteEdge(node2, node1);
		compare.add(node2);
		weight = 99999999;
	    
	    }
	    
	    return mst;
	}


    /** 
     * Invokes the makeMST method and prints the returned MST
     */
    public void printMST(){
	Graph mst = makeMST();
	System.out.println("MST:");
	mst.printGraph();
    }
}

