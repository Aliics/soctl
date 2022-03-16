module SoCtl 
    ( subprog
    ) where

import SoCtl.Help
import SoCtl.Query
import qualified Data.Map.Lazy as Map
import System.Environment (getArgs)

progs :: Map.Map String ([String] -> IO ())
progs = Map.fromList 
    [ ("help", help)
    , ("query", queryProg)
    ]

subprog :: IO ()
subprog = do
  as <- getArgs
  let prog = head as
  mapM_ (\x -> x $ tail as) (Map.lookup prog progs)
