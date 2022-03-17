{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Query
    ( query
    , queryProg
    ) where
import SoCtl.QueryResponse
import Network.HTTP.Query
import SoCtl.Args (argByName)
import Data.Maybe (maybeToList)

rootUri :: String
rootUri = "https://api.stackexchange.com/2.3"

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
query :: [String] -> IO QueryResponse
query as = do
  let uri = fst searchUri
      maybeLang = fmap (makeItem "tagged") (argByName "lang" as)
      keys = snd searchUri ++ maybeToList maybeLang
  res <- webAPIQuery uri keys
  pure $ queryResp res
    
-- Run the query function as a "prog". This means to simply output the result.
-- A shorthand to displaying the result in a nice format.
queryProg :: [String] -> IO ()
queryProg as = do
  (QueryResponse _ os) <- query as
  mapM_ putStrLn os
