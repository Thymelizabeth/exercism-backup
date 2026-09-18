#ifndef RATIONAL_NUMBERS_H
#define RATIONAL_NUMBERS_H

typedef struct {
  short numerator;
  short denominator;
} rational_t;

rational_t add(rational_t a, rational_t b);
rational_t subtract(rational_t a, rational_t b);
rational_t multiply(rational_t a, rational_t b);
rational_t divide(rational_t a, rational_t b);
rational_t absolute(rational_t a);
rational_t exp_rational(rational_t r, double n);
double exp_real(double x, rational_t r);
rational_t reduce(rational_t r);

#endif
