

-- ;; 首先，将Functor,Applicative,Foldable,Traversable,Monad都看成容器

-- ;; Functor:
-- ;;   <$>将"普通函数"应用到容器里的元素上，将map从List扩展到所有容器类型

-- ;; Applicative:
-- ;;   <*>将"同类容器中的普通函数"，应用到容器中的元素上
-- ;;   <*>使容器可以做函数应用

-- ;; Monad:
-- ;;   >>=将"返回为同类容器的函数"，应用到容器中的元素上

-- ;; Traversable:
-- ;;   traverse将"返回为另一类容器的函数"，应用到容器的元素上，返回包含本类容器的另一类容器
-- ;;   逻辑：将容器里的每个元素映射成Action，执行所有Action，然后收集结果
-- ;;   Map each element of a structure to an action, evaluate these actions from
-- ;;   left to right, and collect the results.

-- ;; <$> :: (a -> b) -> f a -> f b
-- ;; <*> :: f (a -> b) -> f a -> f b
-- ;; >>= :: m a -> (a -> m b) -> m b
-- ;; traverse :: Applicative f => (a -> f b) -> t a -> f (t b)

-- ;; fmap和traverse的区别，可以从Traversable中List的定义看出端倪：
-- ;;  fmap f (Cons a xs) = Cons (f a) (fmap f xs)
-- ;;  traverse f (Cons a xs) = Cons <$> f a <*> traverse f xs
-- ;; fmap的返回类型就是Cons，traverse的Cons是包含在返回类型里的，所以需要fmap(<$>)
