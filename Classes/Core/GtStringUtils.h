//
//  _FLStringUtils.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSString+GtExtras.h"

// this also accepts a nil formatString (which is why it exists)
extern NSString* GtStringWithFormatOrNil(NSString* formatOrNil, ...);

#if DEBUG
// these work with nil strings, which is why they're not
// category additions.
extern BOOL GtStringIsEmpty(NSString* string);
extern BOOL GtStringIsNotEmpty(NSString* string);
extern BOOL GtStringsAreEqual(NSString* lhs, NSString* rhs);
extern BOOL GtStringsAreEqualCaseInsensitive(NSString* lhs, NSString* rhs);
#else
#import "_FLStringUtils.h"
#endif


extern NSString* GtStringWithFormatOrNil(NSString* formatOrNil, ...);

typedef void (^GtStringCallback)(NSString* string);

#define GtKilobytes 1024.0
#define GtMegabtyes (1024.0*1024.0)
#define GtGigabytes (1024.0*1024.0*1024.0)

@interface NSString (GtStringUtils)

- (NSString*) stringWithUpperCaseFirstLetter;
- (NSString*) stringWithLowercaseFirstLetter;

- (NSString*) camelCaseSpaceDelimitedString;

- (NSString*) trimmedStringWithNoLFCR;

+ (NSString*) stringWithByteSize:(unsigned long long) byteSize;

@end
