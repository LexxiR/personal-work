package project3;
/*
 *
 * Author: Lexxi Reddington
 * File Name: Reddington_Emoji
 * Purpose: Practice using abstract classes and inheritance by creating a hierarchy of Emojis!
 * Date: April 26, 2018
 *
 */
public abstract class Emoji {
	private double posX;
	private double posY;
	private double size;

	public Emoji() {
		posX = 0;
		posY = 0;
		size = 0;
	}

	public Emoji(double posX, double posY, double size) {
		this.posX = posX;
		this.posY = posY;
		this.size = size;
	}

	public double getPosX() {
		return posX;
	}

	public double getPosY() {
		return posY;
	}

	public double getSize() {
		return size;
	}

	abstract void draw();
	abstract void animate();
}
