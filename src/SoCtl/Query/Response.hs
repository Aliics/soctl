{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}

module SoCtl.Query.Response
    ( queryResp
    , Response (..)
    ) where

import SoCtl.Question
import Data.Aeson
import GHC.Generics

data Response = Response Int [Question] deriving (Eq, Show)

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

queryResp :: Maybe SoResponse -> Response
queryResp Nothing = Response 0 []
queryResp (Just SoResponse{items=items}) =
  Response (length items) (map fromSoItem items)
