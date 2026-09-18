#include "linked_list.h"
#include <stdlib.h>

struct list_node {
  struct list_node *prev, *next;
  ll_data_t data;
  int _padding;
};

struct list {
  struct list_node *first, *last;
};

struct list *list_create(void) {
  struct list *res = (struct list *)malloc(sizeof(*res));
  res->first = NULL;
  res->last = NULL;
  return res;
}

size_t list_count(const struct list *list) {
  size_t count = 0;
  struct list_node *cur = list->first;
  while (cur != NULL) {
    count += 1;
    cur = cur->next;
  }
  return count;
}

void list_push(struct list *list, ll_data_t item_data) {
  struct list_node *new_node = (struct list_node *)malloc(sizeof(*new_node));
  new_node->prev = list->last;
  new_node->next = NULL;
  new_node->data = item_data;
  if (list->last == NULL) {
    list->first = new_node;
    list->last = new_node;
  } else {
    list->last->next = new_node;
    list->last = new_node;
  }
}

ll_data_t list_pop(struct list *list) {
  ll_data_t res;
  struct list_node *popped = list->last;
  list->last = popped->prev;
  if (list->last != NULL) {
    list->last->next = NULL;
  } else {
    list->first = NULL;
  }
  res = popped->data;
  free(popped);
  return res;
}

void list_unshift(struct list *list, ll_data_t item_data) {
  struct list_node *new_node = (struct list_node *)malloc(sizeof(*new_node));
  new_node->next = list->first;
  new_node->prev = NULL;
  new_node->data = item_data;
  if (list->first == NULL) {
    list->first = new_node;
    list->last = new_node;
  } else {
    list->first->prev = new_node;
    list->first = new_node;
  }
}

ll_data_t list_shift(struct list *list) {
  ll_data_t res;
  struct list_node *shifted = list->first;
  list->first = shifted->next;
  if (list->first != NULL) {
    list->first->prev = NULL;
  } else {
    list->last = NULL;
  }
  res = shifted->data;
  free(shifted);
  return res;
}

void list_delete(struct list *list, ll_data_t data) {
  struct list_node *cur = list->first;
  while (cur != NULL) {
    if (cur->data == data) {
      if (list->first == cur) {
        list->first = cur->next;
      }
      if (list->last == cur) {
        list->last = cur->prev;
      }
      if (cur->prev != NULL) {
        cur->prev->next = cur->next;
      }
      if (cur->next != NULL) {
        cur->next->prev = cur->prev;
      }
      free(cur);
      return;
    }
    cur = cur->next;
  }
}

void list_destroy(struct list *list) {
  struct list_node *cur = list->first;
  while (cur != NULL) {
    struct list_node *next = cur->next;
    free(cur);
    cur = next;
  }
  free(list);
}
