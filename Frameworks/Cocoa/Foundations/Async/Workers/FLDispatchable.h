//
//  FLDispatchable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLFinisher.h"
#import "FLResult.h"

typedef void (^FLFinishableBlock)(FLFinisher* finisher);

@protocol FLDispatchable <NSObject>
- (void) performWithFinisher:(FLFinisher*) finisher;

@optional
- (FLFinisher*) startPerforming;
- (FLFinisher*) startPerforming:(FLCompletionBlock) completion;
- (id) runSynchronously;
@end

