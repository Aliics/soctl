{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Search
    ( search
    , getSearchResp
    ) where
import SoCtl.Args (argByName)
import SoCtl.Query (queryUri)
import SoCtl.Query.Constants (rootUri)
import SoCtl.Query.Response
import Network.HTTP.Query
import Data.Maybe (maybeToList)

-- Query the StackExchange api pointing to StackOverflow.
-- Using the first argument as the language to search against.
getSearchResp :: [String] -> IO Response
getSearchResp as = do
  let qu = queryUri "search/advanced"
      uri = fst qu 
      maybeLang = makeItem "tagged" <$> argByName "lang" as
      keys = snd qu ++ maybeToList maybeLang
  res <- webAPIQuery uri keys
  pure $ queryResp res
    
-- Run the search function as a "prog". This means to simply output the result.
-- A shorthand to displaying the result in a nice format.
search :: [String] -> IO ()
search as = do
  (Response _ qs) <- getSearchResp as
  mapM_ print qs