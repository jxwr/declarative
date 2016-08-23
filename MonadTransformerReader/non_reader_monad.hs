module Main where

data Config = CVal Int

modInt :: Config -> Int -> Int
modInt c n =
  let CVal m = c
  in n `mod` m

modString :: Config -> String -> Int
modString c s =
  let CVal m = c
      n = read s :: Int
  in n `mod` m

modAdd :: Config -> (Int, String) -> Int
modAdd c (n, s) =
  let r0 = modInt c n
      r1 = modString c s
  in r0 + r1

main :: IO ()
main = do
  let v = modAdd (CVal 7) (10, "12")
  putStrLn $ show v
