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
public abstract class FaceEmoji extends Emoji {
	private boolean wink;

	public FaceEmoji() {
		super();
		wink = false;
	}
	public FaceEmoji(double posX, double posY, double size, boolean wink) {
		super(posX, posY, size);
		this.wink = wink;
	}

	@Override
	public void draw() {
		StdDraw.setPenColor(StdDraw.YELLOW);
		StdDraw.filledCircle(super.getPosX(), super.getPosY(), super.getSize());
		StdDraw.setPenColor();
		StdDraw.filledCircle(super.getPosX()+super.getSize()/3, super.getPosY()+super.getSize()/3, super.getSize()/5); //Right eye
		//Draw a circle for the eye when not winking
		if(wink == false) {
			StdDraw.filledCircle(super.getPosX()-super.getSize()/3, super.getPosY()+super.getSize()/3, super.getSize()/5); //Left eye, open
		}
		//Draw an arc for the eye when winking
		else if(wink == true) {
			StdDraw.arc(super.getPosX()-super.getSize()/3, super.getPosY()+super.getSize()/3, super.getSize()/5, 0, 180); //Left eye, winking
		}
	}

	@Override
	public void animate() {
		if(wink == true) {
			wink = false;
		}
		else if(wink == false) {
			wink = true;
		}
	}
}
