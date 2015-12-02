module Main where

import Data.UUID.V4 (nextRandom)

main :: IO ()
main = print =<< nextRandom
