import Control.Monad
import Control.Monad.Trans.Cont

--;; callCC的参数是函数，该函数的参数k类似goto，当执行时，整个Block就返回了
--;; callCC :: ((a -> Cont r b) -> Cont r a) -> Cont r a

--;; 一种实现：
--;;   callCC f = cont $ \h -> runCont (f (\a -> cont $ \_ -> h a)) h

--;; when :: Monad m => Bool -> m () -> m ()

foo :: Int -> Cont r String
foo x = callCC $ \k -> do
    let y = x ^ 2 + 3
    when (y > 20) $ k "over twenty"
    return (show $ y - 4)

main = do
  runCont (foo 1) print
  runCont (foo 10) print
  
  runCont (callCC $ \k -> k "abc") print
