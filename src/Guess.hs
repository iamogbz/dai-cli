module Guess
  ( Guess(..)
  , GuessResult(..)
  , allPossible
  , limitPossible
  , showGuess
  ) where

import           Data.List

-- Given a list of results get all the remaining possible guesses
limitPossible :: [Int] -> Int -> [GuessResult] -> [Guess]
limitPossible allowedDigits numDigits prevGuesses =
  filter (\g -> all (isPossible g) prevGuesses) $ allPossible allowedDigits numDigits

-- All possible guesses in the game
allPossible :: [Int] -> Int -> [Guess]
allPossible _ 0 = [[] | isValid [] 0]
allPossible allowedDigits numDigits =
  [ x : rest | x <- allowedDigits, rest <- allPossible allowedDigits (numDigits - 1), isValid (x:rest) numDigits ]

-- Given a result check if a guess is still possibly correct
isPossible :: Guess -> GuessResult -> Bool
isPossible g r = countDead g' g == dead r && countInjured g' g == injured r
  where
    g' = guess r

-- Checks if a guess is valid i.e. has no repeated numbers
isValid :: Guess -> Int -> Bool
isValid xs n = length (nub xs) == n && length xs == n

-- Check how many numbers in the guess match in the same possition
countDead :: Guess -> Guess -> Int
countDead [] _ = 0
countDead _ [] = 0
countDead (x:xs) (y:ys) = fromEnum (x == y) + countDead xs ys

-- Check how many numbers in the guess match but not in the same position
countInjured :: Guess -> Guess -> Int
countInjured [] _ = 0
countInjured xs ys = sum [fromEnum $ elem x ys | x <- xs] - countDead xs ys

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
showGuess = concatMap show

-- guess type
type Guess = [Int]
