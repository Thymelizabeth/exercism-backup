#include "list_ops.h"

list_t *new_list(size_t length, list_element_t elements[]) {
  list_t *l = malloc(sizeof(list_t) + length * sizeof(list_element_t));
  l->length = length;
  for (size_t i = 0; i < length; i++) {
    l->elements[i] = elements[i];
  }
  return l;
}

list_t *append_list(list_t *list1, list_t *list2) {
  list_t *res = malloc(sizeof(list_t) + (list1->length + list2->length) *
                                            sizeof(list_element_t));
  res->length = list1->length + list2->length;
  memcpy(res->elements, list1->elements,
         sizeof(list_element_t) * list1->length);
  memcpy(&res->elements[list1->length], list2->elements,
         sizeof(list_element_t) * list2->length);
  return res;
}

list_t *filter_list(list_t *list, bool (*filter)(list_element_t)) {
  list_t *res = malloc(sizeof(list_t) + list->length * sizeof(list_element_t));
  size_t j = 0;
  for (size_t i = 0; i < list->length; i++) {
    if (filter(list->elements[i])) {
      res->elements[j++] = list->elements[i];
    }
  }
  res->length = j <= list->length ? j : list->length;
  return res;
}

size_t length_list(list_t *list) { return list->length; }

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t)) {
  list_t *res = malloc(sizeof(list_t) + list->length * sizeof(list_element_t));
  res->length = list->length;
  for (size_t i = 0; i < list->length; i++) {
    res->elements[i] = map(list->elements[i]);
  }
  return res;
}

list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t)) {

  list_element_t z = initial;
  for (size_t i = 0; i < list->length; i++) {
    z = foldl(z, list->elements[i]);
  }
  return z;
}

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t)) {
  list_element_t z = initial;
  for (size_t i = 0; i < list->length; i++) {
    z = foldr(list->elements[list->length - i - 1], z);
  }
  return z;
}

list_t *reverse_list(list_t *list) {
  list_t *res = malloc(sizeof(list_t) + list->length * sizeof(list_element_t));
  res->length = list->length;
  for (size_t i = 0; i < list->length; i++) {
    res->elements[i] = list->elements[list->length - i - 1];
  }
  return res;
}

void delete_list(list_t *list) { free(list); }
