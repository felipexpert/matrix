module Message where

import Data.List (intercalate)

type Matrix = String
type Task = String
type Result = String
type Rows = String
type Columns = String
type Error = String
type Info = String

dimension :: Rows -> Columns -> Info
dimension l c = "Dimension: " ++ l ++ " row" ++ suffix l' ++ " and " ++ c ++ " column" ++ suffix c'
  where l' = read l
        c' = read c
        suffix n = if n /= 1 then "s" else ""

invalidMatrix :: Error
invalidMatrix = "Invalid matrix"

invalidMatrix' :: Matrix -> Error
invalidMatrix' m = "Invalid matrix: " ++ m

invalidInput :: Error
invalidInput = "Invalid input"

diffDimension :: Error
diffDimension = "The given matrixes aren't of same dimension"

notQuadratic :: Error
notQuadratic = "The given matrix is not quadratic"

emptyError :: Error
emptyError = "Matrix cannot be empty"

dimensionMatchError :: Error
dimensionMatchError = "Dimensions don't match"

calculating :: Task -> [Matrix] -> Info
calculating t [x] = "Calculating " ++ t ++ " for the following input...\n" ++ x
calculating t xs = "Calculating " ++ t ++ " for the following inputs...\n" ++ unlines xs

success :: Task -> Result -> Info
success t r = "The " ++ t ++ " from the given matrix is: " ++ r

determinant :: Task
determinant = "determinant"

welcome :: Info
welcome = "Welcome to the Ultra Power Matrix Utilities"

menu :: Info
menu = "1 - Get dimension from a matrix\n"
    ++ "2 - Add two matrixes\n"
    ++ "3 - Subtract two matrixes\n"
    ++ "4 - Multiply matrix with a scalar\n"
    ++ "5 - Devide matrix with a scalar\n"
    ++ "6 - Transpose matrix\n"
    ++ "7 - Multiply matrixes\n"
    ++ "8 - Calc matrix determinant\n"
    ++ "0 - Exit\n"

insertMatrix :: Info
insertMatrix = "Insert matrix"

insertScalar :: Info
insertScalar = "Insert scalar"

mistake :: Error -> Error
mistake xs = "Mistake: " ++ xs

result :: Result -> Task
result xs = "Result: " ++ xs

dimension' :: Task
dimension' = "dimension"

plus :: Task
plus = "plus"

minus :: Task
minus = "minus"

scalarMult :: Task
scalarMult = "scalar multiplication"

scalarDiv :: Task
scalarDiv = "scalar division"

transpose :: Task
transpose = "transpose"

mult :: Task
mult = "multiply"

determinant' :: Task
determinant' = "determinant"

untilNextTime :: Info
untilNextTime = "Until next time"
