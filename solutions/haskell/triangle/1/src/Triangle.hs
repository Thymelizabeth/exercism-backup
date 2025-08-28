module Triangle (TriangleType(..), triangleType) where

data TriangleType = Equilateral
                  | Isosceles
                  | Scalene
                  | Illegal
                  deriving (Eq, Show)

triangleType :: (Num a, Ord a) => a -> a -> a -> TriangleType
triangleType a b c 
  | a == b && b == c && isValidTriangle a b c = Equilateral
  | (a == b || b == c || a == c) && isValidTriangle a b c = Isosceles
  | a /= b && b /= c && a /= c && isValidTriangle a b c = Scalene
  | otherwise = Illegal

isValidTriangle :: (Num a, Ord a) => a -> a -> a -> Bool
isValidTriangle a b c = all (> 0) [a,b,c] 
                      && a + b >= c 
                      && b + c >= a 
                      && a + c >= b