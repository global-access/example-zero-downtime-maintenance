#!/usr/bin/env stack
-- stack script --resolver=lts-9.4 --package=bytestring --package=clock-extras --package=postgresql-simple

import Example

main = do
  db <- establishDbConnection
  forever $ measureTime (fetchExampleNumberIn db)

fetchExampleNumberIn db = readEntry db >>= printf "Reading example number %4d | "
