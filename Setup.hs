#!/usr/bin/env runhaskell

-- I usually compile this with "ghc --make -o setup Setup.hs"

import Distribution.Simple(defaultMainWithHooks, defaultUserHooks)
main = defaultMainWithHooks defaultUserHooks
