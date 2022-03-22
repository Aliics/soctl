module SoCtl
  ( subProg,) where

import qualified Data.Map.Lazy      as Map
import           SoCtl.Help         (help)
import           SoCtl.Question     (question)
import           SoCtl.Search       (search)
import           System.Environment (getArgs)

progs :: Map.Map String ([String] -> IO ())
progs =
  Map.fromList
    [ ("help", help),
      ("search", search),
      ("question", question)
    ]

subProg :: IO ()
subProg = getArgs >>= callProg

-- Determine the "prog" to invoke.
callProg :: [String] -> IO ()
callProg [] = help []
callProg as = do
  let prog = head as
      maybeProg = Map.lookup prog progs
  case maybeProg of
    Just a -> a $ tail as
    Nothing -> do
      putStrLn $ prog ++ " is not a command.\n"
      callProg []
