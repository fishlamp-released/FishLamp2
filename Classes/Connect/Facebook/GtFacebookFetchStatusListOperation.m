//
//  GtFacebookFetchStatusListOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookFetchStatusListOperation.h"
#import "GtFacebookFetchStatusListResponse.h"

@implementation GtFacebookFetchStatusListOperation

- (void) didInit
{
	[super didInit];
		
	self.output = [GtFacebookFetchStatusListResponse facebookFetchStatusListResponse];
	self.object = @"home";
	self.userId = @"me";
	
	self.cacheBehavior = GtHttpOperationCacheBehaviorNone;
}

- (void) operationWasPerformed
{
	if(self.didFinishWithoutError)
	{
		GtFacebookFetchStatusListResponse* response = self.output;
		
		NSArray* messages = response.data;
		
		[[GtFacebookMgr instance].userSession.documentsDatabase batchSaveObjects:messages];
	}
}

@end