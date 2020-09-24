/*
 * Lexxi Reddington
 * October 3, 2018
 */
public class FireProbability {

	//Determines the probability that the fire will spread to the bottom of the forest with a density of d, using Depth First Search method
	public static double probabilityOfFireSpreadDFS(double d) {
		double fireSpreadCount = 0;
		int repeat = 0;
		while(repeat <= 10000) {
			Forest f = new Forest(20, 20, d);
			if(f.depthFirstSearch() == true) {
				fireSpreadCount++;
			}
			repeat++;
		}
		return (fireSpreadCount / 10000);
	}

	//Determines the probability that the fire will spread to the bottom of the forest with a density of d, using Breadth First Search method
	public static double probabilityOfFireSpreadBFS(double d) {
		double fireSpreadCount = 0;
		int repeat = 0;
		while(repeat <= 10000) {
			Forest f = new Forest(20, 20, d);
			if(f.breadthFirstSearch() == true) {
				fireSpreadCount++;
			}
			repeat++;
		}
		return (fireSpreadCount / 10000);
	}

	//Gives the density of a forest who's fire spreads half of the time, using Depth First Search method
	public static double highestDensityDFS() {
		double lowDensity = 0.0;
		double highDensity = 1.0;
		int repeat = 0;
		double density = 0;

		while(repeat <= 20) {
			density = (highDensity + lowDensity) / 2.0;
			double p = probabilityOfFireSpreadDFS(density);

			if(p < 0.5) {
				lowDensity = density;
			}
			else {
				highDensity = density;
			}
			repeat++;
		}
		return density;
	}

	//Gives the density of a forest who's fire spreads half of the time, using Breadth First Search method
	public static double highestDensityBFS() {
		double lowDensity = 0.0;
		double highDensity = 1.0;
		int repeat = 0;
		double density = 0;

		while(repeat <= 20) {
			density = (highDensity + lowDensity) / 2.0;
			double p = probabilityOfFireSpreadBFS(density);

			if(p < 0.5) {
				lowDensity = density;
			}
			else {
				highDensity = density;
			}
			repeat++;
		}
		return density;
	}
}
