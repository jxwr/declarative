import Control.Monad (foldM, foldM_, sequence, sequence_)

-- ;; foldM  :: (Monad m, Foldable t) => (b -> a -> m b) -> b -> t a -> m b
-- ;; foldM_ :: (Monad m, Foldable t) => (b -> a -> m b) -> b -> t a -> m ()
-- ;; sequence  :: (Traversable t, Monad m) => t (m a) -> m (t a)
-- ;; sequence_ :: (Foldable t, Monad m) => t (m a) -> m ()

printAndConcat b a = do
  print b
  return $ show a ++ b

main = do
  foldM  printAndConcat "" [1..10] >>= print -- "10987654321"，fold的结果
  foldM_ printAndConcat "" [1..10]

  -- 执行一组Monad，返回包含一组值的Monad
  sequence  [putStrLn "a", putStrLn "b"] >>= print -- [(),()]，即(t a)
  sequence_ [putStrLn "a", putStrLn "b"]

  print $ sequence  [Just 10, Just 20] -- Just [10, 20]
  print $ sequence_ [Just 10, Just 20] -- Just ()
