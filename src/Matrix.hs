module Matrix
( Row
, Matrix
, Dimension(..)
, dimension
, isValid
, isQuadratic
, plus
, minus
, scalarMult
, scalarDiv
, transpose
, mult
, determinant
) where

import Data.List (foldl', foldl1', genericLength)
import qualified Message as M

type Row = [Float]
type Matrix = [Row] 

data Dimension = Dimension {rows :: Int, columns :: Int} deriving Eq

instance Show Dimension where
  show (Dimension {rows = l, columns = c}) = M.dimension (show l) (show c)

dimension :: Matrix -> Either String Dimension
dimension xxs
  | not . isValid $ xxs = Left M.invalidMatrix
  | otherwise = Right $ dimension' xxs

isValid :: Matrix -> Bool
isValid = allTheSame . map length

isQuadratic :: Matrix -> Bool
isQuadratic xxs
  | not . isValid $ xxs = False
  | otherwise = isQuadratic' xxs

plus :: Matrix -> Matrix -> Either String Matrix
plus = zipMatrix (+)

minus :: Matrix -> Matrix -> Either String Matrix
minus = zipMatrix (-)

scalarMult :: Float -> Matrix -> Either String Matrix
scalarMult = scalarZipMatrix (*)

scalarDiv :: Float -> Matrix -> Either String Matrix
scalarDiv = scalarZipMatrix (/)

transpose :: Matrix -> Either String Matrix
transpose xxs
  | not . isValid $ xxs = Left M.invalidMatrix
  | otherwise = Right $ transpose' xxs

mult :: Matrix -> Matrix -> Either String Matrix
mult xxs yys 
  | not . isValid $ xxs = invalidMatrix xxs
  | not . isValid $ yys = invalidMatrix yys
  | isInvalidDimension (dimension' xxs) (dimension' yys) = Left M.dimensionMatchError
  | otherwise = Right $ mult' xxs yys
  where invalidMatrix xxs = Left $ M.invalidMatrix' (show xxs)
        isInvalidDimension (Dimension {columns=c}) (Dimension {rows=l}) = c /= l

determinant :: Matrix -> Either String Float
determinant mtx@(xs:_)
  | not . isValid $ mtx = Left M.invalidMatrix 
  | not . isQuadratic' $ mtx = Left M.notQuadratic
  | otherwise = case xs of [] -> Left M.emptyError
                           _ -> Right $ determinant' $ foldl1' (++) mtx

dimension' :: Matrix -> Dimension
dimension' [] = Dimension {rows=0,columns=0}
dimension' xxs@(xs:_) = Dimension {rows=length xxs, columns=length xs}

sameDimension :: Matrix -> Matrix -> Bool
sameDimension xxs yys = dimension' xxs == dimension' yys

mult' :: Matrix -> Matrix -> Matrix
mult' xxs yys = map line xxs
  where yys' = transpose' yys
        slot xs = foldl' (+) 0 . zipWith (*) xs
        line xs = map (slot xs) yys'

determinant' :: [Float] -> Float
determinant' [x] = x
determinant' xs = foldl1' (+) $ map partialTotal [0 .. columns - 1]
  where length' = genericLength xs
        columns = sqrt' length'
        columnFromIndex = (`mod` columns)
        rowFromIndex = (`div` columns)
        partialTotal i = xs!!i * (-1) ^ (columnFromIndex i + rowFromIndex i) * (determinant' $ complementary xs i)

complementary :: [Float] -> Int -> [Float]
complementary xs i = [xs!!x | x <- [0 .. length' - 1], columnFromIndex x /= iColumn, rowFromIndex x /= iRow]
  where length' = genericLength xs
        columns =  sqrt' length'
        columnFromIndex = (`mod` columns)
        iColumn = columnFromIndex i
        rowFromIndex = (`div` columns)
        iRow = rowFromIndex i

isQuadratic' :: Matrix -> Bool
isQuadratic' all@(xs:_) = length all == length xs

scalarZipMatrix :: (Float -> Float -> Float) -> Float -> Matrix -> Either String Matrix
scalarZipMatrix f x xxs
  | not . isValid $ xxs = Left M.invalidMatrix
  | otherwise = Right $ map (map (`f` x)) xxs


zipMatrix :: (Float -> Float -> Float) -> Matrix -> Matrix -> Either String Matrix
zipMatrix f xxs yys
 | notValid xxs = invalidMatrix xxs
 | notValid yys = invalidMatrix yys
 | sameDimension xxs yys = Right $ zipWith (zipWith f) xxs yys
 | otherwise = Left M.diffDimension 
 where notValid = not . isValid
       invalidMatrix xxs = Left $ M.invalidMatrix' $ show xxs

transpose' :: Matrix -> Matrix
transpose' [] = []
transpose' ([]:xxs) = []
transpose' xxs = [h | (h:_) <- xxs] : transpose' [t | (_:t) <- xxs]

allTheSame :: (Eq a) => [a] -> Bool
allTheSame [] = True
allTheSame (_:[]) = True
allTheSame (x:y:xs)
  | x /= y = False
  | otherwise = allTheSame $ y:xs

sqrt' :: (Num a, Real b) => b -> a
sqrt' = fromIntegral . floor . sqrt . realToFrac
