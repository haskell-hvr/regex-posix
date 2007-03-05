#!/usr/bin/env runhaskell

-- I usually compile this with "ghc --make -o setup Setup.hs"

import Distribution.Simple(defaultMainWithHooks, defaultUserHooks)
main = do
  putStrLn msg
  defaultMainWithHooks defaultUserHooks

msg = "This links to the standard c library version of regular expressions.\n\
      \The corresponding c header file is regex.h and there is a chance you\n\
      \will need to edit the end of the regex-posix.cabal file to find the\n\
      \include directory and/or library.\n"
