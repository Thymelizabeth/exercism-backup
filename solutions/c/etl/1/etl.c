#include "etl.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

static int comp(const new_map *a, const new_map *b) { return a->key - b->key; }

size_t convert(const legacy_map *input, const size_t input_len,
               new_map **output) {
  size_t output_len = 0;
  for (size_t i = 0; i < input_len; i++) {
    output_len += strlen(input[i].keys);
  }

  *output = calloc(output_len, sizeof(new_map));

  size_t j = 0;
  size_t k = 0;
  for (size_t i = 0; i < output_len; i++) {
    (*output)[i].value = input[j].value;
    (*output)[i].key = tolower(input[j].keys[k++]);
    if (input[j].keys[k] == '\0') {
      j++;
      k = 0;
    }
  }

  qsort(*output, output_len, sizeof(new_map),
        (int (*)(const void *, const void *))comp);

  return output_len;
}
