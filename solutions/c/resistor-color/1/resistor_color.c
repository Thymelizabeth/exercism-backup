#include "resistor_color.h"
#include <stdlib.h>
#include <string.h>

const resistor_band_t *colors(void) {
  resistor_band_t *result =
      (resistor_band_t *)calloc(10, sizeof(resistor_band_t));
  const resistor_band_t local[] = {BLACK, BROWN, RED,    ORANGE, YELLOW,
                                   GREEN, BLUE,  VIOLET, GREY,   WHITE};
  memcpy(result, local, 10 * sizeof(resistor_band_t));
  return result;
}

uint16_t color_code(resistor_band_t color) { return (uint16_t)color; }
