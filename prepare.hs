#!/usr/bin/env stack
-- stack script --install-ghc --resolver=lts-9.4 --package=bytestring --package=clock-extras --package=postgresql-simple

import Example

main = prepareExample
