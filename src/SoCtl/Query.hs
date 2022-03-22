module SoCtl.Query
    ( queryUri
    ) where
import           Network.HTTP.Query
import           SoCtl.Query.Constants

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
