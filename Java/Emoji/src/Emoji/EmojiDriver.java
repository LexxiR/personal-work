package project3;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Scanner;

import edu.princeton.cs.introcs.StdDraw;
/*
 *
 * Author: Lexxi Reddington
 * File Name: Reddington_Emoji
 * Purpose: Practice using abstract classes and inheritance by creating a hierarchy of Emojis!
 * Date: April 26, 2018
 *
 */
public class EmojiDriver {

	public static void main(String[] args) {
		int numRows;
		int numCols;
		Emoji[][] array;

		Scanner data = null;

		try {
			data = new Scanner(new FileInputStream("emoji1.txt"));
		} catch(FileNotFoundException e) {
			System.out.println("File not found");
			System.exit(0);
		}

		numRows = data.nextInt();
		numCols = data.nextInt();

		array = new Emoji[numRows][numCols];

		//Each emoji is 100x100 pixels
		//Scale is 4 rows x 5 columns
		StdDraw.setCanvasSize(100*numCols, 100*numRows);
		StdDraw.setXscale(-0.5, numCols-0.5);
		StdDraw.setYscale(-0.5, numRows-0.5);

		StdDraw.setPenRadius(0.01);

		//Fill the array of emojis from the file
		for(int i=0; i < numRows; ++i) {
			for(int j=0; j < numCols; ++j) {
				String s = data.next();
				if(s.equals("clock")) {
					array[i][j] = new ClockEmoji(j, numRows-1-i, 0.5, data.nextInt(), data.nextInt());
				}
				else if(s.equals("smile")) {
					array[i][j] = new SmileyFaceEmoji(j, numRows-1-i, 0.5, true);
				}
				else if(s.equals("frown")) {
					array[i][j] = new FrowningFaceEmoji(j, numRows-1-i, 0.5, true);
				}
			}
		}

		StdDraw.enableDoubleBuffering();

		//Draw and animate the emojis
		while(true) {
			for(int i=0; i < numRows; ++i) {
				for(int j=0; j < numCols; ++j) {
					array[i][j].draw();
				}
			}
			for(int i=0; i < numRows; ++i) {
				for(int j=0; j < numCols; ++j) {
					array[i][j].animate();
				}
			}
			StdDraw.show();
			StdDraw.pause(1000);
			StdDraw.clear();
		}
	}
}
