//
//  FLFacebookFetchStatusListOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookFetchStatusListHttpRequest.h"
#import "FLFacebookFetchStatusListResponse.h"
#import "FLFacebookFacebookService.h"
#import "FLUserDataStorageService.h"

@implementation FLFacebookFetchStatusListHttpRequest

- (id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {
    self = [super initWithRequestURL:url httpMethod:httpMethod];
    if(self) {
        self.object = @"home";
    }
    return self;
}

//- (FLResult) runOperation {
//
////        self.userId = @"me";
//
//    FLFacebookFetchStatusListResponse* result = FLConfirmResultType([super runOperationWithInput:input], FLFacebookFetchStatusListResponse);
//        
////    NSArray* messages = result.data;
////    [[[self.context storageService] documentsDatabase] batchSaveObjects:messages];
////	
//    return result;
//}

- (void) willSendHttpRequest {

}


- (id) didReceiveHttpResponse:(FLHttpResponse*) response {

    return response;
}

@end