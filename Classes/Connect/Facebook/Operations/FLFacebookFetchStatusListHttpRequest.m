//
//  FLFacebookFetchStatusListOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFacebookFetchStatusListHttpRequest.h"
#import "FLFacebookFetchStatusListResponse.h"
#import "FLFacebookService.h"

@implementation FLFacebookFetchStatusListHttpRequest

- (id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {
    self = [super initWithRequestURL:url httpMethod:httpMethod];
    if(self) {
        self.object = @"home";
    }
    return self;
}

//- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
//
////        self.userId = @"me";
//
//    FLFacebookFetchStatusListResponse* result = FLConfirmResultType([super runOperationWithInput:input], FLFacebookFetchStatusListResponse);
//        
////    NSArray* messages = result.data;
////    [[[self.context storageService] documentsDatabase] batchWriteObjects:messages];
////	
//    return result;
//}

- (void) willSendHttpRequest {

}


- (FLResult) resultFromHttpResponse:(FLHttpResponse*) response {

    return response;
}

@end