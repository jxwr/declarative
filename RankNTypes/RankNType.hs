{-# LANGUAGE Rank2Types #-}

--;; 类型a -> b -> a可以写成forall a b. a -> b -> a，等价于forall a. a -> (forall b. b -> a)
--;; 如果forall无法规约，那么forall的个数就是Rank-N的N
--;; 比如：(forall a. a -> a) -> (forall b. b -> b) 就是Rank-2


tupleF :: (t -> t1) -> (t, t) -> (t1, t1)
tupleF f (x, y) = (f x, f y)

--;; 这里的不同之处是函数类型和forall在一个括号内
--;; 即是：(forall t. Show t => t -> t1) -> (a, b) -> (t1, t1)
--;; 而非：forall t. (Show t => t -> t1) -> (a, b) -> (t1, t1)
--;; 前者要求参数函数(t->t1)可以接受所有Show的子类，而非个别子类，第二个例子没有这个限制，t可以是Show的子类类型
tupleS :: (Show a, Show b) => (forall t. Show t => t -> t1) -> (a, b) -> (t1, t1)
tupleS f (x, y) = (f x, f y)

class Show t => SubShow t where
  subshow :: t -> String

main = do
  print $ tupleF (\x -> show x) (True, False)
  print $ tupleS (\x -> show x) (True, 2)

  --;; 下面的例子行不通，因为x是SubShow，而：
  --;;   (forall t. Show t => t -> t1)要求函数可以接受所有Show类型，而非仅仅是SubShow
  -- print $ tupleS (\x -> subshow x) (True, 2)
  
{-

  https://www.schoolofhaskell.com/school/to-infinity-and-beyond/pick-of-the-week/guide-to-ghc-extensions/explicit-forall

  (forall n. Num n => n -> n) -> (Int, Double) 全部Num子类
  forall n. Num n => (n -> n) -> (Int, Double) 存在Num子类

  The latter signature requires a function from n to n for some Num n;
  The former signature requires a function from n to n for every Num n.

  The former signature forces its user to only pass in truly polymorphic functions: functions precisely of type forall n. Num n => n -> n or more general. (+1) is one such function, as are (6*), abs, and id; however, you could not pass in (/5) because that requires Fractional, even if some types with an instance of Num also have an instance of Fractional.

-}
