//
//  GtFacebookLoadUserOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookLoadUserOperation.h"
#import "GtFacebookUser.h"
#import "GtFacebookMgr.h"

@implementation GtFacebookLoadUserOperation

- (void) didInit
{
	[super didInit];
	self.cacheBehavior	= GtHttpOperationCacheBehaviorAll;
}

- (void) prepareOperation
{ 
	GtFacebookUser* user = [GtFacebookUser facebookUser];
	user.id = self.userId;
	self.input = user;
	self.output = [GtFacebookUser facebookUser];
    self.cacheBehavior = GtHttpOperationCacheBehaviorAll;
	[super prepareOperation];
}

- (BOOL) willAddParametersToURL
{
	return NO;
}

@end
