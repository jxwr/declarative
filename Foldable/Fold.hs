-- ;; 累积函数的参数顺序不同
-- ;; 第2个参数是初始值, 初始值与累计值类型相同
-- ;; foldr参数从左向右喂, foldl参数从右向左喂

-- ;; foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- ;; foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b

-- Example1:
k a b = (show a) ++ b

test_foldk = foldr k "" [1,2,3]
-- = k 1 (foldr k "" [2,3]
-- = k 1 (k 2 (foldr k "" [3]))
-- = k 1 (k 2 (k 3 (foldr k "" [])))
-- = k 1 (k 2 (k 3 ""))
-- = k 1 (k 2 "3")
-- = k 1 "23"
-- = "123"

-- Example2:
f b a = (show a) ++ b

test_foldf = foldl f "" [1,2,3]
-- = f (foldl f "" [1,2]) 3
-- = f (f (foldr f "" [1]) 2) 3
-- = f (f (f (foldr "" []) 1) 2) 3
-- = f (f (f "" 1) 2) 3
-- = f (f (f "" 1) 2) 3
-- = f (f "1" 2) 3
-- = f "21" 3
-- = "321"

-- Example3:
test_foldr = 
  foldr (\a accu -> let accu' = (show a) ++ accu in accu') "" [1 .. 5]

-- Example4:
test_foldl = 
  foldl (\accu a -> let accu' = (show a) ++ accu in accu') "" [1 .. 5]

-- Example5:
test_foldl2 = 
  foldl (\accu a -> let accu' = accu ++ (show a) in accu') "" [1 .. 5]

main = do
  print test_foldk   -- "123"
  print test_foldf   -- "321"
  print test_foldr   -- "12345"
  print test_foldl   -- "54321"
  print test_foldl2  -- "12345"
  
