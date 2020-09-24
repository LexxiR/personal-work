
public class DoublyLinkedList<T> {

	//Standard node class
	public class Node<T> {
		private T myData;
		private Node<T> myNext;
		private Node<T> myPrev;

		public Node(T data, Node<T> next, Node<T> prev ) {
			myData = data;
			myNext = next;
			myPrev = prev;
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
		public Node<T> getPrevLink() {
			return myPrev;
		}
		public void setPrevLink( Node<T> theNode ) {
			this.myPrev = theNode;
		}
	}

	//Instance variables for doubly linked list
	private int size;
	private Node<T> head;
	private Node<T> tail;

	//Constructor
	public DoublyLinkedList() {
		size = 0;
		head = new Node<T>(null, null, null);
		tail = new Node<T>(null, null, head);
		head.setNextLink(tail);
	}

	//Methods done in class with Jeff
	public int size() {
		return size;
	}

	public boolean isEmpty() {
		return size == 0;
	}

	public T first() {
		return head.getNextLink().getData();
	}

	public T last() {
		return tail.getPrevLink().getData();
	}

	public void addFirst(T value) {
		addBetween(value, head, head.getNextLink());
	}

	public void addLast(T value) {
		addBetween(value, tail.getPrevLink(), tail);
	}

	private void addBetween(T value, Node<T> prev, Node<T> next) {
		Node<T> tempNode = new Node<T>(value, next, prev);
		prev.setNextLink(tempNode);
		next.setPrevLink(tempNode);
		size++;
	}

	public T removeFirst() {
		return remove(head.getNextLink());
	}

	public T removeLast() {
		return remove(tail.getPrevLink());
	}

	private T remove(Node<T> theNode) {
		if(isEmpty()) {
			return null;
		}
		else {
			theNode.getPrevLink().setNextLink(theNode.getNextLink());
			theNode.getNextLink().setPrevLink(theNode.getPrevLink());
			size--;
			return theNode.getData();
		}
	}

	//Updated toString method
	public String toString() {
		Node<T> tempNode = head.getNextLink();
		String theResult = "The list: ";
		while(tempNode.getNextLink() != null) {
			theResult = theResult + tempNode.getData().toString() + " ";
			tempNode = tempNode.getNextLink();
		}
		return theResult;
	}

	//NEW remove method
	public boolean remove(T element) {
		Node<T> tempNode = head.getNextLink();
		if(head.getNextLink().getData() == null) {
			return false;
		}
		else if(head.getNextLink().getData().equals(element)) {
			head = head.getNextLink();
			size--;
			return true;
		}
		else {
			while(!tempNode.getData().equals(element)) {
				tempNode = tempNode.getNextLink();
				if(tempNode.getData() == null) {
					System.out.println("Error: Element not found in list");
					return false;
				}
			}
			Node<T> tempP = tempNode.getPrevLink();
			Node<T> tempN = tempNode.getNextLink();
			tempNode.getPrevLink().setNextLink(tempN);
			tempNode.getNextLink().setPrevLink(tempP);
			return true;
		}	
	}
}