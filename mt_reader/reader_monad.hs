module Main where

import Control.Monad.Trans.Reader

data Config = CVal Int

modInt :: Int -> Reader Config Int
modInt n = do
  CVal m <- ask
  return $ n `mod` m

modString :: String -> Reader Config Int
modString s = do
  let n = read s :: Int
  CVal m <- ask
  return $ n `mod` m

modAdd :: (Int, String) -> Reader Config Int
modAdd (n, s) = do
  r0 <- modInt n
  r1 <- modString s
  return $ r0 + r1

main :: IO ()
main = do
  let v = runReader (modAdd (10, "12")) (CVal 7)
  putStrLn $ show v
