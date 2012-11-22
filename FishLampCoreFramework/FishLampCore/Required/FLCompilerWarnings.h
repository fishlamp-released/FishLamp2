//
//  FLCompilerWarnings.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#ifndef PRAGMA_WARNINGS_AS_BUGS
#define PRAGMA_WARNINGS_AS_BUGS 1
#endif

#ifndef FIXME_WARNINGS
    #define FIXME_WARNINGS 1
#endif

#ifndef NOT_IMPLEMENTED_WARNINGS
    #define NOT_IMPLEMENTED_WARNINGS 1
#endif

#ifndef BUG_WARNINGS
    #define BUG_WARNINGS 1
#endif

#define DO_PRAGMA(x) _Pragma (#x)

#if PRAGMA_WARNINGS_AS_BUGS
    #undef FIXME_WARNINGS
    #define FIXME_WARNINGS 1

    #undef NOT_IMPLEMENTED_WARNINGS
    #define NOT_IMPLEMENTED_WARNINGS 1

    #define TODO(x) DO_PRAGMA(message ("[BUG]: TODO: " #x))
    #define FIXME(x) DO_PRAGMA(message ("[BUG]: FIXME: " #x))
    #define NOT_IMPLEMENTED(x) DO_PRAGMA(message ("[BUG]: NOT_IMPLEMENTED: " #x))

#else
    #define TODO(x) DO_PRAGMA(message ("TODO: " #x))
    #define FIXME(x) DO_PRAGMA(message ("FIXME: " #x))
    #define NOT_IMPLEMENTED(x) DO_PRAGMA(message ("NOT_IMPLEMENTED: " #x))
#endif

#define BUG(x) DO_PRAGMA(message ("[BUG]: " #x))


//
// compiler warnings
//

// HOW to turn off warnings per file in GCC
// http://gcc.gnu.org/onlinedocs/gcc/Diagnostic-Pragmas.html

// GCC Warning in case they need to be turned off per file
// http://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

// MORE ON CLANG
// http://clang.llvm.org/docs/UsersManual.html

// turn off warnings we know break fishlamp compiling.

// this prevents adding a private readwrite synthesize for readonly properties
#pragma GCC diagnostic ignored "-Wreadonly-setter-attrs"

// this warning causes use of MIN/MAX to not compile. Tried all the different GNU types. No luck.
#pragma GCC diagnostic ignored "-Wgnu"

// this basically makes default: in case cause an error. I don't understand this one at all.
#pragma GCC diagnostic ignored "-Wcovered-switch-default"

#pragma GCC diagnostic ignored "-Wswitch-enum"


// on the fence about this one, we use this to essentially do a down cast in someplaces. Maybe that isn't a best practice
// TODO: revisit this
#pragma GCC diagnostic ignored "-Woverriding-method-mismatch"

// This dissallows not const strings as params. This might be a good this.
// TODO: revisit this
#pragma GCC diagnostic ignored "-Wformat-nonliteral"

// these generate too many warnings/errors

#pragma GCC diagnostic ignored "-Wunused-parameter"

#pragma GCC diagnostic ignored "-Wsign-conversion"

#pragma GCC diagnostic ignored "-Wsign-compare"

#pragma GCC diagnostic ignored "-Wconversion"