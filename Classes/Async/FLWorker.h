//
//  FLWorker.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

#import "FLResult.h"
#import "FLPromisedResult.h"
#import "FLFinisher.h"
#import "FLFallible.h"
#import "FLRunnable.h"

@protocol FLWorker <NSObject>
- (void) startWorking:(FLFinisher) finisher;
@end


