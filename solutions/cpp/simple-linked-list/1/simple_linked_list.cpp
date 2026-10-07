#include "simple_linked_list.h"

#include <stdexcept>

namespace simple_linked_list {

std::size_t List::size() const { return this->current_size; }

// Pushes an Element with `entry` as data to
// the front of the list.
void List::push(int entry) {
  auto new_head = new Element{entry};
  new_head->next = this->head;
  this->head = new_head;
  this->current_size++;
}

// Returns the data value of the first
// element in the list then discard that element.
int List::pop() {
  if (this->head == nullptr)
    throw new std::out_of_range{"Empty list"};
  return this->unchecked_pop();
}

int List::unchecked_pop() noexcept {
  auto old_head = this->head;
  this->head = old_head->next;
  auto result = old_head->data;
  delete old_head;
  this->current_size--;
  return result;
}

// Reverses the order of the elements in the
// list.
void List::reverse() {
  if (this->head == nullptr)
    return;
  Element *cur = this->head;
  Element *prev = nullptr;
  Element *next;
  while (cur != nullptr) {
    next = cur->next;
    cur->next = prev;
    prev = cur;
    cur = next;
  }
  this->head = prev;
}

List::~List() {
  auto capacity = this->size();
  for (; capacity > 0; capacity--) {
    this->unchecked_pop();
  }
}

} // namespace simple_linked_list
