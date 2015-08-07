import Matrix
import Formatter
import qualified Message as M
import qualified Data.List as List
import Text.Read (readMaybe)

main = do
  putStrLn M.welcome
  putChar '\n'
  loop

loop :: IO ()
loop = do
  putStrLn M.menu
  op <- getLine
  case op of 
    "1" -> do 
      mtx <- takeMatrix
      loop' M.dimension' [mtx] $ dimension mtx
    "2" -> do
      mtx1 <- takeMatrix
      mtx2 <- takeMatrix
      loop' M.plus [mtx1,mtx2] $ plus mtx1 mtx2
    "3" -> do
      mtx1 <- takeMatrix
      mtx2 <- takeMatrix
      loop' M.minus [mtx1,mtx2] $ minus mtx1 mtx2
    "4" -> do
      scalar <- takeScalar
      mtx <- takeMatrix
      loop' M.scalarMult [mtx] $ scalarMult scalar mtx 
    "5" -> do
      scalar <- takeScalar
      mtx <- takeMatrix
      loop' M.scalarDiv [mtx] $ scalarDiv scalar mtx 
    "6" -> do
      mtx <- takeMatrix
      loop' M.transpose [mtx] $ transpose mtx
    "7" -> do
      mtx1 <- takeMatrix
      mtx2 <- takeMatrix
      loop' M.mult [mtx1,mtx2] $ mult mtx1 mtx2
    "8" -> do
      mtx <- takeMatrix
      loop' M.determinant' [mtx] $ determinant mtx
    "0" -> do
      putStrLn M.untilNextTime
      return ()
    _ -> do
      putStrLn M.invalidInput
      loop

loop' :: (Show a) => String -> [Matrix] -> Either String a -> IO ()
loop' task xs either = do
  putStrLn $ M.calculating task $ map show xs
  case either of 
    (Left xs) -> do
      putStrLn $ M.mistake xs
      putChar '\n'
      loop
    (Right a) -> do
      print $ M.result $ show a
      putChar '\n'
      loop

takeScalar :: IO Float
takeScalar = do
  putStrLn M.insertScalar
  line <- getLine
  let l = readMaybe line :: Maybe Float
  case l of 
    (Nothing) -> do 
      putStrLn M.invalidInput
      takeScalar
    (Just x) -> return x

takeMatrix :: IO Matrix
takeMatrix = do
  putStrLn M.insertMatrix
  xxs <- getLines
  let xs = List.unlines xxs
  if checkString xs
    then return (read . format $ xs)
    else do
      putStrLn M.invalidInput
      takeMatrix

getLines :: IO [String]
getLines = do
  s <- getLine
  if(s == "") 
    then return []
    else do
      xs <- getLines
      return $ s : xs
