//
//  FLRunnable.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLPromisedResult.h"
#import "FLResult.h"

@protocol FLRunnable <NSObject>
- (FLPromisedResult) start:(FLResultBlock) completion;
- (FLResult) runSynchronously;
@end

