//
//  FLHttpRequestObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestObserver.h"

@implementation FLHttpRequestObserver 
@synthesize willAuthenticate = _willAuthenticate;
@synthesize didAuthenticate = _didAuthenticate;
@synthesize willOpen = _willOpen;
@synthesize didOpen = _didOpen;
@synthesize willClose = _willClose;
@synthesize didClose = _didClose;
@synthesize encounteredError = _encounteredError;
@synthesize didWriteBytes = _didWriteBytes;
@synthesize didReadBytes = _didReadBytes;
@synthesize didFinish = _observerDidFinish;

#if FL_MRC
- (void) dealloc {
    [_willAuthenticate release];
    [_didAuthenticate release];
    [_willOpen release];
    [_didOpen release];
    [_willClose release];
    [_didClose release];
    [_encounteredError release];
    [_didWriteBytes release];
    [_didReadBytes release];
    [_observerDidFinish release];
    [super dealloc];
}
#endif

#define FLInvokeBlock(b, ...) \
    if(b) { \
        dispatch_async(dispatch_get_main_queue(), ^{ \
            b(__VA_ARGS__); \
        }); \
    }

+ (id) httpRequestObserver {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest {
    FLInvokeBlock(self.didAuthenticate);
}

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest {
    FLInvokeBlock(self.willOpen);
}

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest {
    FLInvokeBlock(self.didOpen);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
   willCloseWithResult:(FLResult) result {
    FLInvokeBlock(self.willClose, result);
}   

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLResult) result {
    FLInvokeBlock(self.didClose, result);
}    

- (void) httpRequest:(FLHttpRequest*) httpRequest
      didEncounterError:(NSError*) error {
    FLInvokeBlock(self.encounteredError, error);
}

- (void) httpRequestDidReadBytes:(FLHttpRequest*) httpRequest  amount:(NSNumber*) amount{
    FLInvokeBlock(self.didReadBytes, amount);
}

- (void) httpRequestDidWriteBytes:(FLHttpRequest*) httpRequest  amount:(NSNumber*) amount {
    FLInvokeBlock(self.didWriteBytes, amount);
}

@end
