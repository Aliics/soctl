module SoCtl.SearchSpec
    ( spec
    ) where
import Test.Hspec
import SoCtl.Search
import SoCtl.Query.Response

spec :: Spec
spec =
  describe "getSearchResp" $ do
    it "can query haskell questions" $ do
      (Response n qs) <- getSearchResp ["--lang", "haskell"]
      n `shouldBe` 30 -- Each "page" will be 30 in length max.
      map show qs `shouldSatisfy` not . any null -- No empty titles.
    it "gibberish returns nothing" $ do
      qr <- getSearchResp ["--lang", "abdefghijklmnopqrstuvwxyz1234567890"]
      qr `shouldBe` Response 0 []
