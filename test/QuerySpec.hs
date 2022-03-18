module QuerySpec
    ( spec
    ) where
import Test.Hspec
import SoCtl.Query
import SoCtl.QueryResponse

spec :: Spec
spec =
  describe "Query.query" $ do
    it "can query haskell questions" $ do
      (QueryResponse n qs) <- getQueryResp ["--lang", "haskell"]
      n `shouldBe` 30 -- Each "page" will be 30 in length max.
      map show qs `shouldSatisfy` not . any null -- No empty titles.
    it "gibberish returns nothing" $ do
      qr <- getQueryResp ["--lang", "abdefghijklmnopqrstuvwxyz1234567890"]
      qr `shouldBe` QueryResponse 0 []
