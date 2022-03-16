module QuerySpec
    ( spec
    ) where
import Test.Hspec
import SoCtl.Query

spec :: Spec
spec =
  describe "Query.query" $ do
    it "can query haskell questions" $ do
      x <- query ["--lang", "haskell"]
      x `shouldBe` QueryResponse 0 []
