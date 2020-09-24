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
public class ClockEmoji extends Emoji {
	private double hour;
	private double minute;

	public ClockEmoji() {
		super();
		hour = 0;
		minute = 0;
	}

	public ClockEmoji(double posX, double posY, double size, int hour, int minute) {
		super(posX, posY, size);
		this.hour = hour;
		this.minute = minute;
	}

	@Override
	public void draw() {
		StdDraw.setPenColor(StdDraw.ORANGE);
		StdDraw.filledCircle(super.getPosX(), super.getPosY(), super.getSize());
		StdDraw.setPenColor(StdDraw.RED);
		//Minute hand
		double angleM = (minute/60)*2*Math.PI;
		StdDraw.line(super.getPosX(), super.getPosY(), super.getPosX() + super.getSize()*Math.sin(angleM)*0.9, super.getPosY() + super.getSize()*Math.cos(angleM)*0.9);
		//Hour hand
		double angleH = (hour/12)*2*Math.PI;
		StdDraw.line(super.getPosX(), super.getPosY(), super.getPosX() + super.getSize()*Math.sin(angleH)*0.6, super.getPosY() + super.getSize()*Math.cos(angleH)*0.6);
	}

	@Override
	public void animate() {
		//For the 12 hour clock
		++minute;
		if(minute == 60) {
			++hour;
			minute = 0;
		}
		if(hour == 12) {
			hour = 0;
		}
	}
}
