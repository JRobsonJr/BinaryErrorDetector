module CRC where

detectErrorCRC :: [Char] -> [Char] -> Bool
detectErrorCRC code generator = not $ null $ divisionRemainder code generator

divisionRemainder :: [Char] -> [Char] -> [Char]
divisionRemainder ('0':tail) dividend = divisionRemainder tail dividend
divisionRemainder divider dividend 
    | dividendLength > dividerLength = divider
    | otherwise = divisionRemainder tail' dividend
    where dividerLength = length divider
          dividendLength = length dividend
          divider' = bitwiseXor divider extendedDividend
          extendedDividend = zeroExtend dividerLength dividend
          (_:tail') = divider'

bitwiseXor :: [Char] -> [Char] -> [Char]
bitwiseXor [] [] = []
bitwiseXor (head1 : tail1) (head2 : tail2) = (xor head1 head2 : bitwiseXor tail1 tail2)

xor :: Char -> Char -> Char
xor '0' '0' = '0'
xor '1' '1' = '0'
xor _ _ = '1'

zeroExtend :: Int -> [Char] -> [Char]
zeroExtend size code
    | (length code >= size) = code
    | otherwise = zeroExtend size (code ++ ['0'])