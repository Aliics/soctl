{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Question 
    ( question
    , getQuestionResp
    ) where
import Data.Aeson
import Data.Maybe
import Network.HTTP.Query
import SoCtl.Query.Constants (rootUri)
import SoCtl.Query (queryUri)
import SoCtl.Question.Types

getQuestionResp :: [String] -> IO (Maybe Question)
getQuestionResp as = do
  let uri = "questions" +/+ head as
      qu = queryUri uri
  res <- uncurry webAPIQuery qu
  pure $ listToMaybe $ questionFromItemsObject res

question :: [String] -> IO ()
question as = do
  resp <- getQuestionResp as
  case resp of
    Just q -> print q
    Nothing -> putStrLn "Question not found"
