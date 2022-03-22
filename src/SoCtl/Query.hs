module SoCtl.Query
    ( queryUri
    ) where
import           Network.HTTP.Query    (Query, makeItem, (+/+))
import           SoCtl.Query.Constants (rootUri)

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
