module Formatter
( checkString
, format
) where

import Data.List (foldl', foldl1', intercalate, genericLength, delete)
import qualified Data.Char as Char

format :: String -> String
format = format' . clean

format' :: String -> String
format' xs = '[' : intercalate "," lines' ++ "]"
  where prepareLine = map (\x -> if x == ' ' then ',' else x) 
        lines' = map (\ line -> '[' : prepareLine line ++ "]") $ lines xs

checkString :: String -> Bool
checkString = foldr (\x r -> if not $ Char.isDigit x || Char.isSpace x || x == '.' || x == '-' then False else r) True

clean :: String -> String
clean = unlines . map (unwords . map cleanPiece . words) . lines
  where cleanOuterDots xs = iterate (reverse . dropWhile (=='.')) xs !! 2
        cleanDots xs = let xs' = cleanOuterDots xs
                           dots = amountOf '.' xs'
                        in if dots > 1 then delete' '.' (dots - 1) xs' else xs'
        cleanPiece xs = let xs' = cleanDots xs
                            minus = amountOf '-' xs'
                     in case minus of 0 -> xs'
                                      1 -> if xs'!!0 == '-' then xs' else delete '-' xs'
                                      _ -> delete' '-' minus xs'
                     
amountOf :: (Num a) => Char -> String -> a
amountOf c = genericLength . filter (== c)

delete' :: (Eq a) => a -> Int -> [a] -> [a]
delete'  x c xs = iterate (delete x) xs !! c
