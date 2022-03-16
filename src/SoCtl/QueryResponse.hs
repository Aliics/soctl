{-# LANGUAGE DeriveGeneric #-}

module SoCtl.QueryResponse
    ( queryResp
    , QueryResponse (..)
    ) where

import Data.Aeson
import GHC.Generics

data QueryResponse = QueryResponse Int [String] deriving (Eq, Show)

newtype SoItem = SoItem
  { title :: String
  } deriving (Show, Generic)

newtype SoResponse = SoResponse
  { items :: [SoItem] 
  } deriving (Show, Generic)

instance FromJSON SoResponse
instance FromJSON SoItem

queryResp :: Maybe SoResponse -> QueryResponse
queryResp Nothing = QueryResponse 0 []
queryResp (Just SoResponse{items=items}) =
  QueryResponse (length items) (map title items)
