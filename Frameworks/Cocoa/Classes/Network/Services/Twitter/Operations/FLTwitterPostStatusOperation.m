//
//  FLTwitterPostStatusOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterPostStatusOperation.h"
#import "NSString+URL.h"
#import "NSString+Guid.h"

@implementation FLTwitterPostStatusOperation

- (id) init {
    return [super initWithTwitterURL:[NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"]];
}

@end
