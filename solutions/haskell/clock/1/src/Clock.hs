module Clock (addDelta, fromHourMin, toString) where

data Clock = Clock { toHour :: Int
                   , toMinute :: Int
                   }
  deriving Eq

fromHourMin :: Int -> Int -> Clock
fromHourMin h m = Clock ((h + h') `mod` 24) m'
  where (h', m') = m `divMod` 60

toString :: Clock -> String
toString (Clock hour minute) = (if hour < 10 then "0" else "") 
                             <> show hour 
                             <> ":" 
                             <> (if minute < 10 then "0" else "") 
                             <> show minute

addDelta :: Int -> Int -> Clock -> Clock
addDelta h' m' (Clock h m) = fromHourMin (h + h') (m + m')
