#include "binary_search_tree.h"
#include <stdlib.h>
#include <math.h>

node_t *build_tree(int *tree_data, size_t tree_data_len)
{
    node_t *root = NULL;
    for (size_t i = 0; i < tree_data_len; i++)
    {
        root = insert(tree_data[i], root);
    }
    return root;
}

node_t *insert(int data, node_t *cRoot)
{
    if (!cRoot)
    {
        node_t *root = malloc(sizeof(node_t));
        root->data = data;
        root->left = NULL;
        root->right = NULL;
        return root;
    }
    if (data <= cRoot->data)
    {
        cRoot->left = insert(data, cRoot->left);
    } else
    {
        cRoot->right = insert(data, cRoot->right);
    }
    return cRoot;
}

void free_tree(node_t *tree)
{
    if (tree == NULL)
        return;
    free_tree(tree->left);
    free_tree(tree->right);
    free(tree);
}

int depth(node_t *tree)
{
    if (tree == NULL)
        return 0;
    int left_depth = depth(tree->left);
    int right_depth = depth(tree->right);
    return 1 + (left_depth > right_depth ? left_depth : right_depth);
}

int *sorted_data(node_t *tree)
{
    int tree_depth = depth(tree);
    if (tree_depth < 1)
        return NULL;
    int *data = malloc(((int)round(pow(2.0, (double)tree_depth - 1.0))) * sizeof(int));
    get_as_sorted_data(data, tree, 0);
    return data;
}

int get_as_sorted_data(int *data, node_t *tree, int index)
{
    if (tree == NULL)
        return index;
    index = get_as_sorted_data(data, tree->left, index);
    data[index++] = tree->data;
    index = get_as_sorted_data(data, tree->right, index);
    return index;
}