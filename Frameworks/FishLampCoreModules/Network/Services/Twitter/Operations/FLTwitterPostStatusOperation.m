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

- (void) prepareSelf {

#if DEBUG
	self.URL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];
#else
	self.URL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];
#endif
    self.httpRequest.requestMethod = @"POST";
    
    [super prepareSelf];
}
@end
