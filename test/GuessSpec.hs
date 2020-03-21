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
  describe "countInjured" $
    forM_
      [ ((1, 2, 3, 4), 0)
      , ((9, 3, 5, 7), 1)
      , ((6, 4, 2, 0), 2)
      , ((4, 3, 2, 1), 4)
      ]
      (\(toCompare, expectedCount) ->
         it ("counts number of injured " ++ show toCompare) $
         countInjured (1, 2, 3, 4) toCompare `shouldBe` expectedCount)
