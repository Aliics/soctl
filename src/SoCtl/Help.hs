module SoCtl.Help
    ( help
    ) where

(\/) :: String -> String -> String
a \/ b = a ++ "\n" ++ b

help :: [String] -> IO ()
help _ = putStrLn $
  "soctl help page" \/
  "========================================================================" \/
  " - help  :: Shows this help message" \/
  " - query :: Query tool for generate query searching"
