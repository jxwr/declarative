import Data.Monoid
import Data.Foldable (
  foldr,
  toList,
  sequence_,
  traverse_,
  mapM_,
  length
  )


-- ;; traverse_ :: (Foldable t, Applicative f) => (a -> f b) -> t a -> f ()
-- ;; mapM_     :: (Foldable t, Monad m) => (a -> m b) -> t a -> m ()
-- ;; sequence_ :: (Foldable t, Monad m) => t (m a) -> m ()

data List a = Nil | Cons a (List a)

instance Foldable List where
  -- foldr :: (a -> b -> b) -> b -> List a -> b
  foldr f b Nil = b
  foldr f b (Cons a xs) = f a (foldr f b xs)


data List' a = Nil' | Cons' a (List' a)

instance Monoid (List' a) where
  -- mempty :: a
  mempty = Nil'
  -- mappend :: a -> a -> a
  Nil' `mappend` ys = ys
  (Cons' a xs) `mappend` ys = Cons' a (xs `mappend` ys)

instance Foldable List' where
  -- foldMap :: Monoid m => (a -> m) -> t a -> m
  foldMap f Nil' = mempty
  foldMap f (Cons' a xs) = f a `mappend` foldMap f xs


test_impl xs = do  
  print $ foldr (+) 0 xs
  print $ toList xs
  print $ length xs
  print (sum xs) >> putStrLn "-"

  -- 遍历Foldable，执行某个Action
  traverse_ print xs >> putStrLn "-"
  -- 跟traverse_一样，区别在于返回类型是Applicative还是Monad，就是说traverse_总是可用
  mapM_ print xs >> putStrLn "-"
  -- 依次执行Action组成的Foldable
  sequence_ (Cons (putStrLn "a ") (Cons (putStrLn "b") Nil))
  

main = do
  putStrLn "test_foldr_impl:"
  test_impl (Cons 1 (Cons 2 (Cons 3 Nil)))
  
  putStrLn "test_foldMap_impl:"
  test_impl (Cons' 1 (Cons' 2 (Cons' 3 Nil')))


  
