#include "rational_numbers.h"
#include <math.h>
#include <stdlib.h>

rational_t add(rational_t a, rational_t b) {
  rational_t res = {
      .numerator = a.numerator * b.denominator + b.numerator * a.denominator,
      .denominator = a.denominator * b.denominator,
  };
  return reduce(res);
}

rational_t subtract(rational_t a, rational_t b) {
  rational_t res = {
      .numerator = a.numerator * b.denominator - b.numerator * a.denominator,
      .denominator = a.denominator * b.denominator,
  };
  return reduce(res);
}

rational_t multiply(rational_t a, rational_t b) {
  rational_t res = {
      .numerator = a.numerator * b.numerator,
      .denominator = a.denominator * b.denominator,
  };
  return reduce(res);
}

rational_t divide(rational_t a, rational_t b) {
  rational_t res = {
      .numerator = a.numerator * b.denominator,
      .denominator = b.numerator * a.denominator,
  };
  return reduce(res);
}

rational_t absolute(rational_t a) {
  rational_t res = {
      .numerator = abs(a.numerator),
      .denominator = abs(a.denominator),
  };
  return reduce(res);
}

rational_t exp_rational(rational_t r, double n) {
  rational_t res;
  if (round(n) == n) {
    if (n >= 0) {
      res.numerator = pow(r.numerator, n);
      res.denominator = pow(r.denominator, n);
    } else {
      double m = -n;
      res.numerator = pow(r.denominator, m);
      res.denominator = pow(r.numerator, m);
    }
  } else {
    res.numerator = pow(r.numerator, n);
    res.denominator = pow(r.denominator, n);
  }
  return reduce(res);
}

double exp_real(double x, rational_t r) {
  return pow(x, (double)r.numerator / (double)r.denominator);
}

static int gcd(int a, int b) {
  if (a == 0) {
    return b;
  }
  if (b == 0) {
    return a;
  }
  return gcd(b, a % b);
}

rational_t reduce(rational_t r) {
  int c;
  if (abs(r.numerator) > abs(r.denominator)) {
    c = gcd(abs(r.numerator), abs(r.denominator));
  } else {
    c = gcd(abs(r.denominator), abs(r.numerator));
  }
  rational_t res = {
      .numerator = r.numerator / c,
      .denominator = r.denominator / c,
  };
  if (res.numerator < 0 && res.denominator < 0) {
    res.numerator = -res.numerator;
    res.denominator = -res.denominator;
  } else if (res.denominator < 0) {
    res.numerator = -res.numerator;
    res.denominator = -res.denominator;
  }
  return res;
}
