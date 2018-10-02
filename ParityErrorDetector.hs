module ParityErrorDetector where

import System.IO
import Util

-- Detect parity error in a code word depending on the parity that is adopted
-- (odd or even). Returns True if there is an error, False otherwise.
detectParityError :: Char -> [Char] -> Bool
detectParityError 'E' code = detectErrorEvenParity code
detectParityError 'O' code = detectErrorOddParity code

detectErrorEvenParity :: [Char] -> Bool
detectErrorEvenParity code = (countOnes code `mod` 2 /= 0)

detectErrorOddParity :: [Char] -> Bool
detectErrorOddParity code = (countOnes code `mod` 2 == 0)