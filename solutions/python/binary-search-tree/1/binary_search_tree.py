class TreeNode:
    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        return f'TreeNode(data={self.data}, left={self.left}, right={self.right})'


class BinarySearchTree:
    def __init__(self, tree_data):
        self.root = None
        for i in tree_data:
            self.insert(i)
    
    def insertR(self, value, cRoot):
        if cRoot is None:
            cRoot = TreeNode(value)
        elif value <= cRoot.data:
            cRoot.left = self.insertR(value, cRoot.left)
        else:
            cRoot.right = self.insertR(value, cRoot.right)
        return cRoot

    def insert(self, value):
        self.root = self.insertR(value, self.root)

    def data(self):
        return self.root

    def sorted_data(self):
        if self.root is None:
            return None
        return self._sorted_data(self.root)

    def _sorted_data(self, cRoot):
        return ([] if cRoot.left is None else self._sorted_data(cRoot.left)) + [cRoot.data] + ([] if cRoot.right is None else self._sorted_data(cRoot.right))
