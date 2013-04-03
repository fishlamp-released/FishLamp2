//
//  FLFacebookLoadUserOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookLoadUserHttpRequest.h"
#import "FLFacebookUser.h"
#import "FLFacebookService.h"
#import "FLOperationCacheHandler.h"

@implementation FLFacebookLoadUserHttpRequest

//- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
//
//
//	FLFacebookUser* user = [FLFacebookUser facebookUser];
//FIXME(@"load the user id???");
////	user.id = self.userId;
//	self.inputObject = user;
//	self.outputObject = [FLFacebookUser facebookUser];
//
//    return [super runOperation];
//}

- (BOOL) willAddParametersToURL {
	return NO;
}

- (void) willSendHttpRequest {

}


- (FLResult) resultFromHttpResponse:(FLHttpResponse*) response {

    return response;
}


@end
