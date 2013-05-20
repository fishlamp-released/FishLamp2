//
//  NSString+GtExtras.m
//  fishlamp-core
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSString+GtExtras.h"

@implementation NSString (GtExtras)

- (BOOL)isEqualToString:(NSString *)aString caseSensitive:(BOOL) caseSensitive {
	return caseSensitive ?	[self isEqualToString:aString] :		
							[self caseInsensitiveCompare:aString] == NSOrderedSame; 
}

- (NSString*) trimmedString {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString*) stringWithFormatOrNil:(NSString*) format, ... {
    if(format) {
        va_list va;
        va_start(va, format);
        NSString* string = [[NSMutableString alloc] initWithFormat:format arguments:va];
        va_end(va);
        return GtReturnAutoreleased(string);
    }
    
    return @"";
}


// TODO: is there a better way to do this?

- (NSString*) stringWithPadding:(NSUInteger) width {
    NSMutableString* str = [NSMutableString stringWithString:self];
    for(NSUInteger i = self.length; i < width; i++) {
        [str appendString:@" "];
    }
    return str;
}
@end


