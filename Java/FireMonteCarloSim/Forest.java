/*
 * Lexxi Reddington
 * October 3, 2018
 */
import java.util.Arrays;
import java.util.Stack;
import java.util.Queue;
import java.util.LinkedList;

//0 - empty cell, 1 - tree, 2 - tree on fire

public class Forest {
	private int array[][];
	private int height;
	private int width;

	//Constructor that populates an array with 0s and 1s to represent the forest, with a density d
	public Forest(int h, int w, double d) {
		height = h;
		width = w;
		if(d > 1.0 || d < 0) {
			System.out.print("Error: Invalid denisty");
		}
		array = new int[height][width];
		for (int i = 0; i < height; i++) {
			for (int j = 0; j < width; j++) {
				if(Math.random() < d) {
					array[i][j] = 1;
				} else {
					array[i][j] = 0;
				}
			}
		}
	}

	//toString method that prints out the 'forest' array
	public String toString() {
		String s = "";
		for (int i = 0; i < height; i++) {
			for (int j = 0; j < width; j++) {
				s += array[i][j] + " ";
			}
			s += "\n";
		}
		return s;
	}

	//Get the height of the array
	public int getHeight() {
		return height;
	}

	//Get the width of the array
	public int getWidth() {
		return width;
	}

	//Depth First Search (with Stack)
	public boolean depthFirstSearch() {
		Stack<Position> cellsToExplore = new Stack<Position>();
		Position currentPosition;

		//Set the first row of trees on fire
		for (int j = 0; j < width; j++) {
			if(array[0][j] == 0) {
				array[0][j] = 0;
			} else {
				currentPosition = new Position(0, j);
				cellsToExplore.push(currentPosition);
				array[0][j] = 2;
			}
		}

		//Check the neighbors and set them on fire when appropriate, determine if fire spreads
		while(cellsToExplore.isEmpty() == false) {
			currentPosition = cellsToExplore.pop();
			int currentRow = currentPosition.getRow();
			int currentCol = currentPosition.getCol();
			if(currentRow >= array.length-1) {
				return true; //Indicates the fire spread to the bottom row of the forest
			}

			if(!(currentCol-1 < 0) && array[currentRow][currentCol-1] == 1) {
				Position neighbor1 = new Position(currentRow, currentCol-1);
				array[currentRow][currentCol-1] = 2;
				cellsToExplore.push(neighbor1);
			}

			if(!(currentRow-1 < 0) && array[currentRow-1][currentCol] == 1) {
				Position neighbor2 = new Position(currentRow-1, currentCol);
				array[currentRow-1][currentCol] = 2;
				cellsToExplore.push(neighbor2);
			}

			if(!(currentCol+1 >= array[currentRow].length) && array[currentRow][currentCol+1] == 1) {
				Position neighbor3 = new Position(currentRow, currentCol+1);
				array[currentRow][currentCol+1] = 2;
				cellsToExplore.push(neighbor3);
			}

			if(!(currentRow+1 >= array.length) && array[currentRow+1][currentCol] == 1) {
				Position neighbor4 = new Position(currentRow+1, currentCol);
				array[currentRow+1][currentCol] = 2;
				cellsToExplore.push(neighbor4);
			}
		}
		return false; //Indicates the fire was not able to spread to the bottom row of the forest
	}

	//Breadth First Search (with Queue)
	public boolean breadthFirstSearch() {
		Queue<Position> cellsToExplore = new LinkedList<>();
		Position currentPosition;

		//Set the first row of trees on fire
		for (int j = 0; j < width; j++) {
			if(array[0][j] == 0) {
				array[0][j] = 0;
			} else {
				currentPosition = new Position(0, j);
				cellsToExplore.add(currentPosition);
				array[0][j] = 2;
			}
		}

		//Check the neighbors and set them on fire when appropriate, determine if fire spreads
		while(cellsToExplore.isEmpty() == false) {
			currentPosition = cellsToExplore.remove();
			int currentRow = currentPosition.getRow();
			int currentCol = currentPosition.getCol();
			if(currentRow >= array.length-1) {
				return true; //Indicates the fire spread to the bottom row of the forest
			}

			if(!(currentCol-1 < 0) && array[currentRow][currentCol-1] == 1) {
				Position neighbor1 = new Position(currentRow, currentCol-1);
				array[currentRow][currentCol-1] = 2;
				cellsToExplore.add(neighbor1);
			}

			if(!(currentRow-1 < 0) && array[currentRow-1][currentCol] == 1) {
				Position neighbor2 = new Position(currentRow-1, currentCol);
				array[currentRow-1][currentCol] = 2;
				cellsToExplore.add(neighbor2);
			}

			if(!(currentCol+1 >= array[currentRow].length) && array[currentRow][currentCol+1] == 1) {
				Position neighbor3 = new Position(currentRow, currentCol+1);
				array[currentRow][currentCol+1] = 2;
				cellsToExplore.add(neighbor3);
			}

			if(!(currentRow+1 >= array.length) && array[currentRow+1][currentCol] == 1) {
				Position neighbor4 = new Position(currentRow+1, currentCol);
				array[currentRow+1][currentCol] = 2;
				cellsToExplore.add(neighbor4);
			}
		}
		return false; //Indicates the fire was not able to spread to the bottom row of the forest
	}
}
