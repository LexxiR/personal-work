/*
 * Lexxi Reddington
 * October 3, 2018
 *
 * We would like to compute the maximum density of trees in a forest, such that a forest fire has a low probability of spreading.
 * This is, of course, a complicated question to answer.
 * We will attempt to find an answer using a Monte Carlo simulation.
 * A Monte Carlo simulation attempts to estimate the answer to a difficult question using randomized data.
 *
 * To answer our question, we will create forests of different densities, and model the spread of forest fires within them.
 * By running many simulations, we can come up with an approximate probability of fire spreading.
 */
public class Driver {

	public static void main(String[] args) {
		//Depth First Search
		long start1 = System.currentTimeMillis();
		System.out.println("Highest density before 50% probability of fire (DFS): " + FireProbability.highestDensityDFS());
		long end1 = System.currentTimeMillis();
		long total1 = end1-start1;
		System.out.println("Total time for DFS: " + total1 + " milliseconds");

		//Breadth First Search
		long start2 = System.currentTimeMillis();
		System.out.println("Highest density before 50% probability of fire (BFS): " + FireProbability.highestDensityBFS());
		long end2 = System.currentTimeMillis();
		long total2 = end2-start2;
		System.out.println("Total time for BFS: " + total2 + " milliseconds");


		/* The BFS method is somewhat slower than the DFS method for this specific application, due to the DFS using a stack and the BFS using a queue.
		 * The BFS has the effect of expanding the neighbors of a cell, then the neighbors of those neighbors, and so on.
		 * The DFS has the effect of expanding one neighbor fully before moving onto the next.
		 * As the console shows, the DFS method has a shorter run time.
		 * For DFS, the last element added to the stack is the first one that is popped and analyzed by the DFS method.
		 * If this element has neighbors that can be set on fire, then these neighbors are added to the stack.
		 * The while loop then continues and the next element on the stack is one of the neighbors that was just added.
		 * This pattern continues until the fire (possibly) reaches the bottom, even before some of the trees in the first row are analyzed.
		 * This occurs more quickly than with a queue in the BFS method.
		 * The BFS method uses a queue with the principle of first in first out. So the first element in the queue is analyzed (this is a tree in the first row of the forest).
		 * The next element to be analyzed is then the next tree in the first row (if applicable).
		 * This means all of the trees in the first row could be analyzed by the BFS method before the neighbors further down the rows are analyzed.
		 * In doing this, it takes longer to reach the bottom row or determine that the fire never spreads to the bottom row because of how the queue checks each tree.
		 * As a result overall, the DFS is slightly faster than the BFS method, meaning the stack performs faster with smaller run-times than the queue in this specific simulation.
		 */
	}
}
