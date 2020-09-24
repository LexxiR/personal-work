
public class Driver {

	// Lexxi Reddington
	// Methods to remove a particular element from both the singly and doubly linked list classes

	public static void main(String[] args) {
		//These are the available game characters
		GameCharacter a = new GameCharacter("ape");
		GameCharacter b = new GameCharacter("bear");
		GameCharacter c = new GameCharacter("cat");
		GameCharacter d = new GameCharacter("dog");
		GameCharacter e = new GameCharacter("elephant");
		GameCharacter f = new GameCharacter("frog");
		GameCharacter g = new GameCharacter("goat");
		GameCharacter h = new GameCharacter("hippo");
		GameCharacter i = new GameCharacter("iguana");
		GameCharacter j = new GameCharacter("jaguar"); //Element is not added to any list

		//This is the singly linked list
		SinglyLinkedList<GameCharacter> sList = new SinglyLinkedList<GameCharacter>();
		sList.addToFront(a);
		sList.addToFront(b);
		sList.addToFront(c);
		sList.addToFront(d);
		sList.addToFront(e);
		sList.addToFront(f);
		sList.addToFront(c); //Repeat element
		sList.addToFront(g);
		sList.addToFront(h);
		sList.addToFront(c); //Repeat element
		sList.addToFront(i);

		//Test cases for the singly linked list
		System.out.println("Singly Linked List Test Cases");
		System.out.println(sList); //Initial list
		sList.remove(i); //Should remove "iguana" from beginning of list
		System.out.println(sList);

		sList.remove(a); //Should remove "ape" from end of list
		System.out.println(sList);

		sList.remove(f); //Should remove "frog" from middle of list
		System.out.println(sList);

		sList.remove(c); //Should remove the FIRST instance of "cat" only
		System.out.println(sList);

		sList.remove(j); //Attempts to remove an element that is not in the list
		System.out.println(sList);

		//Removes remaining elements until the list contains only one element
		sList.remove(b);
		sList.remove(c);
		sList.remove(d);
		sList.remove(e);
		sList.remove(c);
		sList.remove(g);
		System.out.println(sList);

		sList.remove(c); //Attempts to remove an element that is not in the list
		System.out.println(sList);

		sList.remove(h); //Removes the only element in this single-element list
		System.out.println(sList); //The list is now empty

		//When you try to remove an element from the empty list, nothing happens
		sList.remove(a);
		System.out.println(sList); //The list is still empty


		//This is the doubly linked list
		DoublyLinkedList<GameCharacter> dList = new DoublyLinkedList<GameCharacter>();
		dList.addFirst(a);
		dList.addFirst(b);
		dList.addFirst(c);
		dList.addFirst(d);
		dList.addFirst(e);
		dList.addFirst(f);
		dList.addFirst(c); //Repeat element
		dList.addFirst(g);
		dList.addFirst(h);
		dList.addFirst(c); //Repeat element
		dList.addFirst(i);

		//Test cases for the doubly linked list
		System.out.println("Doubly Linked List Test Cases");
		System.out.println(dList); //Initial list
		dList.remove(i); //Should remove "iguana" from beginning of list
		System.out.println(dList);

		dList.remove(a); //Should remove "ape" from end of list
		System.out.println(dList);

		dList.remove(f); //Should remove "frog" from middle of list
		System.out.println(dList);

		dList.remove(c); //Should remove the FIRST instance of "cat" only
		System.out.println(dList);

		dList.remove(j); //Attempts to remove an element that is not in the list
		System.out.println(dList);

		//Removes remaining elements until the list contains only one element
		dList.remove(b);
		dList.remove(c);
		dList.remove(d);
		dList.remove(e);
		dList.remove(c);
		dList.remove(g);
		System.out.println(dList);

		dList.remove(c); //Attempts to remove an element that is not in the list
		System.out.println(dList);

		dList.remove(h); //Removes the only element in this single-element list
		System.out.println(dList); //The list is now empty

		//When you try to remove an element from the empty list, nothing happens
		dList.remove(a);
		System.out.println(dList); //The list is still empty
	}
}
