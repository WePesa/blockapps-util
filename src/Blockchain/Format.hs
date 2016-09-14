{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}

module Blockchain.Format (
  Format(..)
  ) where

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Base16 as B16
import qualified Data.NibbleString as N

import Blockchain.ExtWord
import Numeric

class Format a where
  format::a->String

instance Format B.ByteString where
  format x = BC.unpack (B16.encode x)

instance Format N.NibbleString where
  format (N.EvenNibbleString bs) = format bs
  format (N.OddNibbleString n bs) = showHex n "" ++ format bs

instance Format Word256 where
  format x = BC.unpack $ B16.encode $ B.pack $ word256ToBytes x

