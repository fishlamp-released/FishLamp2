//
//  FLContextuallyDispatchable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDispatchable.h"

@protocol FLContextuallyDispatchable <FLDispatchable>
@optional
- (void) didMoveToContext:(id) context;
- (void) requestCancel;
@end