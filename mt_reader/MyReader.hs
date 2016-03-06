{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}

module MyReader (
  MonadReader(..),
  ReaderT,
  runReaderT,
  ) where

import Control.Monad.Trans.State
import qualified Control.Monad.Trans.Reader as R
import Control.Monad.Trans.Reader (ReaderT, runReaderT)
import Control.Monad.Trans.Class

class (Monad m) => MonadReader m r | m -> r where
  ask :: m r

instance (Monad m) => MonadReader (ReaderT r m) r where
  ask = R.ask
  
instance (Monad m, MonadReader m r) => MonadReader (StateT s m) r where
  ask = lift ask
