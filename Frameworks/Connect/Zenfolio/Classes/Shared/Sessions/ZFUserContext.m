//
//  ZFUserContext.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFUserContext.h"
#import "ZFSoapHttpRequestFactory.h"
#import "FLDispatchQueue.h"
#import "FLOperation.h"



@implementation ZFUserContext

@synthesize rootGroup = _rootGroup;

- (id) init {
    self = [super init];
    if(self) {
        self.httpRequestAuthenticator = FLAutorelease([[ZFRegisteredUserHttpRequestAuthenticator alloc] init]);
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
