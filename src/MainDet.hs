import Matrix
import Formatter
import qualified Message as M

main = do
  contents <- getContents
  if checkString contents
    then do 
      let formatted = format contents
          result = determinant $ read formatted
      putStrLn $ M.calculating M.determinant [formatted]
      case result of Left x -> putStrLn x
                     Right x -> putStrLn $ M.success M.determinant (show x)
    else putStrLn M.invalidInput
