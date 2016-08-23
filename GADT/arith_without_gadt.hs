

data Expr = I Int
        | B Bool           -- boolean constants
        | Add Expr Expr
        | Mul Expr Expr
        | Eq Expr Expr    -- equality test

eval' e1 e2 either fn = do
  a <- eval e1
  b <- eval e2
  case (a, b) of
    (Left n1, Left n2) -> return $ either (fn n1 n2)
    _ -> Nothing

eval :: Expr -> Maybe (Either Int Bool)
eval (I n) = Just (Left n)
eval (B b) = Just (Right b)
eval (Add e1 e2) = eval' e1 e2 Left (+)
eval (Mul e1 e2) = eval' e1 e2 Left (*)
eval (Eq e1 e2) = eval' e1 e2 Right (==)

-- test  
main = do
  let expr30 = Add (I 10) (I 20)
  let eq30 = Eq (I 30) (Add (I 10) (I 20))
  let neq30 = Eq (I 31) (Add (I 10) (I 20))
  let nil = Eq (B False) (Add (I 10) (I 20))
  print $ eval expr30
  print $ eval eq30
  print $ eval neq30
  print $ eval nil
