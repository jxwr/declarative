{-# LANGUAGE ExistentialQuantification #-}

-- ;; 如果没有打开存在量词扩展ExistentialQuantification，类型定义右边出现的类型必须在类型左边出现
-- ;; data Toy a  = Toy x (x -> a)  -- 不合法
-- ;; data Toy x a = Toy x (x -> a) -- 合法

-- ;; (1) ExistentialTypes允许类型定义时，等号右边出现的类型在等号左边不出现的类型
-- ;; (2) 可以实现，"仅在等号右边出现的类型变量"可以同时赋予不同的类型，却有着相同的类型
-- ;; (3) 可以实现，类型构造时隐藏部分类型

data Toy a = forall x. Toy x (x -> a)

-- ;; toyInt_string和toyInt_int的类型都是Toy Int

-- ;; x的类型是String
toyInt_string :: Toy Int
toyInt_string = Toy "Hello world!" length

-- ;; x的类型是Int
toyInt_int :: Toy Int
toyInt_int = Toy 5 (+1)

showToy :: Show a => Toy a -> IO ()
showToy (Toy x f) = putStrLn (show (f x))

-- ;; (4) 常见的使用方式是existentials中带有typeclass, LabelRow表示任意可以转成字符串的带有label的字符串
data LabelRow label = forall content. Show content => LabelRow content label

showLabelRow :: (Show label) => LabelRow label -> IO ()
showLabelRow (LabelRow content label) = do
  putStrLn $ (show label) ++ ": " ++ (show content)

main = do
  showToy toyInt_string
  showToy toyInt_int

  -- 注意后面的List，因为用了ExistentialTypes，这些元素才可能属于同一类型`LabelRow Int`
  mapM_ showLabelRow [(LabelRow "Hello World" 1), (LabelRow [1,2,3] 2), (LabelRow True 3)]
