{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Question.Types
    ( Question (..)
    , questionFromObject
    , questionFromItemsObject
    ) where
import Data.Aeson
import Network.HTTP.Query
import Data.Maybe (mapMaybe, maybeToList)

data Question = Question Int String deriving Eq

instance Show Question where
  show (Question n s) = show n ++ ") " ++ s

questionFromItemsObject :: Object -> [Question]
questionFromItemsObject o = do
  is <- maybeToList (lookupKey "items" o :: Maybe [Object])
  mapMaybe questionFromObject is

questionFromObject :: Object -> Maybe Question
questionFromObject o = do
  id <- lookupKey "question_id" o :: Maybe Int
  title <- lookupKey "title" o :: Maybe String
  pure $ Question id title
