{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}

module MyReaderTF (
  MonadReader(..),
  ReaderT,
  runReaderT,
  ) where

import Control.Monad.Trans.State
import qualified Control.Monad.Trans.Reader as R
import Control.Monad.Trans.Reader (ReaderT, runReaderT)
import Control.Monad.Trans.Class

type family ReaderContext (m :: * -> *)

class (Monad m) => MonadReader m where
  ask :: m (ReaderContext m)

-- ReaderT instance
type instance ReaderContext (ReaderT r m) = r

instance (Monad m) => MonadReader (ReaderT r m) where
  ask = R.ask

-- StateT instance
type instance ReaderContext (StateT s m) = ReaderContext m

instance (MonadReader m) => MonadReader (StateT s m) where
  ask = lift ask
