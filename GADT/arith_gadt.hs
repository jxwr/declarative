{-#LANGUAGE GADTs, EmptyDataDecls #-}

data Expr a where
    I   :: Int  -> Expr Int
    B   :: Bool -> Expr Bool
    Add :: Expr Int -> Expr Int -> Expr Int
    Mul :: Expr Int -> Expr Int -> Expr Int
    Eq  :: Expr Int -> Expr Int -> Expr Bool

-- GADT构造函数可以有影子函数，还可指定返回类型
eval :: Expr a -> a
eval (I n) = n
eval (B b) = b
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2
eval (Eq e1 e2) = eval e1 == eval e2

-- test
main = do
  let expr30 = Add (I 10) (I 20)
  let eq30 = Eq (I 30) (Add (I 10) (I 20))
  let neq30 = Eq (I 31) (Add (I 10) (I 20))
  -- 不合法：let nil = Eq (B False) (Add (I 10) (I 20))
  putStrLn $ show (eval expr30)
  putStrLn $ show (eval eq30)
  putStrLn $ show (eval neq30)

  
