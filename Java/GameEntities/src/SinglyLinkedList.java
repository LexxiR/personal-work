
public class SinglyLinkedList<T> {

	//Standard node class, shortened for singly linked list class
	public class Node<T> {
		private T myData;
		private Node<T> myNext;

		public Node(T data, Node<T> next) {
			myData = data;
			myNext = next;
		}
		public T getData() {
			return myData;
		}
		public Node<T> getNextLink() {
			return myNext;
		}
		public void setNextLink( Node<T> theNode ) {
			this.myNext = theNode;
		}
	}

	//Instance variables for singly linked list
	private int size;
	private Node<T> head;

	//Constructor
	public SinglyLinkedList() {
		size = 0;
		head = null;
	}

	//Methods done in class with Jeff
	public void addToFront(T theData) {
		Node<T> tempNode = head;
		head = new Node<T>(theData, tempNode);	
		size++;
	}

	public void addLast(T theData) {
		if(isEmpty()) {
			addToFront(theData);
		} else {
			Node<T> tempNode = head;
			while (tempNode.getNextLink() != null) {
				tempNode = tempNode.getNextLink();
			}
			Node<T> newNode = new Node<T>(theData, null);
			tempNode.setNextLink(newNode);
			size++;
		}	
	}

	public boolean isEmpty() {
		return size == 0;
	}

	//Updated toString method
	public String toString() {
		Node<T> tempNode = head;
		String theResult = "The list: ";
		while(tempNode != null) {
			theResult = theResult + tempNode.getData().toString() + " ";
			tempNode = tempNode.getNextLink();
		}
		return theResult;
	}

	//NEW remove method
	public boolean remove(T element) {
		Node<T> tempNode = head;
		Node<T> prevNode = head;
		if(head == null) {
			return false;
		}
		else if(head.getData().equals(element)) {
			head = head.getNextLink();
			size--;
			return true;
		}
		else {
			while(!tempNode.getData().equals(element)) {
				prevNode = tempNode;
				tempNode = tempNode.getNextLink();
				if(tempNode == null) {
					System.out.println("Error: Element not found in list");
					return false;
				}
			}
			prevNode.setNextLink(tempNode.getNextLink());
			size--;
			return true;
		}	
	}
}