//
//  FLResult.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResult.h"

@implementation FLSuccessfullResult 
+ (id) successfulResult {
    return autorelease_([[[self class] alloc] init]);
}
@end

@implementation NSObject (FLResult)
- (NSError*) error {
    return nil;
}
@end