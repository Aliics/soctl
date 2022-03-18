module QuestionSpec
    ( spec
    ) where
import SoCtl.Question
import Test.Hspec

spec :: Spec
spec =
  describe "Question.show" $ do
    it "can show a question" $ do
      let q = Question 123 "How do you use Haskell?"
      show q `shouldBe` "123) How do you use Haskell?"
