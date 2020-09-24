import java.util.Arrays;
import java.util.Random;
/*
 * Array Sort and Finding Number Pairs
 * Lexxi Reddington
 */
public class Driver {

	public static void main(String[] args) {
		int repeat = 0;
		long start = System.currentTimeMillis(); //Start timer
		while(repeat < 100) {
			int[] arr = new int[400000];
			for(int i = 0; i < arr.length; i++) {
				int randInt = -30 + (int) (Math.random() * ((30 - (-30)) + 1)); //Fills with a range of -30 to 30
				arr[i] = randInt; //Fill array with a random number
			}
			Arrays.sort(arr); //Sort array
			Search.alg3(arr); //Run algorithm
			repeat++; //Repeat for a total of 100 arrays of the same size
		}
		long end = System.currentTimeMillis(); //End timer
		long total = end - start;
		System.out.println(total); //Runtime

		//Code to test the algorithms individually
//		int[] arr = new int[10];
//		for(int i = 0; i < arr.length; i++) {
//			int randInt = -20 + (int) (Math.random() * ((20 - (-20)) + 1));
//			arr[i] = randInt;
//		}
//		Arrays.sort(arr);
//		for(int i = 0; i < arr.length; i++) {
//			System.out.print(arr[i] + " ");
//		}
//		System.out.println(Search.alg3(arr));


		//Big-Oh Function Analysis
		/*
		 * Algorithm 1 ~ O(n) for Linear Time: Algorithm 1 is a linear search that iterates over each element in the array, so as the array size grows, so does the runtime.
		 * This relationship is linear, and so the runtime grows proportionally with the array size.
		 *
		 * Algorithm 2 ~ O(n) for Linear Time: Algorithm 2 is a binary search that divides the list and looks for the negative of each element in the array.
		 * Because each element must be analyzed for its negative, this algorithm is also linear and the runtime grows proportionally to the array size growth.
		 *
		 * Algorithm 3 ~ O(n) for Linear Time: Algorithm 3 is a search with two indices, starting from the front and back of the array and being updated.
		 * This may happen more quickly but, worst case, the algorithm looks at each element in the array - hence the linear time.
		 *
		 * All three of these algorithms are in linear time (closest bound Big-Oh Notation is O(n)).
		 * The Excel tables and graphs corroborate this because they show a linear relationship between runtime and array size.
		 * There is also not a clear method that is consistently faster than the others, they are all approximately the same and vary for different array sizes.
		 *
		 */
	}
}
