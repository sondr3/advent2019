module Main
  ( main
  )
where

import           Data.List                      ( foldl' )

readInt :: String -> Int
readInt = read

main :: IO ()
main = do
  c <- readFile "inputs/input-aoc01.txt"
  let content = map readInt (words c)
  print (partOne content)
  print (partTwo content)
  return ()

fuelReq :: Int -> Int
fuelReq x = x `quot` 3 - 2

fuelSum :: Int -> Int
fuelSum x = sum . takeWhile (> 0) $ drop 1 $ iterate fuelReq x

partOne :: [Int] -> Int
partOne = foldr (\x xs -> xs + fuelReq x) 0

partTwo :: [Int] -> Int
partTwo = foldr (\x xs -> xs + fuelSum x) 0
