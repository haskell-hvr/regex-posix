{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-|
-----------------------------------------------------------------------------
-- |
--
-- Module      :  Text.Regex.PosixRE
-- Copyright   :  (c) Chris Kuklewicz 2006
-- License     :  BSD-style (see the file LICENSE)
-- 
-- Maintainer  :  libraries@haskell.org, textregexlazy@personal.mightyreason.com
-- Stability   :  experimental
-- Portability :  non-portable (regex-base needs MPTC+FD)
--
-- Module that provides the Regex backend that wraps the c posix regex api.
-- This is the backend being used by the regex-compat package to replace
-- Text.Regex
--
-----------------------------------------------------------------------------

The "Text.Regex.PosixRE" module provides a backend for regular
expressions. If you import this along with other backends, then
you should do so with qualified imports, perhaps renamed for
convenience.

If the =~ and =~~ functions are too high level, you can use the
compile, regexec, and execute functions from importing either
"Text.Regex.Posix.String" or "Text.Regex.Posix.ByteString".  If you
want to use a low-level 'Foreign.C.CString' interface to the library, then
import "Text.Regex.Posix.Wrap" and use the wrap* functions.

This module is only efficient with 'Data.ByteString.ByteString' only if it is null
terminated, i.e. @(Bytstring.last bs)==0@.  Otherwise the library must
make a temporary copy of the 'Data.ByteString.ByteString' and append the NUL byte.

A 'String' will be converted into a 'Foreign.C.CString' for processing.  Doing
this repeatedly will be very inefficient.

Note that the posix library works with single byte characters, and
does not understand Unicode.  If you need Unicode support you will
have to use a different backend.

The CompOption and ExecOption values are newtype'd integer types that
represent bitmapped options.  The CompOption value (and their man 3
regcomp names) are

* compBlank which is a completely zero value for all the flags.  This
  is also the blankCompOpt value.

* compExtended (REG_EXTENDED) which can be set to use extended instead
  of basic regular expressions.  This is set in the defaultCompOpt value.

* compNewline (REG_NEWLINE) turns on newline sensitivity: The dot (.)
  and inverted set [^ ] never match newline, and ^ and $ anchors do
  match after and before newlines.  This is set in the defaultCompOpt value.

* compIgnoreCase (REG_ICASE) which can be set to match ignoring upper
  and lower distinctions.

* compNoSub (REG_NOSUB) which turns off all information from matching
  except whether a match exists.

The ExecOption values are

* execBlank which is a complete zero value for all the flags.  This is
  the blankExecOpt value.

* execNotBOL (REG_NOTBOL) can be set to prevent ^ from matching at the
  start of the input.

* execNotEOL (REG_NOTEOL) can be set to prevent $ from matching at the
  end of the input (before the terminating NUL).

When offsets are reported for subexpression captures, a subexrepssion
that did not match anything (as opposed to matching an empty string)
will have its offset set to the unusedRegOffset value, which is (-1).

Benchmarking shows the default regex library on many platforms is very
inefficient.  You might increase performace by an order of magnitude
by obtaining libpcre and regex-pcre or libtre and regex-tre.  If you
do not need the captured substrings then you can also get great
performance from regex-dfa.  If you do need the capture substrings
then you may be able to use regex-parsec to improve performance.
-}
module Text.Regex.Posix(
  -- ** Wrap, for '=~' and '=~~', types and constants
  module Text.Regex.Posix.Wrap
  -- ** String, instances only
 ,module Text.Regex.Posix.String
  -- ** ByteString, instances only
 ,module Text.Regex.Posix.ByteString) where

import Text.Regex.Posix.Wrap(Regex, CompOption(CompOption),
  ExecOption(ExecOption), (=~), (=~~),
  unusedRegOffset,
  compBlank, compExtended, compIgnoreCase, compNoSub, compNewline,
  execBlank, execNotBOL, execNotEOL)
import Text.Regex.Posix.String()
import Text.Regex.Posix.ByteString()
