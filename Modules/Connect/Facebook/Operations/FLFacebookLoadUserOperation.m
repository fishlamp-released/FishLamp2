//
//  FLFacebookLoadUserOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookLoadUserOperation.h"
#import "FLFacebookUser.h"
#import "FLFacebookMgr.h"
#import "FLOperationCacheHandler.h"

@implementation FLFacebookLoadUserOperation

- (void) willPerformOperation
{ 
	FLFacebookUser* user = [FLFacebookUser facebookUser];
	user.id = self.userId;
	self.operationInput = user;
	self.operationOutput = [FLFacebookUser facebookUser];
    [super willPerformOperation];
}

- (BOOL) willAddParametersToURL
{
	return NO;
}

@end
