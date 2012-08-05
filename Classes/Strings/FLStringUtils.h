//
//  _FLStringUtils.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"
#import "NSString+FLCore.h"

// this also accepts a nil formatString (which is why it exists)
extern NSString* FLStringWithFormatOrNil(NSString* formatOrNil, ...);

#if DEBUG
// these work with nil strings, which is why they're not
// category additions.
extern BOOL FLStringIsEmpty(NSString* string);
extern BOOL FLStringIsNotEmpty(NSString* string);
extern BOOL FLStringsAreEqual(NSString* lhs, NSString* rhs);
extern BOOL FLStringsAreEqualCaseInsensitive(NSString* lhs, NSString* rhs);
#else
#import "_FLStringUtils.h"
#endif


// deprecated
extern BOOL GtStringIsEmpty(NSString* string) __attribute__((deprecated));
extern BOOL GtStringIsNotEmpty(NSString* string)  __attribute__((deprecated));
extern BOOL GtStringsAreEqual(NSString* lhs, NSString* rhs)  __attribute__((deprecated));
extern BOOL GtStringsAreEqualCaseInsensitive(NSString* lhs, NSString* rhs)  __attribute__((deprecated));
extern NSString* GtStringWithFormatOrNil(NSString* formatOrNil, ...) __attribute__((deprecated));
