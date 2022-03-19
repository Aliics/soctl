module SoCtl.Query
    ( queryUri
    ) where
import SoCtl.Query.Constants
import Network.HTTP.Query

queryUri :: String -> (String, Query)
queryUri p = 
  (uri, keys)
  where 
    uri = rootUri +/+ p
    keys = 
      [ makeItem "site" "stackoverflow"
      , makeItem "order" "desc"
      , makeItem "sort" "activity"
      ]
