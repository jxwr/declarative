module Main where

import Control.Monad.Trans.Reader
import Control.Monad.Trans.State
import Control.Monad.Trans.Class

data Config = CVal Int

modInt :: Int -> StateT (Int, Int) (ReaderT Config IO) ()
modInt n = do
  CVal m <- lift ask
  (_, r) <- get
  put (n `mod` m, r)

modString :: String -> StateT (Int, Int) (ReaderT Config IO) ()
modString s = do
  let n = read s :: Int
  CVal m <- lift ask
  (l, _) <- get
  put (l, n `mod` m)

modAdd :: (Int, String) -> StateT (Int, Int) (ReaderT Config IO) Int
modAdd (n, s) = do
  CVal m <- lift ask
  modInt n
  modString s
  (r0, r1) <- get
  return $ r0 + r1

main :: IO ()
main = do
  v <- runReaderT (evalStateT (modAdd (10, "12")) (0, 0)) (CVal 7)
  putStrLn $ show v
