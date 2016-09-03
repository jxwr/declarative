
addap :: (Int -> Int) -> Int -> Int
addap f x = x + (f x)

addap_cps :: (Int -> ((Int -> r) -> r)) -> Int -> (Int -> r) -> r
addap_cps f_cps x k = f_cps x $ \fx -> k $ x + fx

index :: Eq a => [a] -> a -> Int
index [] _ = -1
index (x:xs) a
  | x == a = 0
  | otherwise =
      let n = index xs a
      in if n >= 0
         then n + 1
         else -1

index_cps :: Eq a => [a] -> a -> (Int -> r) -> r
index_cps [] _ k = k (-1 :: Int)
index_cps (x:xs) a k
  | x == a = k 0
  | otherwise =
      let n = index xs a
      in if n >= 0
         then k (n + 1)
         else k (-1 :: Int)

main = do
  putStrLn "---- addap ----"
  
  addap_cps (\x -> (\k -> k (x * 2))) 10 print
  -- 等价于
  print $ addap_cps (\x -> (\k -> k (x * 2))) 10 id
  print $ addap_cps (\x -> (\k -> k (x * 2))) 10 (+ 2)

  putStrLn "---- index ----"
  
  print $ index [1,2,3,4] 3
  print $ index [] 3
  print $ index [1,2] 3
  print $ index [3,1] 3
  print $ index [1,3] 3
  print $ map (index ['a'..'z']) ['a'..'z']
  
  index_cps [1,2,3,4] 3 print
  print $ map (\x -> index_cps ['a'..'z'] x id) ['a'..'z']

  -- mapM_ :: (Monad m, Foldable t) => (a -> m b) -> t a -> m ()
  mapM_ (\x -> index_cps ['a'..'z'] x (putStr . show)) ['a'..'z']
  traverse (\x -> index_cps ['a'..'z'] x (putStr . show)) ['a'..'z']
