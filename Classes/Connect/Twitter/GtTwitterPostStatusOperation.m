//
//  GtTwitterPostStatusOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterPostStatusOperation.h"
#import "NSString+URL.h"
#import "NSString+Guid.h"

@implementation GtTwitterPostStatusOperation

- (void) didInit
{
	[self setRequestWillPost];
#if DEBUG
	self.URL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];
#else
	self.URL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];
#endif
}
@end
