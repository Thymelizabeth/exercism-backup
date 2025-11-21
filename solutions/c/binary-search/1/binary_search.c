#include "binary_search.h"

const int *binary_search(const int value, const int *arr, const size_t length) {
    if (!length) {
        return NULL;
    }
    const size_t mid = length / 2;
    const int mid_elem = arr[mid];
    if (value < mid_elem) {
        return binary_search(value, arr, mid);
    } else if (value == mid_elem) {
        return &arr[mid];
    } else {
        return binary_search(value, &arr[mid+1], length - mid - 1);
    }
}