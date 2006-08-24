AC_INIT([Haskell regex-posix package], [0.71], [TextRegexLazy@personal.mightyreason.com], [regex-posix])

AC_CONFIG_SRCDIR([regex-posix.cabal])
AC_CONFIG_HEADERS([include/HsRegexPosixConfig.h])

dnl ** check for POSIX regex
HavePosixRegex=NO
AC_CHECK_HEADERS([regex.h], [AC_CHECK_FUNCS(regcomp, 
   [HavePosixRegex=YES;
    AC_DEFINE(HAVE_POSIX_REGEX, [1], [Define to 1 if you have a POSIX regex library installed])])])
AC_SUBST(HavePosixRegex)

AC_CONFIG_FILES([config.mk])

AC_OUTPUT
