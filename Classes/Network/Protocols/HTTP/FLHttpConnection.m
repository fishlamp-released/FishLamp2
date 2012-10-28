//
//  FLHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpConnection.h"
#import "FLHttpStream.h"

#if DEBUG
#define TEST_TIMEOUT 0
#endif

@interface FLHttpConnection ()
@property (readwrite, strong) FLHttpRequest* httpRequest;
@end

@implementation FLHttpConnection

@synthesize httpRequest = _httpRequest;

- (id<FLNetworkStream>) createNetworkStream {
    return [FLHttpStream httpStream:self.httpRequest];
}

- (id) initWithHttpRequest:(FLHttpRequest*) httpRequest {
    self = [super init];
    if(self) {
        self.httpRequest = httpRequest;
    }
    return self;
}

+ (id) httpConnection:(FLHttpRequest*) httpRequest {
    return FLReturnAutoreleased([[[self class] alloc] initWithHttpRequest:httpRequest]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_httpRequest release];
    [super dealloc];
}
#endif

- (void) httpStream:(FLHttpStream*) httpStream
        shouldRedirect:(BOOL*) redirect
                 toURL:(NSURL*) url {

    [self touchTimestamp];
    
    [self visitObservers:^(id<FLNetworkConnectionObserver> observer, BOOL* stop) { 
        
        if([observer respondsToSelector:@selector(networkConnection:shouldRedirect:toURL:)]) {
            [observer networkConnection:self shouldRedirect:redirect toURL:url];
        }
        
        if(*redirect) {
            *stop = YES;
        }
    }];
}



@end
