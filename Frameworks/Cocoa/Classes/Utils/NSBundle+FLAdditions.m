//
//  NSBundle+FLAdditions.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSBundle+FLAdditions.h"

@implementation NSBundle (FLAdditions)

- (NSURL*) URLInInfoDictionaryForKey:(NSString*) key {
    NSString* value = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    FLAssertNotNil(value);
    return value ? [NSURL URLWithString:value] : nil;
}

@end
