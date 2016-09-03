import Control.Monad.Trans.Cont

add :: Int -> Int -> Int
add x y = x + y

add_cps :: Int -> Int -> Cont r Int
add_cps x y = return (add x y)

square :: Int -> Int
square x = x * x

square_cps :: Int -> Cont r Int
square_cps x = return (square x)

pythagoras_cps :: Int -> Int -> Cont r Int
pythagoras_cps x y = do
  x_square <- square_cps x
  y_square <- square_cps y
  add_cps x_square y_square

main = do
  runCont (pythagoras_cps 3 4) print
  print $ evalCont (pythagoras_cps 3 4)
