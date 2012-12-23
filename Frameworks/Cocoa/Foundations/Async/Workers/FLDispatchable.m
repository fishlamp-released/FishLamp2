//
//  FLDispatchable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchable.h"
#import "FLDispatcher.h"

@implementation NSObject (FLDispatcher)

- (SEL) asyncSelectorForDispatch:(id<FLDispatcher>) dispatcher {
    return @selector(startAsync:);
}

- (SEL) synchronousSelectorForDispatch:(id<FLDispatcher>) dispatcher {
    return @selector(runSynchronously);
}


@end



