module SoCtl.SearchSpec
    ( spec
    ) where
import           SoCtl.Search
import           Test.Hspec

spec :: Spec
spec =
  describe "getSearchResp" $ do
    it "can query haskell questions" $ do
      qs  <- getSearchResp ["--lang", "haskell"]
      length qs `shouldBe` 30 -- Each "page" will be 30 in length max.
      map show qs `shouldSatisfy` not . any null -- No empty titles.
    it "gibberish returns nothing" $ do
      qr <- getSearchResp ["--lang", "abdefghijklmnopqrstuvwxyz1234567890"]
      qr `shouldBe` []
