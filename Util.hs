module Util where

countOnes :: [Char] -> Int
countOnes [] = 0
countOnes ('*':tail) = countOnes tail
countOnes ('0':tail) = countOnes tail
countOnes ('1':tail) = 1 + countOnes tail

chunksOf :: Int -> [Char] -> [[Char]]
chunksOf size list = chunksOf' size list 

chunksOf' :: Int -> [Char] -> [[Char]]
chunksOf' _ [] = []
chunksOf' size list = (take size list) : (chunksOf' size $ drop size list)

evenIndexItems :: [[Char]] -> [[Char]]
evenIndexItems [] = []
evenIndexItems [e] = [e] 
evenIndexItems (e0:e1:es) = [e0] ++ evenIndexItems es

concatenateLists :: [[Char]] -> [Char]
concatenateLists [] = []
concatenateLists (e:es) = e ++ concatenateLists es

powersOfTwo :: Float -> [Int]
powersOfTwo number = [ 2 ^ x | x <- [1 .. floor $ logBase 2 number] ]

isPowerOfTwo :: Int -> Bool
isPowerOfTwo number = (floorToPowerOfTwo number == number)

floorToPowerOfTwo :: Int -> Int
floorToPowerOfTwo number = floorToPowerOfTwo' number 0

floorToPowerOfTwo' :: Int -> Int -> Int
floorToPowerOfTwo' number exponent
    | (2 ^ exponent == number) = number
    | (2 ^ exponent > number) = 2 ^ (exponent - 1)
    | otherwise = floorToPowerOfTwo' number $ exponent + 1

replaceNthElement :: Int -> Char -> [Char] -> [Char]
replaceNthElement index element code = firstPart ++ [element] ++ drop 1 secondPart
    where (firstPart, secondPart) = splitAt index code