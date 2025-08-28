module ProteinTranslation(proteins) where
import Data.Map (Map)
import qualified Data.Map as M

proteinMap :: Map String String
proteinMap = M.fromList [ ("AUG","Methionine")
                        , ("UUU","Phenylalanine")
                        , ("UUC","Phenylalanine")
                        , ("UUA","Leucine")
                        , ("UUG","Leucine")
                        , ("UCU","Serine") 
                        , ("UCC","Serine")
                        , ("UCA","Serine")
                        , ("UCG","Serine")
                        , ("UAU","Tyrosine")
                        , ("UAC","Tyrosine")
                        , ("UGU","Cysteine")
                        , ("UGC","Cysteine")
                        , ("UGG","Tryptophan")]

proteins :: String -> Maybe [String]
proteins = sequenceA . proteins'

proteins' :: String -> [Maybe String]
proteins' (x:y:z:xs) = maybe [] (\x -> Just x : proteins' xs) $ M.lookup [x,y,z] proteinMap
proteins' _ = []