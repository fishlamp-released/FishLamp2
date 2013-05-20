//
//  NSString+GtExtras.h
//  fishlamp-core
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FishLampMinimum.h"

@interface NSString (GtExtras)

- (BOOL)isEqualToString:(NSString *)aString caseSensitive:(BOOL) caseSensitive;

- (NSString*) trimmedString;

// SDK version isn't too happy with nil.
// this returns @"" if formatOrNil is nil.
+ (NSString*) stringWithFormatOrNil:(NSString*) formatOrNil, ...;

- (NSString*) stringWithPadding:(NSUInteger) width;

@end

