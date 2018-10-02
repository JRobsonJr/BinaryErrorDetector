# BinaryErrorDetector

This project aims to provide users different strategies for detecting and correcting errors in a single bit in transmissions. 
Observe that, as it is implemented in Haskell, I suggest you to use the GHCi (GHC's interactive environment) installed.

First of all, run `ghci` and then load the main file (`:load Main.hs`). This will let you use functions implemented in all files contained in this project.

### Detecting simple parity bit errors

Run `detectParityError <parity> <code>`, where `<parity>` is either `'E'` (if you are considering an even parity) or `'O'` (if you are considering an odd parity) and `<code>` is the code word you wish to test. The answer given is `True` if there is an error and `False` otherwise.

For example: 
- `detectParityError 'E' "10101011"` returns `True` (there is an error), because the number of ones is odd,
- `detectParityError 'O' "10101011"` returns `False` (no error found) for the same reason stated.

### Using the Hamming code to detect errors

Run `detectErrorHC <code>`, where `<code>` is the code word you wish to test. The answer given is `True` if there is an error and `False` otherwise.

For example: 
- `detectErrorHC "011100101110"` returns `True` (there is an error), because the parity bits located in the second and eigth positions are wrong,
- `detectParityError "011100101010"` returns `False` (no error found), because all parity bits are consistent.

### Using the Hamming code to correct errors

Run `correctErrorHC <code>`, where `<code>` is the code word you wish to correct. The answer given is the corrected code word; if there was no error to begin with, the answer will be the same code word used as parameter.

For example: 
- `correctErrorHC "011100101110"` returns "011100101010", as the Hamming code determined that the twelveth bit that was inconsistent;
- `correctErrorHC "011100101010"` returns "011100101010", as no error was detected.

### Using CRC to detect errors

Run `detectErrorCRC <code> <generator>`, where `<code>` is the code word you wish to test and `<generator>` was the generator polynomial used. The answer given is `True` if there is an error (the remainder of the division was not 0) and `False` otherwise.

For example: 
- `detectErrorCRC "10001110" "1100"` returns `True`, as the remainder of the division is not 0 (it is "101", and you can check it by running `divisionRemainder  "10001110" "1100"`);
- `detectErrorCRC "11011101" "1101"` returns `False`, as no error was detected (the remainder of the division is zero, and you can check it by running `divisionRemainder  "11011101" "1101"`; the result should be "").
