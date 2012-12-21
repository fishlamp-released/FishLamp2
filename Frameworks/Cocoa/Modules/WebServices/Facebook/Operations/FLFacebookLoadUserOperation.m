//
//  FLFacebookLoadUserOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookLoadUserOperation.h"
#import "FLFacebookUser.h"
#import "FLFacebookService.h"
#import "FLOperationCacheHandler.h"

@implementation FLFacebookLoadUserOperation

- (FLResult) runOperationWithInput:(id) input {


	FLFacebookUser* user = [FLFacebookUser facebookUser];
FIXME(@"load the user id???");
//	user.id = self.userId;
	self.inputObject = user;
	self.outputObject = [FLFacebookUser facebookUser];

    return [super runOperationWithInput:(id) input];
}

- (BOOL) willAddParametersToURL {
	return NO;
}

@end
