module Main where

import Control.Monad.Trans.Reader

data Config = CVal Int

modInt :: Int -> ReaderT Config IO Int
modInt n = do
  CVal m <- ask
  return $ n `mod` m

modString :: String -> ReaderT Config IO Int
modString s = do
  let n = read s :: Int
  CVal m <- ask
  return $ n `mod` m

modAdd :: (Int, String) -> ReaderT Config IO Int
modAdd (n, s) = do
  r0 <- modInt n
  r1 <- modString s
  return $ r0 + r1

main :: IO ()
main = do
  v <- runReaderT (modAdd (10, "12")) (CVal 7)
  putStrLn $ show v
