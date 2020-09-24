package project3;

import edu.princeton.cs.introcs.StdDraw;
/*
 *
 * Author: Lexxi Reddington
 * File Name: Reddington_Emoji
 * Purpose: Practice using abstract classes and inheritance by creating a hierarchy of Emojis!
 * Date: April 26, 2018
 *
 */
public class FrowningFaceEmoji extends FaceEmoji {

	public FrowningFaceEmoji() {
		super();
	}

	public FrowningFaceEmoji(double posX, double posY, double size, boolean wink) {
		super(posX, posY, size, wink);
	}

	@Override
	public void draw() {
		super.draw();
		//Draw the frown
		StdDraw.arc(super.getPosX(), super.getPosY()-(super.getSize()*0.25), super.getSize()/2.5, 0, 180);
	}
}
