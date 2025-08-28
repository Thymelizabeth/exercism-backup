module RationalNumbers
(Rational,
 abs,
 numerator,
 denominator,
 add,
 sub,
 mul,
 div,
 pow,
 expRational,
 expReal,
 rational) where

import Prelude hiding (div, abs, Rational)

-- Data definition -------------------------------------------------------------
data Rational a = R a a deriving(Eq, Show)

rational :: Integral a => (a, a) -> Rational a
rational (a,b) = R (quot a' m) (quot b' m)
  where (a',b') = if b < 0 then (-a, -b) else (a, b)
        m = gcd a b

-- unary operators -------------------------------------------------------------
abs :: Integral a => Rational a -> Rational a
abs (R a b) = rational ((if a < 0 then (-a) else a),(if b < 0 then (-b) else b))

numerator :: Integral a => Rational a -> a
numerator (R a _) = a

denominator :: Integral a => Rational a -> a
denominator (R _ b) = b

-- binary operators ------------------------------------------------------------
add :: Integral a => Rational a -> Rational a -> Rational a
add (R a1 b1) (R a2 b2) = rational ((a1 * b2 + a2 * b1),(b1 * b2))

sub :: Integral a => Rational a -> Rational a -> Rational a
sub (R a1 b1) (R a2 b2) = rational ((a1 * b2 - a2 * b1),(b1 * b2))

mul :: Integral a => Rational a -> Rational a -> Rational a
mul (R a1 b1) (R a2 b2) = rational ((a1 * a2),(b1 * b2))

div :: Integral a => Rational a -> Rational a -> Rational a
div (R a1 b1) (R a2 b2) = rational ((a1 * b2),(a2 * b1))

pow :: Integral a => Rational a -> a -> Rational a
pow (R a b) n = if n >= 0 
                then rational ((a ^ n),(b ^ n))
                else rational ((b ^ (-n)),(a ^ (-n)))

expRational :: (Integral a, Floating b) => Rational a -> b -> b
expRational (R a b) n = fromIntegral a ** n / fromIntegral b ** n

expReal :: Floating a => Integral b => a -> Rational b -> a
expReal n (R a b) = (n ^^ fromIntegral a) ** (1 / fromIntegral b)

