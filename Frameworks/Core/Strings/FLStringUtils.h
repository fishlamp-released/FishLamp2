//
//  _FLStringUtils.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLRequired.h"

// NOTE: see NSScanner.h


@interface NSString (FLStringUtilities)

- (BOOL)isEqualToString:(NSString *)aString caseSensitive:(BOOL) caseSensitive;

// FL version isn't to happy with nil.
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

- (NSUInteger) subStringCount:(NSString*) substring;

- (NSArray*) componentsSeparatedByCharactersInSet:(NSCharacterSet*) set 
                                allowEmptyStrings:(BOOL) allowEmptyStrings;



@end

@interface NSMutableString (FLStringUtilities)
- (BOOL) insertString:(NSString*) substring beforeString:(NSString*) beforeString withBackwardsSearch:(BOOL) searchBackwards;
- (BOOL) insertString:(NSString*) substring afterString:(NSString*) afterString withBackwardsSearch:(BOOL) searchBackwards;
@end

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
#define __INLINES__
#import "FLStringUtils_Inlines.h"
#undef __INLINES__
#endif

#define FLStringsAreNotEqual(lhs, rhs) (!FLStringsAreEqual(lhs, rhs))

NS_INLINE
NSString* FLEmptyStringOrString(NSString* string) {
    return FLStringIsEmpty(string) ? @"" : string;
}


NS_INLINE
void FLAppendString(NSMutableString* string, NSString* aString) {
    if(FLStringIsNotEmpty(aString)) {
        [string appendString:aString];
    }
}
