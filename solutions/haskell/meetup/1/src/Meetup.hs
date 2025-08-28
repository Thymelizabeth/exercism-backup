module Meetup (Weekday(..), Schedule(..), meetupDay) where

import Data.Time.Calendar (Day, firstDayOfWeekOnAfter, fromGregorian, isLeapYear)
import qualified Data.Time.Calendar as DTC (DayOfWeek(..))
import Data.Time.Calendar.MonthDay (monthLength)

data Weekday = Monday
             | Tuesday
             | Wednesday
             | Thursday
             | Friday
             | Saturday
             | Sunday

data Schedule = First
              | Second
              | Third
              | Fourth
              | Last
              | Teenth

meetupDay :: Schedule -> Weekday -> Integer -> Int -> Day
meetupDay schedule weekday year month = firstDayOfWeekOnAfter dayOfWeek $ fromGregorian year month firstDay
  where 
    firstDay = case schedule of
      First -> 1
      Second -> 8
      Third -> 15
      Fourth -> 22
      Last -> (monthLength (isLeapYear year) month) - 6 
      Teenth -> 13
    dayOfWeek = case weekday of
      Monday -> DTC.Monday
      Tuesday -> DTC.Tuesday
      Wednesday -> DTC.Wednesday
      Thursday -> DTC.Thursday
      Friday -> DTC.Friday
      Saturday -> DTC.Saturday
      Sunday -> DTC.Sunday
