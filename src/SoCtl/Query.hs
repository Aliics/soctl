{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Query
    ( query
    , getQueryResp
    ) where
import SoCtl.Args (argByName)
import SoCtl.QueryResponse
import SoCtl.Query.Constants (rootUri)
import Network.HTTP.Query
import Data.Maybe (maybeToList)

searchUri :: (String, Query)
searchUri = 
  (uri, keys)
  where 
    uri = rootUri +/+ "search/advanced"
    keys = 
      [ makeItem "site" "stackoverflow"
      , makeItem "order" "desc"
      , makeItem "sort" "activity"
      ]

-- Query the StackExchange api pointing to StackOverflow.
-- Using the first argument as the language to query against.
getQueryResp :: [String] -> IO QueryResponse
getQueryResp as = do
  let uri = fst searchUri
      maybeLang = makeItem "tagged" <$> argByName "lang" as
      keys = snd searchUri ++ maybeToList maybeLang
  res <- webAPIQuery uri keys
  pure $ queryResp res
    
-- Run the query function as a "prog". This means to simply output the result.
-- A shorthand to displaying the result in a nice format.
query :: [String] -> IO ()
query as = do
  (QueryResponse _ os) <- getQueryResp as
  mapM_ putStrLn os
