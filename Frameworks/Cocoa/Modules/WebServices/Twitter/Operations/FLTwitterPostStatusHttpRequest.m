//
//  FLTwitterPostStatusOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterPostStatusHttpRequest.h"
#import "NSString+URL.h"
#import "NSString+Guid.h"

@implementation FLTwitterPostStatusHttpRequest

- (id) init {
    return [super initWithTwitterURL:[NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"]];
}

@end
