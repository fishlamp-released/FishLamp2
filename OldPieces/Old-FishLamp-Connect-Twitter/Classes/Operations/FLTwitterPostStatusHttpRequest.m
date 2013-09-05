//
//  FLTwitterPostStatusOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "FLTwitterPostStatusHttpRequest.h"
#import "NSString+URL.h"
#import "NSString+Guid.h"

@implementation FLTwitterPostStatusHttpRequest

- (id) init {
    return [super initWithTwitterURL:[NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"]];
}

@end
#endif