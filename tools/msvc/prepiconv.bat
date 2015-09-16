@echo off
SETLOCAL EnableDelayedExpansion 

set THIS=%CD%

move libiconv-1.14\libcharset\include\localcharset.h.build.in libiconv-1.14\libcharset\include\localcharset.h
move libiconv-1.14\include\iconv.h.build.in libiconv-1.14\include\iconv.h
move libiconv-1.14\config.h.in libiconv-1.14\config.h