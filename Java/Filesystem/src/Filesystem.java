import java.io.Serializable;
import java.util.ArrayList;
import java.util.Stack;

// Lexxi Reddington
// Filesystem Implementation

public class Filesystem implements Serializable {

	private class Node implements Serializable {
		private String name;
		//By design, each directory can hold 100 children (files or other directories)
		private ArrayList<Node> childNodes = new ArrayList<Node>(100);
		private Node parent;
		private boolean isDirectory;

		//Constructor for private Node class
		private Node(String name, Node parent, Boolean isDirectory) {
			this.name = name;
			this.parent = parent;
			this.isDirectory = isDirectory;
			if(isDirectory == false) {
				this.childNodes = null;
			}
		}

		//Checks if the child is a directory (true) or a file (false)
		private boolean isDirectory() {
			return isDirectory;
		}

		//Returns a list of all of the children for said directory
		private ArrayList<Node> getChildren() {
			return childNodes;
		}

		//Adds a child (file or directory) to the current directory
		private void addChild(String name, boolean isDirectory) {
			//add a new child to this node
			Node newChild = new Node(name, currentDirectory, isDirectory);
			//Append the specified element to the end of this list.
			childNodes.add(newChild);
		}

		//Returns true if the node is the root (it's parent is null)
		private boolean isRoot() {
			if(parent == null) {
				return true;
			}
			return false;
		}

		//Additional helper method
		private String getName() {
			return name;
		}

		//Additional helper method
		private Node getParent() {
			return parent;
		}
	}

	//Start of Filesystem class
	private Node root;
	private Node currentDirectory;

	//Constructor - Makes a root node with the name "" and sets the current directory to root
	public Filesystem() {
		root = new Node("", null, true); //NOTE: The name of root is an empty string, per the assignment instructions
		currentDirectory = root;
	}

	//Returns false if the current directory has a child with name already, otherwise returns true
	public boolean canCreateFile(String name) {
		for(Node n: currentDirectory.getChildren()) {
			if(n.getName().equals(name)) {
				return false;
			}
		}
		return true;
	}

	//Shows all the children of the current directory in the output console
	public void ls() {
		for(Node n: currentDirectory.getChildren()) {
			if(n != null) {
				System.out.println(n.getName());
			}
		}
	}

	//Adds a new directory child node to the current directory if it does not already exist
	//Writes an error to the output console if the name already exists in the current directory
	public void mkdir(String name) {
		int counter = 0;
		if(currentDirectory.getChildren() == null) {
			currentDirectory.addChild(name, true);
		} else {
			for(Node n: currentDirectory.getChildren()) {
				//Checks for name of node and if it's a directory
				if(n.getName().equals(name) && n.isDirectory == true) {
					System.out.println("Error: The directory name, " + name + ", already exists.");
					counter = 1;
				}
			} if(counter == 0) {
				currentDirectory.addChild(name, true);
			}
		}
	}

	//Similar to mkdir but makes a new file (rather than a directory)
	public void touch(String name) {
		int counter = 0;
		if(currentDirectory.getChildren() == null) {
			currentDirectory.addChild(name, false);
		} else {
			for(Node n: currentDirectory.getChildren()) {
				//Checks for name of node and if it's a file
				if(n.getName().equals(name) && n.isDirectory == false) {
					System.out.println("Error: The file name, " + name + ", already exists.");
					counter = 1;
				}
			} if(counter == 0) {
				currentDirectory.addChild(name, false);
			}
		}
	}

	//Prints the full path name of the current directory starting with the root
	public void pwd() {
		Stack myStack = new Stack();
		Node temp = currentDirectory;
		myStack.push(currentDirectory.getName());
		while(temp.getParent() != null) {
			temp = temp.getParent();
			myStack.push(temp.getName());
		}
		myStack.push(root.getName());
		StringBuilder sb = new StringBuilder();
		while(myStack.size() != 0) {
			sb.append(myStack.pop());
			sb.append("/");
		}
		System.out.println(sb.toString());
	}

	//Changes the currentDirectory to name
	public void cd(String dirName) {
		if(dirName.equals("..")) {
			if(currentDirectory.getParent() != null) {
				currentDirectory = currentDirectory.getParent();
				System.out.println("The current directory is now " + currentDirectory.getName());
			} else {
				System.out.println("Error: There is no parent directory. The current directory is the root.");
			}
		} else {
			int counter = 0;
			if(currentDirectory.getChildren() == null) {
				System.out.println("Error: The directory with the name, " + dirName + ", could not be found.");
			} else  {
				for(Node n: currentDirectory.getChildren()) {
					if(n.getName().equals(dirName) && n.isDirectory()) {
						currentDirectory = n;
						counter = 1;
						System.out.println("The current directory is now " + dirName);
					}
				}
				if(counter == 0) {
					System.out.println("Error: The directory with the name, " + dirName + ", could not be found.");
				}
			}
		}
	}

	//Removes the file "name" from the currentDirectory
	//Writes a message to the output console if name is a directory or does not exist
	public void rm(String name) {
		Node nodeToRemove = null;
		for(Node n: currentDirectory.getChildren()) {
			if(n.getName().equals(name)) {
				if(n.isDirectory() == false) {
					nodeToRemove = n;
				} else {
					System.out.println("Error: " + name + " is a directory.");
				}
			}
		}
		if(nodeToRemove != null) {
			currentDirectory.getChildren().remove(nodeToRemove);
			System.out.println("The file, " + name + ", was removed.");
		} else {
			System.out.println("Error: The file with the name, " + name + ", does not exist.");
		}
	}

	//Removes the directory "name" from the currentDirectory
	//Writes a message to the output console if name is not a directory, or if it is not empty
	public void rmdir(String name) {
		int counter = 0;
		Node nodeToRemove = null;
		for(Node n: currentDirectory.getChildren()) {
			if(n.getName().equals(name)) {
				if(n.isDirectory() == true) {
					nodeToRemove = n;
				} else {
					System.out.println("Error: " + name + " is a file.");
				}
			}
		}
		if(nodeToRemove != null) {
			for(Node n: nodeToRemove.getChildren()) {
				if(n != null) {
					counter += 1;
				}
			}
			if(counter == 0) {
				currentDirectory.getChildren().remove(nodeToRemove);
				System.out.println("The directory, " + name + ", was removed.");
			} else {
				System.out.println("Error: The directory, " + name + ", cannot be removed because it is not empty.");
			}
		} else {
			System.out.println("Error: The directory with the name, " + name + ", does not exist.");
		}
	}

	//Pretty prints the tree rooted at currentDirectory
	public String tree() {
		StringBuilder sb = new StringBuilder();
		treeHelper(currentDirectory, sb, 0);
		return sb.toString();
	}

	//Helper function
	private void treeHelper(Node myNode, StringBuilder sb, int numSpaces) {
		if(myNode != null) {
			for(int i = 0; i < numSpaces; i++) {
				sb.append(" ");
			}
			sb.append(myNode.getName() + "\n");
			if(myNode.getChildren() != null) {
				for(Node n: myNode.getChildren()) {
					if(n != null) {
						treeHelper(n, sb, numSpaces+3);
					}
				}
			}
		}
	}
}
