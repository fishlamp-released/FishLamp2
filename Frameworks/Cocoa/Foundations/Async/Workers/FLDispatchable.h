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

@protocol FLDispatchable <NSObject>
- (void) startWorking:(FLFinisher*) finisher;
@end

@interface NSObject (FLDispatchable) 
- (id) runSynchronously;
@end

