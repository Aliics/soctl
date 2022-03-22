{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Question.Types
    ( Question (..)
    , questionsFromItemsObject
    ) where
import           Data.Aeson         (Object)
import           Data.Maybe         (mapMaybe, maybeToList)
import           Network.HTTP.Query (lookupKey)

data Question = Question Int String deriving Eq

instance Show Question where
  show (Question n s) = show n ++ ") " ++ s

questionsFromItemsObject :: Object -> [Question]
questionsFromItemsObject o = do
  is <- maybeToList (lookupKey "items" o :: Maybe [Object])
  mapMaybe questionFromObject is

questionFromObject :: Object -> Maybe Question
questionFromObject o = do
  id <- lookupKey "question_id" o :: Maybe Int
  title <- lookupKey "title" o :: Maybe String
  pure $ Question id title
