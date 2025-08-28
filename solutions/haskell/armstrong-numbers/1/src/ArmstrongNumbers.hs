module ArmstrongNumbers (armstrong) where

armstrong :: (Read a, Show a, Integral a) => a -> Bool
armstrong 0 = True
armstrong x = (==) x $ sum $ map (\n -> read [n] ^ floor ((logBase 10 $ fromIntegral x) + 1)) (show x)
