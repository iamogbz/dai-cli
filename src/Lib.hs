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
  putStrLn "Pick a hidden number (press Enter to continue)"
  l <- getLine
  result <- nextGuess []
  if isNothing result
    then do
      putStrLn "Oops unable to guess your number!"
      putStrLn "Are you sure you gave me the right answers?"
    else putStrLn "Who's the best? I am! I am the best."

nextGuess :: [GuessResult] -> IO (Maybe GuessResult)
nextGuess prevGuessResults = do
  putStrLn ""
  let possible = limitPossible prevGuessResults
  if null possible
    then return Nothing
    else do
      randomI <- randomRIO (0, length possible)
      let guess = possible !! randomI
      putStrLn ("My guess is: " ++ showGuess guess)
      putStrLn "How many dead? "
      l <- getLine
      let deadN = read l :: Int
      if deadN == 4
        then return (Just (GuessResult guess 4 0))
        else do
          putStrLn "How many injured? "
          l <- getLine
          let injuredN = read l :: Int
          nextGuess (GuessResult guess deadN injuredN : prevGuessResults)
