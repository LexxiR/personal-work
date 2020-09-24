/*
 * Lexxi Reddington
 * October 3, 2018
 */
public class Position {
	private int row;
	private int col;

	//Position class with a constructor to record the row and column of a position object
	public Position(int r, int c) {
		row = r;
		col = c;
	}

	//Method to get the row of a position
	public int getRow() {
		return row;
	}

	//Method to get the column of a position
	public int getCol() {
		return col;
	}
}
