module SoCtl 
    ( subProg
    ) where

import SoCtl.Help (help)
import SoCtl.Search (search)
import SoCtl.Question (question)
import qualified Data.Map.Lazy as Map
import System.Environment (getArgs)

progs :: Map.Map String ([String] -> IO ())
progs = Map.fromList 
    [ ("help", help)
    , ("search", search)
    , ("question", question)
    ]

subProg :: IO ()
subProg = getArgs >>= callProg

-- Determine the "prog" to invoke.
callProg :: [String] -> IO ()
callProg [] = help []
callProg as = do
  let prog = head as
  mapM_ (\x -> x $ tail as) (Map.lookup prog progs)
