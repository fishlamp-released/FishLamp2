//
//  FLService.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLWorkFinisher.h"
#import "FLCollectionIterator.h"
#import "FLServiceGroup.h"

@interface FLService()
@property (readwrite, assign) id<FLServiceGroup> services;
@end

@implementation FLService

@synthesize services = _services;

- (id) init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif

- (BOOL) isServiceOpen {
    return NO;
}

- (void) openService {
}

- (void) closeService {
}

- (void) wasAddedToSession:(id<FLServiceGroup>) services {
    self.services = services;
}

+ (id) serviceID {
    return NSStringFromClass([self class]);
}


@end