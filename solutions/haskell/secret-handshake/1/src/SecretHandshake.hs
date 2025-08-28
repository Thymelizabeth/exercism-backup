module SecretHandshake (handshake) where
import Data.Bits

handshake :: Int -> [String]
handshake n = takeAction $ map numToAction $ decToBin n

decToBin :: Int -> [Int]
decToBin n = map ((.&. n) . (2 ^)) [0..4]

numToAction :: Int -> String
numToAction 1  = "wink"
numToAction 2  = "double blink"
numToAction 4  = "close your eyes"
numToAction 8  = "jump"
numToAction 16 = "reverse"
numToAction _  = ""

takeAction :: [String] -> [String]
takeAction xs@([_,_,_,_,r]) = if r == "reverse" then takeAction $ tail $ reverse xs else takeAction $ init xs
takeAction xs = filter (/= "") xs