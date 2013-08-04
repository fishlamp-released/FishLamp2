//
//  FLSuccessfulResult.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSuccessfulResult.h"


@implementation FLSuccessfulResult

+ (id) successfulResult {
    static dispatch_once_t s_predicate = 0;
    static FLSuccessfulResult* s_instance = nil;
    dispatch_once(&s_predicate, ^{
        s_instance = [[FLSuccessfulResult alloc] init];
    });
    return s_instance;
}

@end