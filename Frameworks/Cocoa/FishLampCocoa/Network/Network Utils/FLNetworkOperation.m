//
//  FLNetworkOperation.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLNetworkOperation.h"
#import "FLReachableNetwork.h"
#import "FLNetworkConnectionObserver.h"
#import "FLDispatchQueue.h"

@interface FLNetworkOperation ()
@property (readwrite, strong) FLNetworkConnection* connection;
@end

@implementation FLNetworkOperation

@synthesize connection = _networkConnection;

+ (id) networkOperation {
	return autorelease_([[[self class] alloc] initWithURL:nil]);
}

- (void) cancelSelf {
	[super cancelSelf];
    [self.connection requestCancel:nil];
}

- (FLResult) runConnection:(FLNetworkConnection*) connection {
    
    @try {
        self.connection = connection; // so we can cancel it.
        [connection addObserver:self];

        return [[connection openConnection:FLFifoQueue] waitUntilFinished];
    }
    @finally {
         [_networkConnection removeObserver:self];
         self.connection = nil;
    }

    return nil;
}



@end

/*
+ (id) networkOperation:(NSURL*) url {
	return autorelease_([[[self class] alloc] initWithURL:url]);
}

@synthesize URL = _URL;
- (id) initWithURL:(NSURL*) url {
    self = [super init];
    if(self) {
        self.URL = url;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_URL release];
    [super dealloc];
}
#endif

*/