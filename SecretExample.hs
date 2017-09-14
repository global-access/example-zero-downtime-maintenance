{-# LANGUAGE OverloadedStrings #-}
module Secret where

import Data.ByteString (ByteString)

secret :: ByteString
secret = "host='postgres-server' port=5432 user='example-user' password='complicated-example-password' dbname='example-db'"
