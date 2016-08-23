

data Expr = I Int
        | B Bool           -- boolean constants
        | Add Expr Expr
        | Mul Expr Expr
        | Eq Expr Expr    -- equality test

evalAux e1 e2 fn = do
  a <- (eval e1)
  b <- (eval e2)
  case (a, b) of
    (Left n1, Left n2) -> return $ Left (fn n1 n2)
    _ -> Nothing

eval :: Expr -> Maybe (Either Int Bool)

eval (I n) = Just (Left n)
eval (B b) = Just (Right b)
eval (Add e1 e2) = evalAux e1 e2 (+)
eval (Mul e1 e2) = evalAux e1 e2 (*)

eval (Eq e1 e2) = do
  a <- (eval e1)
  b <- (eval e2)
  case (a, b) of
    (Left n1, Left n2) -> return $ Right (n1 == n2)
    (Right b1, Right b2) -> return $ Right (b1 == b2)
    _ -> Nothing

-- test  
main = do
  let expr30 = Add (I 10) (I 20)
  let eq30 = Eq (I 30) (Add (I 10) (I 20))
  let neq30 = Eq (I 31) (Add (I 10) (I 20))
  let nil = Eq (B False) (Add (I 10) (I 20))
  putStrLn $ show (eval expr30)
  putStrLn $ show (eval eq30)
  putStrLn $ show (eval neq30)
  putStrLn $ show (eval nil)
  
