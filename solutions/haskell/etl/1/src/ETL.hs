module ETL (transform) where

import Data.Char (toLower)
import Data.Map (Map)
import qualified Data.Map as M

transform :: Map a String -> Map Char a
transform = M.foldrWithKey (\k v m -> foldr (\c -> M.insert (toLower c) k) m v) M.empty 
