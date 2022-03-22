module SoCtl.Args
    ( argByName
    ) where
import           Data.List (elemIndex)

argByName :: String -> [String] -> Maybe String
argByName _ [] = Nothing
argByName a as =
  case elemIndex ("--" ++ a) as of
    Nothing -> Nothing
    Just i ->
      if length as > i + 1 then
        Just (as !! (i + 1))
      else Nothing
