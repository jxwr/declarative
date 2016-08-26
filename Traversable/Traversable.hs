import Control.Applicative
import Data.Traversable
import Data.Foldable

-- ;; Traversable要求t是Functor且Foldable，即:
-- ;;   class (Functor t, Foldable t) => Traversable t
-- ;; 需要实现traverse:
-- ;;   traverse :: Applicative f => (a -> f b) -> t a -> f (t b)

-- ;; Functor需要实现：
-- ;; (<$>) :: Functor f => (a -> b) -> f a -> f b
-- ;; 即: fmap :: Functor f => (a -> b) -> f a -> f b
-- ;; 将一个普通函数，映射成Functor函数

-- ;; Applicative需要实现：
-- ;; (<*>) :: Applicative f => f (a -> b) -> f a -> f b
-- ;; pure :: a -> f a
-- ;; 将Functor值，应用到一个在Functor函数上

-- ;; 常见的模式是：
-- ;; func <$> val_A <*> val_B
-- ;; 有函数类型: func :: a -> b -> c，通过<$>,<*>执行函数，最终类型是f c
-- ;; 1. (func <$>) :: f a -> f (b -> c)
-- ;; 2. (func <$> val_A) :: f (b -> c)
-- ;; 3. (func <$> val_B <*>) :: f b -> f c
-- ;; 4. func <$> val_A <*> val_B :: f c

-- ;; 举例子：
-- ;; Cons :: Int -> List Int -> List Int
-- ;; Cons <$> :: f Int -> f (List Int -> List Int)
-- ;; Cons <$> (pure 1) :: f (List Int -> List Int)
-- ;; Cons <$> (pure 1) <*> :: f (List Int) -> f (List Int)
-- ;; Cons <$> (pure 1) <*> (pure 2) :: f (List Int)

data List a = Nil | Cons a (List a)

instance Functor List where
  -- fmap :: (a -> b) -> f a -> f b
  fmap f (Cons a xs) = Cons (f a) (fmap f xs)
  fmap f Nil = Nil

instance Foldable List where
  -- foldr :: (a -> b -> b) -> b -> List a -> b
  foldr f b (Cons a xs) = f a (foldr f b xs)
  foldr f b Nil = b

instance Traversable List where
  -- traverse :: Applicative f => (a -> f b) -> t a -> f (t b)
  traverse f (Cons a xs) = Cons <$> f a <*> traverse f xs
  traverse f Nil = pure Nil

main = do
  -- ([Char] -> IO ()) -> List [Char] -> IO (List ())
  traverse print (Cons "1" (Cons "2" (Cons "3" Nil)))
  traverse print (Cons 1 (Cons 2 (Cons 3 Nil)))
