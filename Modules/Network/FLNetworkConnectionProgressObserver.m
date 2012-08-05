//
//  FLNetworkConnectionProgressObserver.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/1/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLNetworkConnectionProgressObserver.h"

@implementation FLNetworkConnectionProgressObserver

@synthesize progress = _progress; 
@synthesize onCreateProgress = _onCreateProgress; 

- (void) networkConnectionWillOpen:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
    
        if(!_progress) {
            if(_onCreateProgress) {
                self.progress = _onCreateProgress(connection);
            }
        }
        
        FLAssertIsNotNil(_progress);
        [_progress showProgress];
        
    }];
}

- (void) networkConnectionDidClose:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
        if(_progress) {
            [_progress hideProgress];
            FLReleaseWithNil(_progress);
        }
    }];
}

- (void) networkConnectionDidStopObserving:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
        if(_progress) {
            [_progress hideProgress];
            FLReleaseWithNil(_progress);
        }
    }];
}

- (id) init {
    self = [super init];
    if(self) {
        [self observeEvent:FLNetworkEventWillOpen target:self];
        [self observeEvent:FLNetworkEventDidStopObserving target:self];
        [self observeEvent:FLNetworkEventDidClose target:self];
    }
    
    return self;
}

+ (FLNetworkConnectionProgressObserver*) networkConnectionProgressObserver {
    return FLReturnAutoreleased([[[self class] alloc] init]);   
}

#if FL_DEALLOC
- (void) dealloc {
    [_onCreateProgress release];
    if(_progress) {
        [_progress hideProgress];
        [_progress release];
    }
    [super dealloc];   
}
#endif


@end
