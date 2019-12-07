module Main where

import           Data.List.Split                ( splitOn )
import           Data.List                      ( sort )
import qualified Data.Set                      as Set

data Direction x = DRight Int | DLeft Int | DDown Int | DUp Int deriving (Show, Eq)
type Coord = (Int, Int)

direction :: String -> Direction x
direction x = case take 1 x of
  "R" -> DRight (read $ drop 1 x)
  "L" -> DLeft (read $ drop 1 x)
  "D" -> DDown (read $ drop 1 x)
  "U" -> DUp (read $ drop 1 x)

move :: Direction x -> Coord -> Coord
move d (x, y) = case d of
  DRight i -> (x + i, y)
  DLeft  i -> (x - i, y)
  DDown  i -> (x, y - i)
  DUp    i -> (x, y + i)

between :: Coord -> Coord -> [Coord]
between (x1, y1) (x2, y2) | x1 > x2   = [ (x, y1) | x <- [x2 .. x1] ]
                          | x2 > x1   = [ (x, y1) | x <- [x1 .. x2] ]
                          | y1 > y2   = [ (x1, y) | y <- [y2 .. y1] ]
                          | y2 > y1   = [ (x1, y) | y <- [y1 .. y2] ]
                          | otherwise = [(x1, y1), (x2, y2)]

step :: [Direction x] -> Coord -> [Coord]
step []       _      = []
step (d : ds) (x, y) = pos : step ds pos where pos = move d (x, y)

walk :: [Coord] -> Coord -> [[Coord]]
walk []       _   = []
walk (x : xs) pos = between pos x : walk xs x

run :: [Direction x] -> Coord -> [Coord]
run xs pos = tail $ concat $ walk (step xs pos) pos

intersections :: Set.Set Coord -> Set.Set Coord -> Set.Set Coord
intersections xs ys = xs `Set.intersection` ys

distance :: Coord -> Coord -> Int
distance (x1, y1) (x2, y2) = abs (x1 - x2) + abs (y1 - y2)

parse :: String -> [Set.Set Coord]
parse s = map
  (Set.fromList . (\x -> run x (0, 0)) . (map direction . splitOn ","))
  (lines s)

main :: IO ()
main = do
  c <- readFile "inputs/aoc03.txt"
  day3a c

-- | Day3A solutions
-- >>> day3a "R8,U5,L5,D3\nU7,R6,D4,L4"
-- 6
-- >>> day3a "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
-- 159
-- >>> day3a "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
-- 135
day3a :: String -> IO ()
day3a s = do
  let (xs : ys : _) = parse s
  print (Set.elemAt 0 $ Set.map (distance (0, 0)) (intersections xs ys))
  return ()

day3b = undefined
