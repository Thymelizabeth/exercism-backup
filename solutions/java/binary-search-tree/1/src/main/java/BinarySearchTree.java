import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

class BinarySearchTree<T extends Comparable<T>> {
    private Node<T> root;

    BinarySearchTree() {
	root = null;
    }
    
    void insert(T value) {
	root = insertR(value, root);
    }

    private Node<T> insertR(T value, Node<T> cRoot) {
	if (cRoot == null)
	    cRoot = new Node<T>(value);
	else if (value.compareTo(cRoot.value) <= 0)
	    cRoot.left = insertR(value, cRoot.left);
	else
	    cRoot.right = insertR(value, cRoot.right);
	return cRoot;
    }

    List<T> getAsSortedList() {
	return getAsSortedListR(root);
    }

    private List<T> getAsSortedListR(Node<T> cRoot) {
	List<T> result = new ArrayList<T>();	
	if (cRoot == null)
	    return result;
	result.addAll(getAsSortedListR(cRoot.getLeft()));
	result.add(cRoot.getData());
	result.addAll(getAsSortedListR(cRoot.getRight()));
	return result;
    }

    List<T> getAsLevelOrderList() {
	int depth = getDepth(root);
	if (depth < 1)
	    return new ArrayList<T>();
        Node<T>[] result = new Node[(int)Math.pow(2, depth) - 1];
	result[0] = root;
	for (int i = 0; i < (int)Math.pow(2, depth - 1) - 1; i++) {
	    if (result[i] == null)
		continue;
	    result[2 * i + 1] = result[i].getLeft();
	    result[2 * i + 2] = result[i].getRight();
	}
	return Arrays.stream(result).filter(v -> v != null).map(v -> v.value).toList();
    }

    int getDepth() {
	return getDepth(getRoot());
    }

    private int getDepth(Node<T> cRoot) {
	if (cRoot == null)
	    return 0;
	else
	    return 1 + Math.max(getDepth(cRoot.getLeft()), getDepth(cRoot.getRight()));
    }

    Node<T> getRoot() {
        return root;
    }

    static class Node<T> {

	private Node<T> left;
	private Node<T> right;
	private T value;

	Node(T value) {
	    this.value = value;
	    left = null;
	    right = null;
	}

        Node<T> getLeft() {
            return left;
        }

        Node<T> getRight() {
            return right;
        }

        T getData() {
            return value;
        }

    }
}
