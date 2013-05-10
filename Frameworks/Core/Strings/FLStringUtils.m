//
//  FLStringUtils.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLStringUtils.h"

#if DEBUG
#define __INLINES__
#import "FLStringUtils_Inlines.h"
#endif 

NSString* FLStringWithFormatOrNil(NSString* format, ...) {
    if(format) {
        va_list va;
        va_start(va, format);
        
        NSString* string = FLAutorelease([[NSString alloc] initWithFormat:[format description] arguments:va]);
        va_end(va);
        return string;
    }
    
    return @"";
}

@implementation NSString (FLStringUtilities)

- (NSString*) stringWithDeletedSubstring:(NSString*) substring {

    NSRange range = [self rangeOfString:substring];
    if(range.length > 0) {
        NSMutableString* newString = FLAutorelease([self mutableCopy]);
        [newString deleteCharactersInRange:range];
        return newString;
    }

    return self;
}



+ (NSString*) stringWithFormatOrNil:(NSString*) format, ... {
    if(format) {
        va_list va;
        va_start(va, format);
        NSString* string = [[NSString alloc] initWithFormat:format arguments:va];
        va_end(va);
        return FLAutorelease(string);
    }
    
    return @"";
}


- (NSString*) trimmedStringWithNoLFCR
{
	NSString* str = [self trimmedString];
	str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	return [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}
// TODO: is there a better way to do this?
- (NSString*) trimmedString {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*) stringWithPadding:(NSUInteger) width {
    NSMutableString* str = [NSMutableString stringWithString:self];
    for(NSUInteger i = self.length; i < width; i++) {
        [str appendString:@" "];
    }
    return str;
}

- (BOOL)isEqualToString:(NSString *)aString caseSensitive:(BOOL) caseSensitive {
	return caseSensitive ?	[self isEqualToString:aString] :		
							[self caseInsensitiveCompare:aString] == NSOrderedSame; 
}

- (NSString*) stringWithUpperCaseFirstLetter
{
	return [NSString stringWithFormat:@"%c%@", 
					toupper([self characterAtIndex:0]),
					[self substringFromIndex:1]];
}

- (NSString*) stringWithLowercaseFirstLetter
{
	return [NSString stringWithFormat:@"%c%@", 
			tolower([self characterAtIndex:0]),
			[self substringFromIndex:1]];
}


- (NSString*) camelCaseSpaceDelimitedString
{
	NSArray* split = [self componentsSeparatedByString:@" "];
	
	NSMutableString* outString = [NSMutableString string];
	
	[outString appendString:[split objectAtIndex:0]];
	
	for(NSUInteger i = 1; i < split.count; i++)
	{
		[outString appendString:[[split objectAtIndex:i] stringWithUpperCaseFirstLetter]];
	}
	
	return outString;
}


- (NSString*) stringWithRemovingQuotes {
    
    if(self.length >= 2) {
        NSRange r;
        r.length = self.length;
        r.location = 0;
        
        unichar f = [self characterAtIndex:0];
        unichar l = [self characterAtIndex:self.length - 1];
        if((f == '\"' && l == '\"') ||
           (f == '\'' && l == '\'') ) {
           r.length -= 2;
           ++r.location;
        }

        return [self substringWithRange:r];
    }
    
    return self;
}


- (BOOL) containsString:(NSString*) string {
    return FLStringIsNotEmpty(string) && [self rangeOfString:string].length == string.length;
}

- (NSUInteger) subStringCount:(NSString*) substring {
    NSUInteger count = 0;
    NSUInteger subLen = substring.length;
    NSUInteger len = self.length;
    
    for(int i = 0; i < len; i++) {
        for(int j = 0; (j < subLen && i < len); j++) {
            if([self characterAtIndex:i] != [substring characterAtIndex:j]) {
                goto skip;
                
                ++i;
            }
        }
        
        ++count;
        
        skip: ;
    }
    
    return count;
}

- (NSArray*) componentsSeparatedByCharactersInSet:(NSCharacterSet*) charSet 
                                allowEmptyStrings:(BOOL) allowEmptyStrings {

    NSArray* components = [self componentsSeparatedByCharactersInSet:charSet];
    if(!allowEmptyStrings) {
        NSMutableArray* mutableComponents = [NSMutableArray arrayWithCapacity:components.count];
        for(NSString* str in components) {
            if(FLStringIsNotEmpty(str)) {
                [mutableComponents addObject:str];
            }
        }
        components = mutableComponents;
    }

    return components;
}                                


@end

@implementation NSMutableString (FLStringUtilities)

- (BOOL) insertString:(NSString*) substring beforeString:(NSString*) beforeString withBackwardsSearch:(BOOL) searchBackwards {

    NSStringCompareOptions options = searchBackwards ? NSBackwardsSearch: 0;
    
    NSRange range = [self rangeOfString:beforeString options:options];

    if(range.length) {
        [self insertString:substring atIndex:range.location];
        return YES;
    }
    
    return NO;
}

- (BOOL) insertString:(NSString*) substring afterString:(NSString*) afterString withBackwardsSearch:(BOOL) searchBackwards {

    NSStringCompareOptions options = searchBackwards ? NSBackwardsSearch: 0;
    
    NSRange range = [self rangeOfString:afterString options:options];

    if(range.length) {
        [self insertString:substring atIndex:range.location + range.length];
        return YES;
    }

    return NO;
}



@end


