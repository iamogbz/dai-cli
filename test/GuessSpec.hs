module GuessSpec where

import           Control.Monad
import           Guess
import           Test.Hspec

spec :: Spec
spec = do
  describe "showGuess" $
    forM_
      [((1, 2, 3, 4), "1234"), ((9, 8, 7, 6), "9876")]
      (\(toPrint, expectedString) ->
         it ("pretty prints guess " ++ show toPrint) $
         showGuess toPrint `shouldBe` expectedString)
  describe "allPossible" $
    it "captures all possible permutations" $ length (allPossible [1..9]) `shouldBe` 3024
  describe "limitPossible" $
    forM_
      [ ([GuessResult (1, 2, 3, 4) 4 0], 1)
      , ([GuessResult (1, 2, 3, 4) 0 4], 9)
      , ([GuessResult (1, 2, 3, 4) 0 4, GuessResult (4, 3, 2, 1) 0 0], 0)
      , ([GuessResult (1, 2, 3, 4) 0 4, GuessResult (2, 1, 3, 4) 1 3], 4)
      , ( [ GuessResult (1, 2, 3, 4) 1 1
          , GuessResult (9, 8, 7, 6) 1 1
          , GuessResult (2, 3, 7, 8) 0 1
          ]
        , 12)
      ]
      (\(results, expectedCount) ->
         it "correctly limits possible values" $
         length (limitPossible [1..9] results) `shouldBe` expectedCount)
