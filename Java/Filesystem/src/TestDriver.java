import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Scanner;

// Lexxi Reddington
// Filesystem Implementation

public class TestDriver {

	public static void main(String[] args) throws FileNotFoundException {
		//Creates a Filesystem object
		//Reads it from a file called "fs.data" using an ObjectInputStream
		Filesystem myFilesystem;
		try {
			FileInputStream fs = new FileInputStream("fs.data");
			ObjectInputStream is = new ObjectInputStream(fs);
			myFilesystem = (Filesystem) is.readObject();
			is.close();
		} catch(Exception ex) {
			myFilesystem = new Filesystem();
		}

		//Creates a scanner and connect it to System.in
		Scanner keyboard = new Scanner(System.in);
		System.out.println("Please enter a command: ");
		String input = keyboard.next();

		//Until the user types quit, listens for the commands and calls the appropriate methods
		while(!(input.toLowerCase().equals("quit"))) {
			switch(input.toLowerCase()) {
			case "cd":
				System.out.println("Please enter the name of the directory you wish to change to: ");
				String dirName = keyboard.next();
				myFilesystem.cd(dirName);
				break;
			case "ls":
				myFilesystem.ls();
				break;
			case "touch":
				System.out.println("Please enter the name of the file you wish to create: ");
				String fileName = keyboard.next();
				myFilesystem.touch(fileName);
				break;
			case "mkdir":
				System.out.println("Please enter the name of the directory you wish to create: ");
				String dirName1 = keyboard.next();
				myFilesystem.mkdir(dirName1);
				break;
			case "pwd":
				myFilesystem.pwd();
				break;
			case "rm":
				System.out.println("Please enter the name of the file you wish to remove: ");
				String fileName1 = keyboard.next();
				myFilesystem.rm(fileName1);
				break;
			case "rmdir":
				System.out.println("Please enter the name of the directory you wish to remove: ");
				String dirName2 = keyboard.next();
				myFilesystem.rmdir(dirName2);
				break;
			case "tree":
				System.out.println(myFilesystem.tree());
				break;
			default:
				System.out.println("Command not recognized. Please re-enter: ");
			}
			System.out.println("Please enter a command: ");
			input = keyboard.next();
		}
		keyboard.close();

		//Saves the filesystem using ObjectOutputStream
		try {
			FileOutputStream fs = new FileOutputStream("fs.data");
			ObjectOutputStream os = new ObjectOutputStream(fs);
			os.writeObject(myFilesystem);
			os.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
