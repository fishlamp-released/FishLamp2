//
//  NSString+FLCharString.m
//  FishLampCore
//
//  Created by Mike Fullerton on 3/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSString+FLCharString.h"

@implementation NSString (FLCharString)

- (id) initWithCharString:(FLCharString) charString {
	return [self initWithBytes:charString.string length:charString.length encoding:NSASCIIStringEncoding];
}

+ (id) stringWithCharString:(FLCharString) charString {
    return FLAutorelease([[[self class] alloc] initWithCharString:charString]);
}

@end
