@echo off
set ddkpath=T:\Program Files\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.28.29910
set path=%ddkpath%\bin\Hostx64\x64;T:\Program Files\Windows Kits\10\bin\10.0.22000.0\x64;T:\Program Files\Windows Kits\10\Debuggers\x64;%path%
set incpath=T:\Program Files\Windows Kits\10\Include\10.0.22000.0
set libpath=T:\Program Files\Windows Kits\10\Lib\10.0.22000.0

echo Compiling...
cl snprintf.c /I"%incpath%\shared" /I"%incpath%\um" /I"%incpath%\ucrt" /I"%ddkpath%\include" /Zi /nologo /W3 /WX /wd4267 /wd4244 /Od /D"HAVE_STDARG_H" /D"HAVE_LOCALE_H" /D"HAVE_STDDEF_H" /D"HAVE_FLOAT_H" /D"HAVE_STDINT_H" /D"HAVE_INTTYPES_H" /D"HAVE_LONG_LONG_INT" /D"HAVE_UNSIGNED_LONG_LONG_INT" /D"HAVE_ASPRINTF" /D"HAVE_VASPRINTF" /D"HAVE_SNPRINTF" /Zc:wchar_t /std:c17 /FAcs /Fa"snprintf.cod" /Fo"snprintf.obj" /Fd"vc142.pdb" /GS- /Qspectre /TC /c /errorReport:queue

cl tester.c /I"%incpath%\shared" /I"%incpath%\um" /I"%incpath%\ucrt" /I"%ddkpath%\include" /Zi /nologo /W3 /WX /Od /D"HAVE_STDARG_H" /Zc:wchar_t /std:c17 /FAcs /Fa"tester.cod" /Fo"tester.obj" /Fd"vc142.pdb" /GS- /Qspectre /TC /c /errorReport:queue

echo Linking...
link tester.obj snprintf.obj /LIBPATH:"%libpath%\um\x64" /LIBPATH:"%libpath%\ucrt\x64" /LIBPATH:"%ddkpath%\lib\x64" /NODEFAULTLIB "kernel32.lib" /NOLOGO /INCREMENTAL:NO /DEBUG /PDB:"test_snprintf.pdb" /OUT:"test_snprintf.exe" /ENTRY:"main" /SUBSYSTEM:CONSOLE /Machine:X64 /ERRORREPORT:QUEUE

if "%~1"=="debug" (windbg test_snprintf.exe)