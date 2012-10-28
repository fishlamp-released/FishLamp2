//
//  FLFacebookFetchStatusListOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookFetchStatusListOperation.h"
#import "FLFacebookFetchStatusListResponse.h"
#import "FLUserSession.h"

@implementation FLFacebookFetchStatusListOperation

- (void) didInit
{
	[super didInit];
		
	self.output = [FLFacebookFetchStatusListResponse facebookFetchStatusListResponse];
	self.object = @"home";
	self.userId = @"me";
}

- (void) runSelf {
    [super runSelf];

	if(self.didSucceed) {
		FLFacebookFetchStatusListResponse* response = self.output;
		
		NSArray* messages = response.data;
		
		[[FLUserSession instance].documentsDatabase batchSaveObjects:messages];
	}
}

@end