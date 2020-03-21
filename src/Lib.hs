module Lib
  ( launch
  ) where

import           Control.Monad
import           Guess

main = launch

launch :: IO ()
launch = do
  putStrLn "Pick a hidden number (press Enter to continue)"
  l <- getLine
  nextGuess []
  return ()

nextGuess :: [GuessResult] -> IO (Maybe GuessResult)
nextGuess prevGuessResults = do
  let possible = limitPossible prevGuessResults
  if null possible
    then return Nothing
    else do
      let guess = head possible
      putStrLn ("My guess is: " ++ showGuess guess)
      putStr "How many dead? "
      l <- getLine
      let deadN = read l :: Int
      if deadN == 4
        then return (Just (GuessResult guess 4 0))
        else do
          putStr "How many injured? "
          l <- getLine
          let injuredN = read l :: Int
          nextGuess (GuessResult guess deadN injuredN : prevGuessResults)
