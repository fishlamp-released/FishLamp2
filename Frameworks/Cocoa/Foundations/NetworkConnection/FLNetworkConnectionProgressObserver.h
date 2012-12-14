//
//  FLNetworkConnectionProgressObserver.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/1/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//
#import "FLCore.h"

#import "FLNetworkConnectionObserver.h"
#import "FLProgressViewController.h"

typedef id<FLProgressViewController> (^FLNetworkConnectionProgressObserverCreateProgress)(id connection);

@interface FLNetworkConnectionProgressObserver : NSObject<FLNetworkConnectionObserver> {
@private
    id<FLProgressViewController> _progress;
    FLNetworkConnectionProgressObserverCreateProgress _onCreateProgress;
}

+ (FLNetworkConnectionProgressObserver*) networkConnectionProgressObserver;

@property (readwrite, strong, nonatomic) FLNetworkConnectionProgressObserverCreateProgress onCreateProgress;
@property (readwrite, strong, nonatomic) id<FLProgressViewController> progress;

@end
