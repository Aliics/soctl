{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}

module SoCtl.QueryResponse
    ( queryResp
    , QueryResponse (..)
    ) where

import SoCtl.Question
import Data.Aeson
import GHC.Generics

data QueryResponse = QueryResponse Int [Question] deriving (Eq, Show)

-- SoItem is a record representing StackOverflow JSON items.
data SoItem = SoItem
  { questionId :: Int
  , title :: String
  } deriving (Show)

instance FromJSON SoItem where
  parseJSON (Object o) =
    SoItem <$> o .: "question_id"
           <*> o .: "title"
  parseJSON _ = mempty

fromSoItem :: SoItem -> Question
fromSoItem i = Question (questionId i) (title i)

-- SoResponse is a record representing query responses from StackOverflow.
newtype SoResponse = SoResponse
  { items :: [SoItem] 
  } deriving (Show, Generic)

instance FromJSON SoResponse

queryResp :: Maybe SoResponse -> QueryResponse
queryResp Nothing = QueryResponse 0 []
queryResp (Just SoResponse{items=items}) =
  QueryResponse (length items) (map fromSoItem items)
