module HammingCode where

import System.IO
import Util

-- Detects a single error in the transmition of a code word. Returns True if
-- there is an error, False otherwise.
detectErrorHC :: [Char] -> Bool
detectErrorHC code = not $ null $ wrongParityBits code

-- Corrects a single error in the transmission of a code word. If there is not
-- an error, it returns the code received as a parameter.
correctHC :: [Char] -> [Char]
correctHC code
    | detectErrorHC code = firstPart ++ (correctBit : secondPart)
    | otherwise = code
    where (firstPart, (wrongBit : secondPart)) = splitAt wrongBitIndex code
          correctBit = invertBit (code !! wrongBitIndex)
          wrongBitIndex = sum (wrongParityBits code) - 1

-- Returns a list of wrong parity bits in a code word.
wrongParityBits :: [Char] -> [Int]
wrongParityBits code = wrongParityBits' code 0

wrongParityBits' :: [Char] -> Int -> [Int]
wrongParityBits' code exponent
    | (index >= codeLength) = []
    | (numberOfOnes `mod` 2 /= 0) = (position : wrongParityBits' code nextExponent)
    | otherwise = wrongParityBits' code nextExponent
    where index = position - 1
          position = 2 ^ exponent
          codeLength = length code
          nextExponent = exponent + 1
          numberOfOnes = countOnes (getBitsToBeChecked code exponent)

-- Inverts a single bit.
invertBit :: Char -> Char 
invertBit '0' = '1'
invertBit '1' = '0'

-- Returns a list of the bits that are checked by a parity bit. 
-- It uses the current exponent to determine the position of the parity bit and
-- which bits should be checked.
getBitsToBeChecked :: [Char] -> Int -> [Char]
getBitsToBeChecked code exponent = concatenateLists $ evenIndexItems $ chunks
    where chunks = chunksOf interval (drop start code)
          start = interval - 1
          interval = 2 ^ exponent

------------------------------ UNUSED FUNCTIONS ------------------------------

-- Generate the hamming code starting from a code word.
generateHammingCode :: [Char] -> [Char]
generateHammingCode code = generateHammingCode' 0 $ markParityBitPositions code

generateHammingCode' :: Int -> [Char] -> [Char]
generateHammingCode' exponent code
    | (index >= codeLength) = code
    | otherwise = generateHammingCode' (exponent + 1) (writeParityBit exponent code)
    where index = 2 ^ exponent - 1
          codeLength = length code

markParityBitPositions :: [Char] -> [Char]
markParityBitPositions code = markParityBitPositions' 0 code

markParityBitPositions' :: Float -> [Char] -> [Char]
markParityBitPositions' _ [] = []
markParityBitPositions' index (head:tail)
    | isPowerOfTwo (round position) = ['*'] ++ markParityBitPositions' (index + 1) (head:tail)
    | otherwise = [head] ++ markParityBitPositions' (index + 1) tail
    where position = index + 1

writeParityBit :: Int -> [Char] -> [Char]
writeParityBit exponent code = replaceNthElement position parityBit code
    where parityBit = calculateParityBit exponent code
          position = 2 ^ exponent - 1

calculateParityBit :: Int -> [Char] -> Char
calculateParityBit exponent code
    | (countOnes (getBitsToBeChecked code exponent) `mod` 2 == 0) = '0'
    | otherwise = '1'
