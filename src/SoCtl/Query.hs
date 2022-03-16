module SoCtl.Query
    ( query
    , queryProg
    , QueryResponse (..)
    ) where
data QueryResponse = QueryResponse Int [String] deriving (Eq, Show)

query :: [String] -> IO QueryResponse
query _ = pure (QueryResponse 0 [])

-- Run the query function as a "prog". This means to simply output the result.
-- A shorthand to displaying the result in a nice format.
queryProg :: [String] -> IO ()
queryProg ss = do
  (QueryResponse _ os) <- query ss
  mapM_ putStrLn os 
