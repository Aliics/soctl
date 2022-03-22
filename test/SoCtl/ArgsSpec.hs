module SoCtl.ArgsSpec
    ( spec
    ) where
import           Data.Maybe
import           SoCtl.Args (argByName)
import           Test.Hspec

spec :: Spec
spec =
  describe "argByName" $ do
    it "can find argument when alone" $ do
      let x = fromJust $ argByName "arg1" ["--arg1", "foo"]
      x `shouldBe` "foo"
    it "can find argument among many" $ do
      let x = fromJust $ argByName "arg3"
            [ "--arg1", "bar"
            , "--arg2", "baz"
            , "--arg3", "qux"
            ]
      x `shouldBe` "qux"

    it "cannot find missing argument" $ do
      let x = argByName "arg1" ["--arg2", "lol"]
      x `shouldSatisfy` isNothing

    it "cannot find argument with no args" $ do
      let x = argByName "arg" []
      x `shouldSatisfy` isNothing

    it "cannot find argument with one arg" $ do
      let x = argByName "arg" ["arg1"]
      x `shouldSatisfy` isNothing
