#!/usr/bin/env stack
-- stack script --install-ghc --resolver=lts-9.4 --package=bytestring --package=clock-extras --package=postgresql-simple

import Example

main = do
  db <- establishDbConnection
  forever (measureTime (readExampleNumberIn db))

readExampleNumberIn db = readNumber db >>= printf "Reading example number %4d | "
