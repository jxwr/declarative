
--;; CPS风格函数就是把返回值改成返回一个函数，该函数的参数就是原来函数的结果

add :: Int -> Int -> Int
add x y = x + y

add_cps :: Int -> Int -> ((Int -> r) -> r)
add_cps x y = \k -> k (add x y)

square :: Int -> Int
square x = x * x

square_cps :: Int -> ((Int -> r) -> r)
square_cps x = \k -> k (square x)

pythagoras_cps :: Int -> Int -> ((Int -> r) -> r)
pythagoras_cps x y = \k ->
  square_cps x $ \x_square ->
  square_cps y $ \y_square ->
  add_cps x_square y_square k

main = do
  -- 把add 1 2的结果传给print, print (add 1 2)
  add_cps 1 2 print

  -- add (square 3) (square 4)
  -- 1. square_cps 3 $ \x -> 将square的结果应用到后续计算
  -- 2. square_cps 3 $ \x -> suqare_cps 4 $ \y -> 将square 3和square 4的结果应用到后续的计算
  -- 3. square_cps 3 $ \x -> square_cps 4 $ \y -> add_cps x y $ \k -> print k 将add 9 16的结果应用到print
  square_cps 3 $ \x ->
    square_cps 4 $ \y ->
    add_cps x y print

  pythagoras_cps 3 4 print
  
