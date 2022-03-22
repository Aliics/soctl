{-# LANGUAGE OverloadedStrings #-}

module SoCtl.Question
    ( question
    , getQuestionResp
    ) where
import           Data.Aeson            (Object)
import           Data.Maybe            (listToMaybe)
import           Network.HTTP.Query    (webAPIQuery, (+/+))
import           SoCtl.Answer.Types    (Answer, answersFromItemsObject)
import           SoCtl.Query           (queryUri)
import           SoCtl.Query.Constants (rootUri)
import           SoCtl.Question.Types  (Question, questionsFromItemsObject)

getQuestionResp :: [String] -> IO (Maybe (Question, [Answer]))
getQuestionResp as = do
  let uri = "questions" +/+ head as
  questionRes <- uncurry webAPIQuery (queryUri uri)
  answersRes <- uncurry webAPIQuery (queryUri $ uri +/+ "answers")
  pure $ mapRes questionRes answersRes

mapRes :: Object -> Object -> Maybe (Question, [Answer])
mapRes questionRes answersRes = do
  qs <- listToMaybe $ questionsFromItemsObject questionRes
  let as = answersFromItemsObject answersRes
  Just (qs, as)

question :: [String] -> IO ()
question as = do
  resp <- getQuestionResp as
  case resp of
    Just q  -> print q
    Nothing -> putStrLn "Question not found"
