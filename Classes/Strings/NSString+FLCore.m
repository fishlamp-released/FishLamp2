//
//  NSString+FLCore.m
//  fishlamp-core
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSString+FLCore.h"

@implementation NSString (FLCore)

- (BOOL)isEqualToString:(NSString *)aString caseSensitive:(BOOL) caseSensitive {
	return caseSensitive ?	[self isEqualToString:aString] :		
							[self caseInsensitiveCompare:aString] == NSOrderedSame; 
}


+ (NSString*) stringWithFormatOrNil:(NSString*) format, ... {
    if(format) {
        va_list va;
        va_start(va, format);
        NSString* string = [[NSMutableString alloc] initWithFormat:format arguments:va];
        va_end(va);
        return FLReturnAutoreleased(string);
    }
    
    return @"";
}


@end


