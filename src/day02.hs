module Main
  ( main
  , day2a
  , day2b
  )
where

import           Data.List.Split                ( chunksOf
                                                , splitOn
                                                )

main :: IO ()
main = do
  c <- readFile "inputs/aoc02.txt"
  let content = map read (splitOn "," c)
  print (head $ day2a (head content : 12 : 2 : drop 3 content) 0)
  let (n, v) = day2b content 0 0
  print (100 * n + v)

insert :: [a] -> Int -> a -> [a]
insert xs i e = case splitAt i xs of
  (before, _ : after) -> before ++ e : after
  _                   -> xs

add :: Num a => Int -> Int -> Int -> [a] -> [a]
add x y o ys = insert ys o s where s = (ys !! x) + (ys !! y)

multiply :: Num a => Int -> Int -> Int -> [a] -> [a]
multiply x y o ys = insert ys o s where s = (ys !! x) * (ys !! y)

day2a :: [Int] -> Int -> [Int]
day2a xs c | done      = xs
           | op == 1   = day2a (add x y o xs) (c + 1)
           | op == 2   = day2a (multiply x y o xs) (c + 1)
           | otherwise = xs
 where
  (op : x : y : o : _) = chunk !! c
  done                 = head (chunk !! c) == 99
  chunk                = chunksOf 4 xs

day2b xs n v | done      = (n, v)
             | v == 99   = day2b xs (n + 1) 0
             | otherwise = day2b xs n (v + 1)
 where
  done = head cs == 19690720
  cs   = day2a ys 0
  ys   = head xs : n : v : drop 3 xs
