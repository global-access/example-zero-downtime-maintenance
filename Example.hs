{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Example (
    forever
  , prepareExample
  , replace
  , readEntry
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

replace :: Connection -> Int -> IO ()
replace db n = void $ execute db "delete from example_table; insert into example_table (example_number) values (?)" (Only n)

measureTime :: IO a -> IO ()
measureTime f = elapsedTime f >>= printf "Duration: %8.4f s\n" . snd

readEntry :: Connection -> IO Int
readEntry db = fromOnly . head <$> query db "select example_number from example_table limit 1" ()
