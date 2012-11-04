//
//  FLServiceGroup.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLServiceGroup.h"

@implementation FLServiceGroup

- (id) init {
    self = [super init];
    if(self) {
        _services = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_services release];
    [super dealloc];
}
#endif

- (void) addService:(id<FLService>) appService {
    [appService addObserver:self];
    [self addObserver:appService];

    [_services setObject:appService forKey:[[appService class] serviceID]];
}

- (void) removeService:(id<FLService>) appService {

    [appService removeObserver:self];
    [self removeObserver:appService];

    [_services removeObjectForKey:[[appService class] serviceID]];
}

- (void) openSession {
    for(id<FLService> service in _services.objectEnumerator) {
        [service openService];
    }
}

- (id<FLService>) serviceByID:(NSString*) serviceName {
    return [_services objectForKey:serviceName];
}

- (void) closeSession {
    for(id<FLService> service in _services.objectEnumerator) {
        [service closeService];
    }
}

- (BOOL) isSessionOpen {
    return NO;
}



@end
