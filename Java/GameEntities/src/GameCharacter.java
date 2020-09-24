
public class GameCharacter {
	
	//Only one instance variable for this class
	private String name;

	//Constructor
	public GameCharacter(String n) {
		name = n;
	}

	//toString method
	@Override
	public String toString() {
		return name;
	}

	//New/Overridden equals method
	@Override
	public boolean equals(Object other) {
		if(other == null)
		{
			return false;
		}
		if(this.getClass() != other.getClass())
		{
			return false;
		}
		if(!this.name.equals(((GameCharacter)other).name))
		{
			return false;
		}
		return true;
	}
}
