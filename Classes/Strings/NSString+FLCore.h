//
//  NSString+FLCore.h
//  fishlamp-core
//
//  Created by Mike Fullerton on 3/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

@interface NSString (FLCore)

- (BOOL)isEqualToString:(NSString *)aString caseSensitive:(BOOL) caseSensitive;

// SDK version isn't too happy with nil.
// this returns @"" if formatOrNil is nil.
+ (NSString*) stringWithFormatOrNil:(NSString*) formatOrNil, ...;

@end

