module School (School, add, empty, grade, sorted) where
import Data.Bifunctor (second)
import Data.List (sort)
import Data.Map.Lazy (Map)
import qualified Data.Map.Lazy as M

type School = Map Int [String]

add :: Int -> String -> School -> School
add gradeNum student = M.insertWith ((:) . head) gradeNum [student]

empty :: School
empty = M.empty

grade :: Int -> School -> [String]
grade = maybe [] sort .: M.lookup

sorted :: School -> [(Int, [String])]
sorted = map (second sort) . M.toAscList

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(f .: g) x y = f (g x y)