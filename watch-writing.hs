#!/usr/bin/env stack
-- stack script --install-ghc --resolver=lts-9.4 --package=bytestring --package=clock-extras --package=postgresql-simple

import Example

main = do
  db <- establishDbConnection
  mapM (measureTime . writeNextNumber db) infiniteNumberSequence

infiniteNumberSequence = [1,2..]

writeNextNumber db n = do
  printf "Writing example number %4d | " n
  replaceNumber db n
