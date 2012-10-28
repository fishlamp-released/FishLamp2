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
#import "FLStringUtilsInlineMethods.h"
#endif

#define FLStringsAreNotEqual(lhs, rhs) (!FLStringsAreEqual(lhs, rhs))

@interface NSString (FLStringUtilities)

- (BOOL)isEqualToString:(NSString *)aString caseSensitive:(BOOL) caseSensitive;

// SDK version isn't to happy with nil.
// this returns @"" if formatOrNil is nil.
+ (NSString*) stringWithFormatOrNil:(NSString*) formatOrNil, ...;

- (NSString*) trimmedStringWithNoLFCR;

- (NSString*) trimmedString;

- (NSString*) stringWithPadding:(NSUInteger) width;

- (NSString*) stringWithDeletedSubstring:(NSString*) substring;

- (NSString*) stringWithUpperCaseFirstLetter;

- (NSString*) stringWithLowercaseFirstLetter;

- (NSString*) camelCaseSpaceDelimitedString;

- (NSString*) stringWithRemovingQuotes; // if the string is "..." or '...' it will remove the leading and trailing quotes quotes. 

- (BOOL) containsString:(NSString*) string;

@end

@interface NSMutableString (FLStringUtilities)
- (BOOL) insertString:(NSString*) substring beforeString:(NSString*) beforeString withBackwardsSearch:(BOOL) searchBackwards;
- (BOOL) insertString:(NSString*) substring afterString:(NSString*) afterString withBackwardsSearch:(BOOL) searchBackwards;
@end



// deprecated
extern BOOL GtStringIsEmpty(NSString* string) __attribute__((deprecated));
extern BOOL GtStringIsNotEmpty(NSString* string)  __attribute__((deprecated));
extern BOOL GtStringsAreEqual(NSString* lhs, NSString* rhs)  __attribute__((deprecated));
extern BOOL GtStringsAreEqualCaseInsensitive(NSString* lhs, NSString* rhs)  __attribute__((deprecated));
extern NSString* GtStringWithFormatOrNil(NSString* formatOrNil, ...) __attribute__((deprecated));
