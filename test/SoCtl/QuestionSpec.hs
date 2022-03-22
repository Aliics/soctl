module SoCtl.QuestionSpec
    ( spec
    ) where
import           SoCtl.Question
import           SoCtl.Question.Types
import           Test.Hspec

spec :: Spec
spec = do
  describe "Types.Question.show" $ do
    it "can show a question" $ do
      let q = Question 123 "How do you use Haskell?"
      show q `shouldBe` "123) How do you use Haskell?"

  describe "getQuestionResp" $ do
    it "can query a question" $ do
      qs <- getQuestionResp ["44965"]
      qs `shouldBe` Just (Question 44965 "What is a monad?", [])
