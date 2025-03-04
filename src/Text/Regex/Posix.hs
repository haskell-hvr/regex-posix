-----------------------------------------------------------------------------
-- |
--
-- Module      :  Text.Regex.Posix
-- Copyright   :  (c) Chris Kuklewicz 2006
-- License     :  BSD-3-Clause
--
-- Maintainer  :  Andreas Abel
-- Stability   :  stable
-- Portability :  non-portable (regex-base needs MPTC+FD)
--
-- Module that provides the Regex backend that wraps the
-- <https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/regex.h.html C POSIX.2 regex api>.
-- This is the backend being used by the <//hackage.haskell.org/regex-compat regex-compat> package to replace
-- "Text.Regex".
--
-- The "Text.Regex.Posix" module provides a backend for regular
-- expressions. If you import this along with other backends, then
-- you should do so with qualified imports, perhaps renamed for
-- convenience.
--
-- If the '=~' and '=~~' functions are too high level, you can use the
-- compile, regexec, and execute functions from importing either
-- "Text.Regex.Posix.String" or "Text.Regex.Posix.ByteString".  If you
-- want to use a low-level 'Foreign.C.CString' interface to the library,
-- then import "Text.Regex.Posix.Wrap" and use the wrap* functions.
--
-- This module is only efficient with 'Data.ByteString.ByteString' only
-- if it is null terminated, i.e. @(Bytestring.last bs)==0@.  Otherwise the
-- library must make a temporary copy of the 'Data.ByteString.ByteString'
-- and append the @NUL@ byte.
--
-- A 'String' will be converted into a 'Foreign.C.CString' for processing.
-- Doing this repeatedly will be very inefficient.
--
-- Note that the posix library works with single byte characters, and
-- does not understand Unicode.  If you need Unicode support you will
-- have to use a different backend.
--
-- When offsets are reported for subexpression captures, a subexpression
-- that did not match anything (as opposed to matching an empty string)
-- will have its offset set to the 'unusedRegOffset' value, which is @(-1)@.
--
-- Benchmarking shows the default regex library on many platforms is very
-- inefficient.  You might increase performace by an order of magnitude
-- by obtaining @libpcre@ and <//hackage.haskell.org/package/regex-pcre regex-pcre>
-- or @libtre@ and <//hackage.haskell.org/package/regex-tre regex-tre>.  If you
-- do not need the captured substrings then you can also get great
-- performance from <//hackage.haskell.org/package/regex-dfa regex-dfa>.  If you do need the capture substrings
-- then you may be able to use <//hackage.haskell.org/package/regex-parsec regex-parsec> to improve performance.
-----------------------------------------------------------------------------

module Text.Regex.Posix(getVersion_Text_Regex_Posix
 ,module Text.Regex.Base
  -- ** Wrap, for '=~' and '=~~', types and constants
 ,module Text.Regex.Posix.Wrap) where

import Prelude ()

import Text.Regex.Posix.Wrap(Regex, CompOption(CompOption),
  ExecOption(ExecOption), (=~), (=~~),
  unusedRegOffset,
  compBlank, compExtended, compIgnoreCase, compNoSub, compNewline,
  execBlank, execNotBOL, execNotEOL)
import Text.Regex.Posix.String()
import Text.Regex.Posix.Sequence()
import Text.Regex.Posix.ByteString()
import Text.Regex.Posix.ByteString.Lazy()
import Data.Version(Version)
import Text.Regex.Base
import qualified Paths_regex_posix

getVersion_Text_Regex_Posix :: Version
getVersion_Text_Regex_Posix = Paths_regex_posix.version
