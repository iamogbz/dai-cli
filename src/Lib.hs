module Lib
  ( launch
  ) where

import           Control.Monad
import           Data.Maybe
import           Guess
import           System.Random

main = launch

launch :: IO ()
launch = do
  putStrLn "Enter the lowest digit e.g. 0 or 1"
  l <- getLine
  let from = read l :: Int
  let to = 9
  putStrLn "Enter the number of digits e.g. 4"
  n <- getLine
  let len = read n :: Int
  putStrLn "Pick a hidden number"
  putStrLn $ n ++ " non repeating digits between " ++ show from ++ " and " ++ show to
  putStrLn "Enter to continue ↵"
  l <- getLine
  result <- nextGuess [from .. to] len []
  if isNothing result
    then do
      putStrLn "Oops unable to guess your number!"
      putStrLn "Are you sure you gave me the right answers?"
    else putStrLn "Who's the best? I am! I am the best."

nextGuess :: [Int] -> Int -> [GuessResult] -> IO (Maybe GuessResult)
nextGuess range len prevGuessResults = do
  putStrLn ""
  let possible = limitPossible range len prevGuessResults
  if null possible
    then return Nothing
    else do
      randomI <- randomRIO (0, length possible - 1)
      let guess = possible !! randomI
      putStrLn ("My guess is: " ++ showGuess guess)
      putStrLn "How many dead? "
      l <- getLine
      let deadN = read l :: Int
      if deadN == len
        then return (Just (GuessResult guess len 0))
        else do
          putStrLn "How many injured? "
          l <- getLine
          let injuredN = read l :: Int
          nextGuess range len (GuessResult guess deadN injuredN : prevGuessResults)
