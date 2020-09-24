/*
 * Array Sort and Finding Number Pairs
 * Lexxi Reddington
 */
public class Search {
	//Note: 0 is not counted because it cannot have a negative pair and is not truly a positive number itself
	private static int[] array;

	//Algorithm 1 ~ Linear Search
	public static boolean alg1(int[] arr) {
		array = arr;
		for(int i = 0; i < array.length; i++) {
			for(int j = 0; j < array.length; j++) {
				if((array[j] == (array[i] * -1)) && array[j] != 0) {
					return true;
				}
			}
		}
		return false;
	}

	//Algorithm 2 ~ Binary Search
	public static boolean alg2(int[] arr) {
		array = arr;
		for(int i = 0; i < array.length; i++) {
			int first = 0;
			int last = array.length;
			int x = -1 * array[i];
			while(first < last) {
				int middle = (first + last)/2;
				if(array[middle] == x) {
					return true;
				} else if(x < array[middle]) {
					last = middle;
				} else {
					first = middle + 1;
				}
			}
		}
		return false;
	}

	//Algorithm 3 ~ Search with Indices
	public static boolean alg3(int[] arr) {
		array = arr;
		int indexI = 0;
		int indexJ = array.length - 1;
		while(indexI != indexJ) {
			int i = array[indexI];
			int j = array[indexJ];
			if((i + j) == 0) {
				return true;
			} else if ((i + j) < 0) {
				indexI++;
			} else indexJ--;
		}
		return false;
	}
}
