module Guess
  ( Guess(..)
  , GuessResult(..)
  , allPossible
  , limitPossible
  , showGuess
  ) where

import           Data.List

-- Given a list of results get all the remaining possible guesses
limitPossible :: [Int] -> [GuessResult] -> [Guess]
limitPossible range constraints =
  filter (\g -> all (isPossible g) constraints) $ allPossible range

-- All possible guesses in the game
allPossible :: [Int] -> [Guess]
allPossible range =
  [ (a, b, c, d)
  | a <- range
  , b <- range
  , c <- range
  , d <- range
  , isValid (a, b, c, d)
  ]

-- Given a result check if a guess is still possibly correct
isPossible :: Guess -> GuessResult -> Bool
isPossible g r = countDead g' g == dead r && countInjured g' g == injured r
  where
    g' = guess r

-- Checks if a guess is valid i.e. has no repeated numbers
isValid :: Guess -> Bool
isValid (a, b, c, d) = length (nub xs) == length xs
  where
    xs = [a, b, c, d]

-- Check how many numbers in the guess match in the same possition
countDead :: Guess -> Guess -> Int
countDead (a, b, c, d) (w, x, y, z) =
  sum $ map fromEnum [a == w, b == x, c == y, d == z]

-- Check how many numbers in the guess match but not in the same position
countInjured :: Guess -> Guess -> Int
countInjured (a, b, c, d) (w, x, y, z) =
  sum $
  map
    fromEnum
    [ a `elem` [x, y, z]
    , b `elem` [w, y, z]
    , c `elem` [w, x, z]
    , d `elem` [w, x, y]
    ]

-- guess result
data GuessResult =
  GuessResult
    { guess   :: Guess
    , dead    :: Int
    , injured :: Int
    }
  deriving (Show)

-- pretty print guess
showGuess :: Guess -> String
showGuess (a, b, c, d) = concatMap show [a, b, c, d]

-- guess type
type Guess = (Int, Int, Int, Int)
