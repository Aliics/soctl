module SoCtl.Question 
    ( Question (..)
    ) where

data Question = Question Int String deriving Eq

instance Show Question where
  show (Question n s) = show n ++ ") " ++ s
