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
#import "FLFacebookMgr.h"
#import "FLUserDataStorageService.h"

@implementation FLFacebookFetchStatusListOperation

- (id) initWithURL:(NSURL*) url {
    self = [super initWithURL:url];
    if(self) {
        self.output = [FLFacebookFetchStatusListResponse facebookFetchStatusListResponse];
        self.object = @"home";
        self.userId = @"me";
    }
    return self;
}

- (void) runSelf {
    [super runSelf];

	if(self.didSucceed) {
		FLFacebookFetchStatusListResponse* response = self.output;
		
		NSArray* messages = response.data;
		
		[self.facebookService.userDataService.documentsDatabase batchSaveObjects:messages];
	}
}

@end