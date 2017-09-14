{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Example (
    forever
  , prepareExample
  , replaceNumber
  , readNumber
  , measureTime
  , establishDbConnection
  , printf
  ) where

import Control.Monad                    (forever, void)
import Database.PostgreSQL.Simple       (Connection, Only(..),
                                         connectPostgreSQL, execute, query)
import Database.PostgreSQL.Simple.SqlQQ (sql)
import Secret                           (secret)
import System.Clock.TimeIt              (elapsedTime)
import Text.Printf                      (printf)

establishDbConnection :: IO Connection
establishDbConnection = connectPostgreSQL secret

prepareExample :: IO ()
prepareExample = do
  c <- establishDbConnection
  void $ execute c [sql|
    drop table if exists example_table;
    create table example_table (
      example_number bigint not null
      );
    insert into example_table (example_number) values (0);
    |] ()

replaceNumber :: Connection -> Int -> IO ()
replaceNumber db n = void $ execute db "delete from example_table; insert into example_table (example_number) values (?)" (Only n)

measureTime :: IO a -> IO ()
measureTime f = elapsedTime f >>= printf "Duration: %8.4f s\n" . snd

readNumber :: Connection -> IO Int
readNumber db = fromOnly . head <$> query db "select example_number from example_table limit 1" ()
