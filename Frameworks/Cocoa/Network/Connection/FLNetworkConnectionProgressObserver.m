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

- (void) networkConnectionStarting:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
    
        if(!_progress) {
            if(_onCreateProgress) {
                self.progress = _onCreateProgress(connection);
            }
        }
        
        FLAssertIsNotNil_v(_progress, nil);
        [_progress showProgress];
        
    }];
}

- (void) networkConnectionFinished:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
        if(_progress) {
            [_progress hideProgress];
            FLReleaseWithNil_(_progress);
        }
    }];
}

+ (FLNetworkConnectionProgressObserver*) networkConnectionProgressObserver {
    return FLAutorelease([[[self class] alloc] init]);   
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_onCreateProgress);
    if(_progress) {
        [_progress hideProgress];
        FLRelease(_progress);
    }
    super_dealloc_();   
}
#endif


@end
