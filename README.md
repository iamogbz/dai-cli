# Dead & Injured

Sample cli game made with haskell

## Overview

The aim of the game is to deduce the 4 digit number your opponent is hiding.
You do this by making guesses and evaluate the results of your guesses.

How many guesses it takes you to solve the number is your score.
The best possible score is `1` 😁.

## Rules

Your opponent chooses a number matching the following condition without revealing it to you:

1. The number must be 4 digits long.
1. The number must not have repeated digits.
1. Each digit must be in the range `1..9`.
   Optionally include `0` to expand the possibiliies.

After the hidden number has been recorded, you begin guessing and your opponent responds with the results of your guess.
The result is a count of "Dead" and "Injured" digits.

- **Dead** means there are `n` number of digits in your guess number that match the position in the hidden number.
  Example; with a hidden number of `1234` and a guess of `2354`, the number of dead digits is `1`.

- **Injured** means there are `n` number of digits in your guess number that exist in the hidden number but do the positions do not match.
  Example; with a hidden number of `1234` and a guess of `2354`, the number of injured is `2`

The sum of dead and injured counts can not exceed 4.
The round ends when a guess is made with `4` dead digits 🎉.

## Run

```sh
stack build
stack exec dai-exe
```

![demo.gif](https://user-images.githubusercontent.com/2528959/77232698-08bc6280-6b79-11ea-8aa1-a5b4dffd9814.gif)
