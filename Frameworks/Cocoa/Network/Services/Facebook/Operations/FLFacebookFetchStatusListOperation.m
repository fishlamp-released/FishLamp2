//
//  FLFacebookFetchStatusListOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookFetchStatusListOperation.h"
#import "FLFacebookFetchStatusListResponse.h"
#import "FLFacebookService.h"
#import "FLUserDataStorageService.h"

@implementation FLFacebookFetchStatusListOperation

- (id) initWithHTTPRequestURL:(NSURL*) url {
    self = [super initWithHTTPRequestURL:url];
    if(self) {
        self.object = @"home";
    }
    return self;
}

- (FLResult) runSelf:(id) input {

//        self.userId = @"me";

    FLFacebookFetchStatusListResponse* result = FLConfirmResultType([super runSelf:input], FLFacebookFetchStatusListResponse);
        
    NSArray* messages = result.data;
    [[[self.context storageService] documentsDatabase] batchSaveObjects:messages];
	
    return result;
}

@end