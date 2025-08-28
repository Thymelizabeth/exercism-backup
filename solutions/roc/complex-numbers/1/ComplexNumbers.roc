module [real, imaginary, add, sub, mul, div, conjugate, abs, exp]

Complex : { re : F64, im : F64 }

real : Complex -> F64
real = .re

imaginary : Complex -> F64
imaginary = .im

add : Complex, Complex -> Complex
add = |{ re: a, im: b }, { re: c, im: d }|
    { re: a + c, im: b + d }

sub : Complex, Complex -> Complex
sub = |{ re: a, im: b }, { re: c, im: d }|
    { re: a - c, im: b - d }

mul : Complex, Complex -> Complex
mul = |{ re: a, im: b }, { re: c, im: d }|
    { re: a * c - b * d, im: b * c + a * d }

div : Complex, Complex -> Complex
div = |{ re: a, im: b }, { re: c, im: d }|
    { re: (a * c + b * d) / (c ^ 2 + d ^ 2), im: (b * c - a * d) / (c ^ 2 + d ^ 2) }

conjugate : Complex -> Complex
conjugate = |{ re, im }|
    { re, im: -im }

abs : Complex -> F64
abs = |{ re, im }|
    Num.sqrt(re ^ 2 + im ^ 2)

exp : Complex -> Complex
exp = |{ re: a, im: b }|
    { re: (Num.e ^ a) * Num.cos(b), im: (Num.e ^ a) * Num.sin(b) }
