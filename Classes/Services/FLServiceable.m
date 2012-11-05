//
//  FLServiceable.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLServiceable.h"

@implementation FLServiceable 

synthesize_(services);

dealloc_ (
    [_services release];
)

@end
