module SoCtl.Question 
    ( question
    , getQuestionResp
    ) where
import Network.HTTP.Query
import SoCtl.Query.Constants (rootUri)
import SoCtl.Query (queryUri)
import SoCtl.Query.Response

getQuestionResp :: [String] -> IO Response
getQuestionResp as = do
  let qu = queryUri $ "questions" +/+ head as
  res <- uncurry webAPIQuery qu
  pure $ queryResp res

question :: [String] -> IO ()
question as = do
  (Response _ (q:_)) <- getQuestionResp as
  print q
