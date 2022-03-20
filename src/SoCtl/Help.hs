module SoCtl.Help
    ( help
    ) where

(\/) :: String -> String -> String
a \/ b = a ++ "\n" ++ b

help :: [String] -> IO ()
help _ = putStrLn $
  "soctl help page" \/
  "========================================================================" \/
  " - help     :: Shows this help message" \/
  " - search   :: Search tool for general question searching" \/
  " - question :: Look at questions and answers"
