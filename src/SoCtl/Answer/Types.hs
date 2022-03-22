{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Answer.Types
  ( Answer
  , answersFromItemsObject
  ) where

import           Data.Aeson         (Object)
import           Data.Maybe         (mapMaybe, maybeToList)
import           Network.HTTP.Query (lookupKey)

type Answer = String

answersFromItemsObject :: Object -> [Answer]
answersFromItemsObject o = do
  is <- maybeToList (lookupKey "items" o :: Maybe [Object])
  mapMaybe answerFromObject is

answerFromObject :: Object -> Maybe Answer
answerFromObject o = do
  lookupKey "body" o :: Maybe Answer
