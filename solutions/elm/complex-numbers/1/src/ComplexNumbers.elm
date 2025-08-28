module ComplexNumbers exposing
    ( Complex
    , abs
    , add
    , conjugate
    , div
    , exp
    , fromPair
    , fromReal
    , imaginary
    , mul
    , real
    , sub
    )


type Complex
    = Complex Float Float


fromPair : ( Float, Float ) -> Complex
fromPair ( x, y ) =
    Complex x y


fromReal : Float -> Complex
fromReal float =
    Complex float 0


real : Complex -> Float
real (Complex x _) =
    x


imaginary : Complex -> Float
imaginary (Complex _ y) =
    y


conjugate : Complex -> Complex
conjugate (Complex x y) =
    Complex x -y


abs : Complex -> Float
abs (Complex x y) =
    sqrt (x ^ 2 + y ^ 2)


add : Complex -> Complex -> Complex
add (Complex x1 y1) (Complex x2 y2) =
    Complex (x1 + x2) (y1 + y2)


sub : Complex -> Complex -> Complex
sub (Complex x1 y1) (Complex x2 y2) =
    Complex (x1 - x2) (y1 - y2)


mul : Complex -> Complex -> Complex
mul (Complex x1 y1) (Complex x2 y2) =
    Complex (x1 * x2 - y1 * y2) (y1 * x2 + x1 * y2)


div : Complex -> Complex -> Complex
div (Complex x1 y1) (Complex x2 y2) =
    Complex ((x1 * x2 + y1 * y2) / (x2 ^ 2 + y2 ^ 2)) ((x2 * y1 - x1 * y2) / (x2 ^ 2 + y2 ^ 2))


exp : Complex -> Complex
exp (Complex x y) =
    mul (fromReal (e ^ x)) (Complex (cos y) (sin y))
