//
//  FLZenfolioUserContext.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioUserContext.h"
#import "FLZenfolioSoapHttpRequestFactory.h"
#import "FLDispatchQueue.h"
#import "FLOperation.h"



@implementation FLZenfolioUserContext

@synthesize rootGroup = _rootGroup;

- (id) init {
    self = [super init];
    if(self) {
        self.httpRequestAuthenticator = FLAutorelease([[FLZenfolioRegisteredUserHttpRequestAuthenticator alloc] init]);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {  
    [_rootGroup release];
    [super dealloc];
}
#endif


- (void) logoutUser {
//    [self closeContext];
    self.rootGroup = nil;
//    [self postObservation:@selector(userContextUserDidLogout:)];
}


@end
